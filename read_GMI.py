import netCDF4 as nc

def read_gmi(fname):
    with nc.Dataset(fname) as f:
        #print(f)
        lon_s1 = f['S1/Longitude'][:]
        lat_s1 = f['S1/Latitude'][:]
        tc_S1 = f['S1/Tc'][:]
        lon_s2 = f['S2/Longitude'][:]
        lat_s2 = f['S2/Latitude'][:]
        tc_S2 = f['S2/Tc'][:]
        sc_lat = f['S1/SCstatus/SClatitude'][:]
        sc_lon = f['S1/SCstatus/SClongitude'][:]
        inc_angle_s1=f['S1/incidenceAngle'][:]
        inc_angle_s2=f['S2/incidenceAngle'][:]
        sun_glint_angle_s1=f['S1/sunGlintAngle'][:]
        yy=f['S1/ScanTime/Year'][:]
        mm=f['S1/ScanTime/Month'][:]
        dd=f['S1/ScanTime/DayOfMonth'][:]
        jday=f['S1/ScanTime/DayOfYear'][:]
    return lon_s1, lat_s1, tc_S1, lon_s2, lat_s2, tc_S2, sc_lat, sc_lon, inc_angle_s1, inc_angle_s2, sun_glint_angle_s1,yy,mm,dd,jday


#gmi_data=read_gmi('data/1C-CS-92W47N60W21N.GPM.GMI.XCAL2016-C.20241009-S035045-E035921.060269.V07B.HDF5')
#lon_s1, lat_s1, tc_S1, lon_s2, lat_s2, tc_S2, sc_lat, sc_lon, inc_angle_s1, inc_angle_s2, sun_glint_angle_s1,yy,mm,dd,jday=gmi_data