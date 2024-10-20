import netCDF4 as nc
import numpy as np
#char *jobname, char *f2aku, int *n1c21, 
#float *zKuObs, float *zKaObs, float *snrRatioku, float *snrRatioka, #
#		float *srtPIAku, float *dsrtPIAku, float *dsrtPIAka,
#		float *srtsigmaPIAku, float *dsrtsigmaPIAku, float *dsrtsigmaPIAka,
#		float *sigmaZeroKu, float *sigmaZeroKa, float *sclon, float *sclat,//SJM 2/3/15 //SJM 2/3/15
#		float *xlon, float *xlat, int *badRayFlag, int *rainFlagBad,
#		int *nodes, int *raintype, float *scAngle, int *ic,
#		int *nBSize, float *freezH, float *surfaceZku, 
#		int *iLandOcean, float *srtrelPIAku, float *dsrtrelPIA, 
#		float *piaHB, int *ioqualityflagku, int *ioqualityflagdpr,
#		char *f2ADPR, float *dprrain, int *BBbin, int *binRealSurface,
#		float *localZenithAngle, float *elevation, int *status_alpha,
#		float *secondOfDay, int *NSRelibFlag, int *MSRelibFlag,
#		int *snowIceCover, float *seaIceConcentration, float *cBEst,
#		float *envTemp, int *binClutterFree, int *binZeroDegree

#piaHB[ipia]=L2AKuDataX.SLV.piaFinal[j];


#// srtrelPIAku[ipia]=L2AKuDataX.SRT.reliabFactor[j];
# srtrelPIAku[ipia]=L2AKuDataX.SRT.reliabFactorHY[j];  //WSO 8/2/18 use hybrid factor
#// NSRelibFlag[ipia]=L2AKuDataX.SRT.reliabFlag[j];
# NSRelibFlag[ipia]=L2AKuDataX.SRT.reliabFlagHY[j];    //WSO 8/2/18 use hybrid flag
#raintype[ipia]=L2AKuDataX.CSF.typePrecip[j];
#binRealSurface[ipia]=(L2AKuDataX.PRE.binRealSurface[j]-1)/2;  //WSO 05/01/2014
#localZenithAngle[ipia]=L2AKuDataX.PRE.localZenithAngle[j]; 
#elevation[ipia]=L2AKuDataX.PRE.elevation[j];
#binClutterFree[ipia]=L2AKuDataX.PRE.binClutterFreeBottom[j];
#binZeroDegree[ipia]=L2AKuDataX.VER.binZeroDeg[j];

#snowIceCover[ipia]=L2AKuDataX.PRE.snowIceCover[j];
#seaIceConcentration[ipia]=L2AKuDataX.Experimental.seaIceConcentration[j];
# printf("%5i %8.2f", snowIceCover[ipia], seaIceConcentration[ipia]);
#snrRatioku[ipia] = L2AKuDataX.PRE.snRatioAtRealSurface[j];
#srtPIAku[ipia]=L2AKuDataX.SRT.PIAhybrid[j];  //MG 7/31/18 use hybrid PIA
#srtsigmaPIAku[ipia] = missing_r4c;
#sigmaZeroKu[ipia] = L2AKuDataX.PRE.sigmaZeroMeasured[j];

def read2AKuDPR(f2AKu,f2ADPR,n1,n2):
    with nc.Dataset(f2AKu) as f:
        #print(f)
        zKuObs = f['FS/PRE/zFactorMeasured'][n1:n2]
        binRealSurface = f['FS/PRE/binRealSurface'][n1:n2]
        localZenithAngle = f['FS/PRE/localZenithAngle'][n1:n2]
        elevation = f['FS/PRE/elevation'][n1:n2]
        binClutterFree = f['FS/PRE/binClutterFreeBottom'][n1:n2]
        binZeroDegree = f['FS/VER/binZeroDeg'][n1:n2]
        piaHB = f['FS/SLV/piaFinal'][n1:n2]
        srtrelPIAku = f['FS/SRT/reliabFactorHY'][n1:n2]
        NSRelibFlag = f['FS/SRT/reliabFlagHY'][n1:n2]
        raintype = (f['FS/CSF/typePrecip'][n1:n2]/1e7).astype(int)
        snowIceCover = f['FS/PRE/snowIceCover'][n1:n2]
        seaIceConcentration = f['FS/Experimental/seaIceConcentration'][n1:n2]
        snrRatioku = f['FS/PRE/snRatioAtRealSurface'][n1:n2]
        srtPIAku = f['FS/SRT/PIAhybrid'][n1:n2]
        srtsigmaPIAku = srtPIAku.copy()*0-9999
        sigmaZeroKu = f['FS/PRE/sigmaZeroMeasured'][n1:n2]
        #freezH[ipia]=L2AKuDataX.VER.heightZeroDeg[j];
        freeZH = f['FS/VER/heightZeroDeg'][n1:n2]
        #L2AKuDataX.VER.airTemperature
        envTemp = f['FS/VER/airTemperature'][n1:n2]
        #missing_flag     = L2AKuDataX.scanStatus.missing;
        #dataquality_flag = L2AKuDataX.scanStatus.dataQuality;
        #modestatus_flag  = L2AKuDataX.scanStatus.modeStatus;
        missing_flag = f['FS/scanStatus/missing'][n1:n2]
        dataquality_flag = f['FS/scanStatus/dataQuality'][n1:n2]
        modestatus_flag = f['FS/scanStatus/modeStatus'][n1:n2]
        #iLandOcean[ipia]=L2AKuDataX.PRE.landSurfaceType[j];
	    #flagPrecip[ipia]=L2AKuDataX.PRE.flagPrecip[j];
	    #sfcRain[ipia]=L2AKuDataX.SLV.precipRateNearSurface[j];
        iLandOcean = f['FS/PRE/landSurfaceType'][n1:n2]
        flagPrecip = f['FS/PRE/flagPrecip'][n1:n2]
        sfcRain = f['FS/SLV/precipRateNearSurface'][n1:n2]
        #xlon[ipia]=L2AKuDataX.Longitude[j];
	    #xlat[ipia]=L2AKuDataX.Latitude[j];
        xlon=f['FS/Longitude'][n1:n2]
        xlat=f['FS/Latitude'][n1:n2]
        #yyyy=L2AKuDataX.ScanTime.Year;                 //4/14/14 MG Begin
        #jday=L2AKuDataX.ScanTime.DayOfYear;
        yy=f['FS/ScanTime/Year'][n1:n2]
        jday=f['FS/ScanTime/DayOfYear'][n1:n2]
        #L2AKuDataX.PRE.binStormTop
        #L2AKuDataX.CSF.binBBPeak
        #L2AKuDataX.VER.binZeroDeg
        #L2AKuDataX.PRE.binClutterFreeBottom
        binStormTop = f['FS/PRE/binStormTop'][n1:n2]
        binBBPeak = f['FS/CSF/binBBPeak'][n1:n2]
        binZeroDeg = f['FS/VER/binZeroDeg'][n1:n2]
        binClutterFree = f['FS/PRE/binClutterFreeBottom'][n1:n2]
        node5=np.zeros((n2-n1,49,5))
        node5[:,:,0]=binStormTop[n1:n2]//2

        a=np.nonzero(binBBPeak[n1:n2]>0)
        node5[:,:,2]=binZeroDeg[n1:n2]//2
        node5[:,:,1]=node5[:,:,2]-3
        node5[:,:,3]=node5[:,:,2]+2
        for i1,j1 in zip(a[0],a[1]):
            node5[i1,j1,2]=binBBPeak[i1,j1]//2
            node5[i1,j1,1]=node5[i1,j1,2]-3
            node5[i1,j1,3]=node5[i1,j1,2]+2
        node5[:,:,4]=binClutterFree[n1:n2]//2
        
    with nc.Dataset(f2ADPR) as f:
        zKaObs=f['FS/PRE/zFactorMeasured'][n1:n2,:,:,1]
        #dprxswath.FS.SRT.pathAtten
        dsrtPIAKa= f['FS/SRT/pathAtten'][n1:n2,:,1]
        dsrtPIAKu= f['FS/SRT/pathAtten'][n1:n2,:,0]
        #dsrtrelPIA[ipia]=dprxswath.FS.SRT.reliabFactor[j];
	    #MSRelibFlag[ipia]=dprxswath.FS.SRT.reliabFlag[j];
        dsrtrelPIA = f['FS/SRT/reliabFactor'][n1:n2]
        MSRelibFlag = f['FS/SRT/reliabFlag'][n1:n2]
        #dsrtsigmaPIAku[ipia] = dprxswath.FS.SRT.pathAtten[j][0] / dprxswath.FS.SRT.reliabFactor[j];
        dsrtsigmaPIAku = dsrtPIAKu[:,:]
        dsrtsigmaPIAku[srtrelPIAku>0] = dsrtPIAKu[srtrelPIAku>0] / srtrelPIAku[srtrelPIAku>0]
        dsrtsigmaPIAku[srtrelPIAku<=0] = -9999

    return zKuObs,binRealSurface,localZenithAngle,elevation,binClutterFree,binZeroDegree,piaHB,srtrelPIAku,NSRelibFlag,raintype,snowIceCover,seaIceConcentration,snrRatioku,srtPIAku,srtsigmaPIAku,sigmaZeroKu,freeZH,envTemp,missing_flag,dataquality_flag,modestatus_flag,iLandOcean,flagPrecip,sfcRain,zKaObs,dsrtPIAKa,dsrtPIAKu,dsrtrelPIA,MSRelibFlag,dsrtsigmaPIAku,xlon,xlat,yy,jday,node5.astype(int)
f2AKu = 'data/2A-CS-92W47N60W21N.GPM.Ku.V9-20240130.20241009-S035207-E035919.060269.V07C.HDF5'
f2ADPR = 'data/2A-CS-92W47N60W21N.GPM.DPR.V9-20240130.20241009-S035207-E035919.060269.V07C.HDF5'
data_2aku=read2AKuDPR(f2AKu,f2ADPR,0,300)
