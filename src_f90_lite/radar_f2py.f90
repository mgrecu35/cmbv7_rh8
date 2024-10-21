!void f_model_fortran_(float *z13obs, float *z35obs, 
!		   int nodes[5], int *isurf, int *imu,
!		   float *log10dNP, int *nodeP, int nNodes, 
!		   float *pia35M, float *pia13M,
!		   float *z35mod, float *pwc, float *dr, int *ic, int *jc, 
!		   float *hh,
!		   float *delta, int *iNode, int *nmfreq, 
!		   float *salb, float *kext,float *asym, int *itype,
!		   int *ngates,float *rrate,float *d0,float *log10dN,
!		   float *z13, float *z35,
!		   int *imuv, float *hfreez,
!		   float *pia13srt, 
!		   float *pia35srt,
!		   int *imemb,
!		   float *xs,  float *nstdA)

subroutine fmodel_wrapper(z13, z35, z13obs, z35obs, nodes, isurf, imu, log10dNin, pia35M, pia13M, &
    z35mod, pwc, dr, ic, jc, nmfreq, salb, kext, asym, itype, ngates, rrate, dm, &
    log10dN, hfreez, pia13srt, pia35srt, imemb, localZAngle, &
    wfractPix, xs, ichunk, nstdA, reliabFlag_py)
    use gEnv
    implicit none
    integer :: imemb, reliabFlag_py, i, iNode=1
    real, intent(in) :: z13obs(ngates), z35obs(ngates)
    integer, intent(in) :: nodes(5), isurf, imu, ic, jc, nmfreq, itype, ngates, ichunk
    real, intent(out) :: salb(ngates,nmfreq), kext(ngates,nmfreq), asym(ngates,nmfreq), rrate(ngates), dm(ngates), &
        log10dN(ngates), &
        z13(ngates), z35(ngates), z35mod(ngates), pwc(ngates), pia35M, pia13M
    real :: hh(ngates), dr 
    real :: delta=0, dz=0
    real, intent(in) :: hfreez,  pia13srt, pia35srt, localZAngle, wfractPix, xs(15), nstdA
    real, intent(in) :: log10dNin(ngates)
    integer :: nodes_f(5)
    integer ::  imuv(ngates)
    imuv=imu
    reliabFlag=reliabFlag_py
    do i=1,ngates
        hh(i) =(ngates-i)*dr*cos(localZAngle/180.*3.1415)
    end do
    nodes_f=nodes+1
    log10dN=log10dNin
    call f_model_fortran(z13obs, z35obs, nodes, isurf, imu, pia35M, pia13M, z35mod, pwc, &
        dr, ic, jc, hh, delta, iNode, nmfreq, salb, kext, asym, itype, ngates, rrate, dm, log10dN, z13, z35, imuv, hfreez,&
        pia13srt, pia35srt,  imemb, xs, nstdA)
end subroutine fmodel_wrapper

!extern "C" void f_model_fortran_(float *z13obs, float *z35obs, 
!		   int nodes[5], int *isurf, int *imu,
!		   float *pia35M, float *pia13M,
!		   float *z35mod, float *pwc, float *dr, int *ic, int *jc, 
!		   float *hh,
!		   float *delta, int *iNode, int *nmfreq, 
!		   float *salb, float *kext,float *asym, int *itype,
!		   int *ngates,float *rrate,float *d0,float *log10dN,
!		   float *z13, float *z35,
!		   int *imuv, float *hfreez,
!		   float *pia13srt,
!		   float *pia35srt, 
!		   int *imemb,
!		   float *xs,  float *nstdA)