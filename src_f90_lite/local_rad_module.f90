module local_RD_var
  use f90Types
  real :: covTb(49,300,15,15), tbMax(49,300,15), tbMin(49,300,15), &
       tbMean(49,300,15)
  real :: invCovTb(49,300,15,15)
  real :: tbout2D(49,300,15), tb(49,300,15), tbNoOcean(49,300,15), &
       tbout2DNoOcean(49,300,15), tbObs(49,300,15)
  real :: dfdtb(49,300,15), rerr(15), tb0(49,300,15), fem(15) , &
       tb0MS(49,300,15), tbNoOceanMS(49,300,15), tbout2DNoOceanMS(49,300,15),&
       tbout2DMS(49,300,15)
  integer :: ipol(15), ifreq(15), iobs(15), ifreq1
  integer :: ifreqG(15), ipolG(15) 
  integer,parameter :: nbinL=88
  real :: sfcRain(49,300),sfcRainStd(49,300)
  real :: rRate3D(nbinL,49,300),  rRate3Dstd(nbinL,49,300)
  real :: pwc3D(nbinL,49,300),  pwc3Dstd(nbinL,49,300)
  real :: zcKu3D(nbinL,49,300), d03D(nbinL,49,300), piaOut(49,300)

  real :: sfcRainMS(49,300),sfcRainStdMS(49,300),pia35m(49,300)
  real :: rRate3DMS(nbinL,49,300),  rRate3DstdMS(nbinL,49,300)
  real :: pwc3DMS(nbinL,49,300),  pwc3DstdMS(nbinL,49,300)
  real :: zcKu3DMS(nbinL,49,300), zcKa3DMS(nbinL,49,300), d03DMS(nbinL,49,300), &
          piaOutKuMS(49,300), piaOutKaMS(49,300)
  real, allocatable :: emissoutL(:,:,:), emis_out_NS(:,:,:), emis_out_MS(:,:,:) !sjm 8/10/15
  type (stormStructType) :: stormStruct
  real, allocatable ::  Yens(:,:), Xens(:,:), Yobs(:), Xup(:)
  real, allocatable :: geoloc(:), hFreqTbs(:,:), PRgeoloc(:), hFreqPRg(:,:,:)
  real, allocatable :: ndn(:), ndnp(:,:), xscalev(:), logdNwf(:), randemiss(:), dwind(:)
  real, allocatable  :: rhPCij(:,:), cldwPCij(:,:)
  type (radarRetType)    :: radarRet
  type (radarDataType)   :: radarData
  real :: emis_eofs(100,12) !SJM 7/9/2015
  real :: scLatPR(49,300),scLonPR(49,300),wfmap(49,300), fpmap(49,300,15), fpmapN(49,300,15)
  real :: w10(49,300), w10_out_NS(49,300), w10_out_MS(49,300), w10_min, w10_max, emis, relAz
  real :: w10_rms_NS(49,300), emis_rms_NS(49,300,13), w10_rms_MS(49,300), emis_rms_MS(49,300,13)
  real :: S1eiaPR(49,300), S2eiaPR(49,300)
  real :: sigmaZeroVarKu(49,300), sigmaZeroVarKa(49,300), sigmaZeroCov(49,300)
  integer :: iiad
  real :: dZms(49,300) !! MS addition Feb 10, 2017
  integer :: msFlag(49, 300) !!WSO addition Feb 11, 2017

end module local_RD_var
