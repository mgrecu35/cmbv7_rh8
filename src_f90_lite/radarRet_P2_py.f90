

subroutine get_rain_type(raintype, nscans)
  use globalData
  integer :: raintype(49,300)
  integer :: nscans
  raintype=dPRData%rainType
  nscans=dPRData%n1c21
  print*, nscans
end subroutine get_rain_type

subroutine testr(it)
  integer :: it
  it=136
end subroutine testr

subroutine radarRetSub2(sysdN_py,nmemb1, nmu2, nmfreq2)
!  SFM  end    12/13/2013
  use local_RD_var
  !use globalData
  use f90DataTypes
  use f90Types
  use cldclass
  use ran_mod
  !use geophysEns
  use nbinMod
  !use tables2
!  use weight
!  Use BMCVparameters
!  use emissMod
!begin  MG 10/29/15 add gEnv module
!  use gEnv
!end    MG 10/29/15
!begin  WSO 9/14/13 incorporate missing flags
  use missingMod

  use outputminmax

  implicit none

  integer :: nmu2, nmfreq2
  integer*4 :: ichunk
  type (retParamType)    :: retParam
   
  !real :: cldw(nlayer), rh(nlayer)
 
  real :: cldwprof(88), cldiprof(88), log10NwMean(88), mu_mean_prof(88)
  integer *2 :: env_nodes(10, 49)
  real :: env_levs(10), ray_angle, pi


  integer,parameter :: nscans=300, npixs=25, nlev=88, nchans=13
  integer :: nfreq, idir
  integer :: nmemb1, ngates=88!, ncld=50
  real :: sysdN_py
  data env_levs/18., 14., 10., 8., 6., 4., 2., 1., 0.5, 0./
  data pi/3.14159265/
  
  print*, nmemb1, nmu2, nmfreq2

end subroutine radarRetSub2


subroutine dealloc_struct(i)
  use local_RD_var
  use geophysEns
  print*,i
  IF (ALLOCATED(emissoutL)) deallocate(emissoutL)
  if(allocated(hFreqPRg)) deallocate(hFreqPRg)

  IF (ALLOCATED(Yobs)) deallocate(Yobs)
  IF (ALLOCATED(Xup)) deallocate(Xup)
  IF (ALLOCATED(randemiss)) deallocate(randemiss)
  IF (ALLOCATED(Xens)) deallocate(Xens)
  IF (ALLOCATED(Yens)) deallocate(Yens)

  call deallocGeophys()
  call deallocateStormStructData(stormStruct)
  call deallocateDPRProfRet(radarRet)
  call deallocateDPRProfData(radarData)
  
  IF (ALLOCATED(ndn)) deallocate(ndn) 
  IF (ALLOCATED(xscalev)) deallocate(xscalev) 
  IF (ALLOCATED(logdnwf)) deallocate(logdnwf) 
  IF (ALLOCATED(ndnp)) deallocate(ndnp) 
  IF (ALLOCATED(rhPCij)) deallocate(rhPCij)
  IF (ALLOCATED(cldwPCij)) deallocate(cldwPCij)

end subroutine dealloc_struct

subroutine dealloc_chunk(i)
  use globalData
  integer :: i
  print*, i
  call deallocateDPRRetSpace(dPRRet)
  call deallocateHRescGMI(gmiData,gmi2Grid)
end subroutine dealloc_chunk
