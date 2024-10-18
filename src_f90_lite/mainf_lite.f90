!! SFM 05/06/2013  Modifications from LW to facilitate using job names
!! SFM 07/19/2013  Modifications from ngniM.Grecu for convergence problem
!! SFM 08/09/2013  Eliminate IF2ADPROUT dependences; few extra diagnostics
!!
!microwave table freq 19.0 37. 10. 85
!TMIchannel freq  10.0, 19.0, 21, 37, 85! V,H
!npol 0 H, npol 1 V


SUBROUTINE init_random_seed(rseed1, rseed2)
  INTEGER :: rseed1, rseed2, n, clock
  INTEGER, DIMENSION(:), ALLOCATABLE :: seed

  CALL RANDOM_SEED(size = n)
  ALLOCATE(seed(n))

  if(rseed1.le.-1) then
    ! Don't set seed - what delivered code does.
  elseif(rseed1.eq.0) then
    CALL SYSTEM_CLOCK(COUNT=clock)
    seed = clock + 37 * (/ (i - 1, i = 1, n) /)
    CALL RANDOM_SEED(PUT = seed)
  else
    seed = rseed1 + 37 * (/ (i - 1, i = 1, n) /)
    if(rseed2.gt.0) then
      seed(2) = rseed2
    endif
    CALL RANDOM_SEED(PUT = seed)
  endif

  CALL RANDOM_SEED(GET = seed)
  rseed1 = seed(1)
  rseed2 = seed(2)
  DEALLOCATE(seed)
END SUBROUTINE init_random_seed

SUBROUTINE init_random_seed2()
  INTEGER :: i, n, clock
  INTEGER, DIMENSION(:), ALLOCATABLE :: seed
  
  CALL RANDOM_SEED(size = n)
  ALLOCATE(seed(n))
  
  CALL SYSTEM_CLOCK(COUNT=clock)
  
  seed = clock + 37 * (/ (i - 1, i = 1, n) /)
  CALL RANDOM_SEED(PUT = seed)
  
  DEALLOCATE(seed)
END SUBROUTINE init_random_seed2

!begin 2/9/22 WSO pass status of 2nd GMI file
subroutine mainfort()
!end 2/9/22

  use iso_c_binding    !iso c binding statement
  use globalData
  !use gfsmodel        ! SFM  04/16/2014  deleted
  !use emissmod
  use nbinmod
!begin  WSO 9/14/13
  use missingMod
!end    WSO 9/14/13
!begin WSO 8/7/13
  use Tables_frac
!  use writeENKF
!end WSO 8/7/13

  implicit none
  integer :: rseed1, rseed2, ifs
  real :: tbRgrid(14,49,9300)  ! resampled brightness temperatures on same grid 
                              !   as 2adpr data; (channel/ray/scan)


!  SFM  04/06/2013  Changed file name lengths to 1000
  character(c_char) :: jobname(255), f1ctmi1(1000), f1ctmi2(1000), &
       f1ctmi3(1000), f2AKu(1000), f2aDPR(1000), f2AKuENV(1000), f2CMB(1000)
  character(c_char) :: fSNOW(1000), fSEAICE(1000)
  character(c_char) :: outcmb(1000) !iso c binding

  integer :: igmi1, igmi2, igmi3, i2AKu, i2ADPR, i2AKuENV, i2CMB, ialg
  integer :: iSNOW, iSEAICE
  integer :: i1ctmi, i1c21, i2a23
  real    :: mu
  integer :: nGMIS1, nGMIS2, nS1f, nS2f, nchunks
  character*3 :: ifdpr
  INTEGER*4 :: orbitNumber    ! retrieved orbit number
  integer :: ngmi1,ngmi2,ngmi3, j
  integer :: isnow1, iseaice1, ndpr1
  real    :: lastGood          !  SFM  04/16/2014   added for M.Grecu
  
  character*90 :: lut_file !SJM 7/9/2014

!  SFM  start  09/25/2013
  character(16), parameter :: algorithmVersion = "2BCMB_20240122"
  !  SFM  end  09/25/2013
!  SFM  start  09/27/2013
!...Variables required for implementation of autosnow option
!  SFM  start  10/25/2013  for LW
    integer    :: date(3)=(/0,0,0/), istat,    kk1, kk2
!  SFM  end    10/25/2013  for LW
    integer(1) :: autosnow(9000,4500)                 !4km global grid
!  SFM  end    09/27/2013

!...Allocate storage space and array size parameters for new data files

    TYPE (Lv2AKuENV_DataType)  :: Lv2AKuENV_scan
    INTEGER :: nscan_2akuenv, nray2akuenv, nbin2akuenv, nwater, nwind

!  SFM  start  01/02/2014
   
    INTEGER*4     date_number      ! file date in format yyyymmdd
    INTEGER*4     month_get        ! computed file month
    INTEGER*4     st_1, st_2, st_3 ! status codes for 1CGMI files
 
    INTEGER*4     readgmi, readtmi         ! declare function
    INTEGER*4     readenv, readenvx          ! declare function
    INTEGER*4     readdprpflag, readdprpflagx     ! declare function
    !LW 05/04/18
    INTEGER*4     readdprtpflag     ! declare function

    integer*4     i, ifract, idir
    real :: x1L, x2L
!  SFM  end    01/02/2014
!begin 2/9/22 WSO status code for 2nd 1CGMI file
    integer *4    st_GMI2
!end 2/9/22
  
!  SFM  04/06/2013  Added code and supporting datasets for query_2akuenv, 
!                     allocate_2AKuENV_space, and read_2kauenv 
!  SFM  06/19/2013  Code from M.Grecu integrated

  rec=0
  
  mu=cos(52.8/180*3.14159)
  do i=1,7
     !call mie2(i-3.)
  enddo
  
  nmfreq=8
  nmu=5
  call init_random_seed(rseed1,rseed2)
  print *, 'Random Seeds : ',rseed1,rseed2
  print*, ialg
  print*, f2AKu(1:i2AKu) 
  print*, f2aDPR(1:i2adpr)
  !stop
  call readtablesLiang2(nmu,nmfreq)         !This option reads in Liang's mu=2 table
  !call readtablesDSDWG(nmu,nmfreq) !Replaces Liang's DSD table with DSD working group relationships (rain only)
  
  call makeHashTables()
  call cloud_init(nmfreq) 
  call initWFlag(nmfreq)
  !call readcluttertables()
  !call readclutter_bzd_tables()
  call init_nbin
  !begin  WSO 9/14/13 initial missing flags in missingMod
  call init_missing_flags
  !end    WSO 9/14/13

  !begin WSO 8/7/13
  call read_melt_percentages
  !end WSO 8/7/13

  !begin SJM 7/9/2014 read emissivity and sigma_zero LUTs
  !lut_file = 'Emiss/LUT.GMI.emis.MW_ITE101.bin'
  !call read_LUTwatemis(lut_file)
  !lut_file = 'Emiss/LUT.DPR.sigma0.MWopt.GANAL_V5.bin'
  !call read_lutwatsigma0(lut_file)
  !end SJM 7/9/2014
  !read in emissivity-sigma0 EOFs
  !lut_file = 'GANAL_ITE030.V04'
  !call read_LUTlandclass(lut_file)
 
  !end SJM 7/9/2014
  nmF=4
  if(.not.(allocated(ip))) &      
       allocate(ip(nMF), iGMIChan(nMF), iSimF(nMF), iGMIf(nMF))
  
  nPrScanM = 300; ngates=nbin; ndPRrays=49;
  nGMIMax  = 3900; nGMIS1=9; nGMIS2=4; nGMIrays=221;
  gridData%dx=0.05
  print*, 'read the dm-nw data'
  call readdmnw()

!  SFM  end    01/02/2014
!  SFM  end    04/10/2014

  !  iwENKF=0
  print*, 'read the geodat data'
  call read_geodat(geoData%lsflag, geoData%sstdata)

!  SFM  start  12/06/2013  reworked checks for nil and dead files
  nS1f=9
  nS2f=4
  ngmi_total = 0
  
  call allocatecGMISpace(gMIData, nS1f, nS2f, nGMIrays, nGMIMax, nmfreq, nmemb)


end subroutine mainfort

