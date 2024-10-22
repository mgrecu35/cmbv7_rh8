subroutine fmodel_all_profs_omp(nprofs,z13, z35, z13obs, z35obs, nodes, isurf, imu, log10dNin, pia35M, pia13M, &
    z35mod, pwc, dr, ic, jc, nmfreq, salb, kext, asym, itype, ngates, rrate, dm, &
    log10dN, hfreez, pia13srt, pia35srt, imemb, localZAngle, &
    wfractPix, xs, ichunk, nstdA, reliabFlag_py)
    use gEnv
    implicit none
    integer :: imemb, reliabFlag_py(nprofs), i, nprofs,iNode=1
    real, intent(in) :: z13obs(nprofs,ngates), z35obs(nprofs,ngates)
    integer, intent(in) :: nodes(nprofs,5), isurf(nprofs), imu(nprofs), ic, jc, nmfreq, itype(nprofs),&
        ngates, ichunk
    real, intent(out) :: salb(nprofs,ngates,nmfreq), kext(nprofs,ngates,nmfreq), asym(nprofs,ngates,nmfreq), &
        rrate(nprofs,ngates), dm(nprofs,ngates), &
        log10dN(nprofs,ngates), &
        z13(nprofs,ngates), z35(nprofs,ngates), z35mod(nprofs,ngates), pwc(nprofs,ngates), pia35M(nprofs), pia13M(nprofs)
    real :: hh(ngates), dr 
    real :: delta=0, dz=0
    real, intent(in) :: hfreez(nprofs),  pia13srt(nprofs), pia35srt(nprofs), localZAngle(nprofs), wfractPix(nprofs), xs(nprofs,15), nstdA(nprofs)
    real, intent(in) :: log10dNin(nprofs,ngates)
    integer :: nodes_f(5)
    integer ::  imuv(ngates)
    integer :: iprof
    integer :: threads, omp_get_num_threads, iens
    !call omp_set_num_threads(3)   
    !threads = omp_get_num_threads()

    !print *,"there are",  threads, "threads"
    !$OMP PARALLEL DO PRIVATE(iprof,imuv, nodes_f, hh, log10dN)
    do iprof=1,nprofs
        if (iprof.eq.1) then
            call omp_set_num_threads(8)
        end if
        if (iprof.eq.1000) then
            threads = omp_get_num_threads()
            print *,"there are",  threads, "threads inside the loop"
        end if
        imuv=imu(iprof)
        reliabFlag=reliabFlag_py(iprof)
        do i=1,ngates
            hh(i) =(ngates-i)*dr*cos(localZAngle(iprof)/180.*3.1415)
        end do
        nodes_f=nodes(iprof,:)+1
        log10dN(iprof,:)=log10dNin(iprof,:)
        do iens=1,10
            call f_model_fortran(z13obs(iprof,:), z35obs(iprof,:), nodes(iprof,:), isurf(iprof), imu(iprof),&
            pia35M(iprof), pia13M(iprof), z35mod(iprof,:), pwc(iprof,:), &
            dr, ic, jc, hh, delta, iNode, nmfreq, salb(iprof,:,:), kext(iprof,:,:), asym(iprof,:,:),&
            itype(iprof), ngates, rrate(iprof,:), dm(iprof,:), log10dN(iprof,:), z13(iprof,:), z35(iprof,:), imuv, hfreez(iprof),&
            pia13srt(iprof), pia35srt(iprof),  imemb, xs(iprof,:), nstdA(iprof))
        end do
    end do
    !$OMP END PARALLEL DO 
end subroutine fmodel_all_profs_omp