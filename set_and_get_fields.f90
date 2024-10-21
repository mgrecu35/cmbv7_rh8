subroutine set_gmi_data(tc_S1,lat_s1, lon_s1, tc_S2,lat_s2, lon_s2, ngmi_total_py,nchan_s1,nfov_s1,&
                        nchan_s2,nfov_s2, sc_lon, sc_lat, inc_angle_S1, inc_angle_S2, mm, jday_py, tpw_out)
    use globalData
    integer, intent(in) :: ngmi_total_py, nchan_s1, nfov_s1
    real, dimension(nchan_s1,nfov_s1,ngmi_total_py), intent(in) :: tc_S1
    real, dimension(nfov_s1,ngmi_total_py), intent(in) :: lat_s1, lon_s1
    real, dimension(nchan_s2,nfov_s2,ngmi_total_py) :: tc_S2
    real, dimension(nfov_s2,ngmi_total_py) :: lat_s2, lon_s2
    real, dimension(ngmi_total_py) :: sc_lon, sc_lat
    real, dimension(nfov_s1,ngmi_total_py) :: inc_angle_S1, inc_angle_S2
    integer, intent(in) :: nchan_s2, nfov_s2, mm, jday_py
    real, intent(out) :: tpw_out(nfov_s1,ngmi_total_py)
    ngmi_total = ngmi_total_py
    jday = jday_py
    gMIData%gmiS1(:,:,1:ngmi_total_py)=tc_S1(:,:,:)
    gmiData%S1lat(:,1:ngmi_total_py)=lat_s1(:,1:ngmi_total_py)
    gmiData%S1lon(:,1:ngmi_total_py)=lon_s1(:,1:ngmi_total_py)
    gmiData%gmiS2(:,:,1:ngmi_total_py)=tc_S2(:,:,:)
    gmiData%S2lat(:,1:ngmi_total_py)=lat_s2(:,1:ngmi_total_py)
    gmiData%S2lon(:,1:ngmi_total_py)=lon_s2(:,1:ngmi_total_py)
    gmiData%nS1f=nchan_s1
    gmiData%nS2f=nchan_s2
    gmiData%nrays=nfov_s1
    gmiData%n1b11=ngmi_total_py
    gmiData%SCLon(1:ngmi_total_py)=sc_lat(1:ngmi_total_py)
    gmiData%SCLat(1:ngmi_total_py)=sc_lon(1:ngmi_total_py)
    gmiData%S1eia(:,1:ngmi_total_py)=inc_angle_S1(:,1:ngmi_total_py)
    gmiData%S2eia(:,1:ngmi_total_py)=inc_angle_S2(:,1:ngmi_total_py)
    gmiData%mm=mm
    !gmiData%year=year_py
    !gmiData%jday=jday
    !gmiData%dd=dd


        !     gMIData%gmiS2(:,:,ngmi_total+1:ngmimax),gMIData%S1lon(:,ngmi_total+1:ngmimax),  &
        !     gMIData%S1lat(:,ngmi_total+1:ngmimax),                                          &
        !     gMIData%gmilon(ngmi_total+1:ngmimax), gMIData%gmilat(ngmi_total+1:ngmimax),     &
        !     gmiData%mm,year,jday,dd,1,gmiData%secondOfDay(ngmi_total+1:ngmimax),&
        !     gmiData%SCLon(ngmi_total+1:ngmimax),&
        !     gmiData%SCLat(ngmi_total+1:ngmimax),&
        !     gMIData%S2lon(:,ngmi_total+1:ngmimax),  &
        !     gMIData%S2lat(:,ngmi_total+1:ngmimax), &
        !     GMIdata%S1eia(:,ngmi_total+1:ngmimax), &
        !     GMIdata%S2eia(:,ngmi_total+1:ngmimax)
  print*, 'got before param_set'
  
  call param_set_BMCV(5) 
  !print*, 'got here'
  
  tbRgrid=-99             ! set to default

  !print*, gmiData%n1b11
  !print*, gmiData%mm
  !print*, 'read water fraction'
  call readwfract()
  !return
  call sst2(gmiData,geoData,gMIData%mm,gMIData%n1b11)
  tpw_out(:,1:gMIData%n1b11)=gmiData%tpw(:,1:gMIData%n1b11)
  !return
end subroutine set_gmi_data