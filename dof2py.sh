#!/bin/bash
export FC=gfortran
recompile=0
if [ $recompile -eq 1 ]; then
    $FC -c -fPIC src_f90_lite/f90DataTypes.f90
    $FC -c -fPIC src_f90_lite/nbin.f90
    $FC -c -fPIC src_f90_lite/random.f90
    $FC -c -fPIC src_f90_lite/writegif.f90
    $FC -c -fPIC src_f90_lite/globModule.f90
    $FC -c -fPIC src_f90_lite/weightModule.f90
    $FC -c -fPIC src_f90_lite/missing_flags.f90
    $FC -c -fPIC src_f90_lite/readTables_nonsph.f90
    $FC -c -fPIC src_f90_lite/cloud.f90
    $FC -c -fPIC src_f90_lite/f90Types.f90
    $FC -c -fPIC src_f90_lite/allocateMem.f90
    $FC -c -fPIC src_f90_lite/absorb.f
    $FC -c -fPIC src_f90_lite/bisection.f90
    $FC -c -fPIC src_f90_lite/gcloud.f
    gcc -c -fPIC src_c_lite/geomask.c
    $FC -c -fPIC -fdec MeltFrac/read_melt_percentages.f90
#gcc -c -fPIC src_c_lite/clutterCorrection.c
    g++-14 -c -fPIC -DGFOR -I src_c_lite/ src_c_lite/ensFilter.cc
    g++-14 -c -fPIC -DGFOR -I src_c_lite/ src_c_lite/fModelFortran.NUBF.cc
    $FC -c -fPIC src_f90_lite/gEnv.f90
    $FC -c -fPIC src_f90_lite/geophysEns.f90
    $FC -c -fPIC src_f90_lite/fhb1_noNaN.f90
    $FC -I . -c -fPIC src_sjm/lut_routines_sjm.f90
    $FC -c -fPIC src_f90_lite/rterain.f90
    $FC -c -fPIC src_f90_lite/band_dble.f90
    $FC -c -fPIC src_f90_lite/emissModule.f90 
    $FC -I . -c -fPIC src_sjm/gmi_ocean_ret_raob.f90
    $FC -c -fPIC src_sjm/GMIRetTypes.f90
    $FC -I . -c -fPIC src_sjm/GMIRet.f90 
    $FC -c -fPIC src_f90_lite/radtran_tau_dble.f
    $FC -c -fPIC src_sjm/atm_routines.f90
    $FC -I . -c -fPIC src_sjm/atm_routines.f90
    $FC -I . -c -fPIC src_sjm/calcPIA.f90
    gcc -c -fPIC src_c_lite/dboux.c
    $FC -I . -c -fPIC src_f90_lite/rosen.f
    $FC -I . -c -fPIC src_sjm/fmodel.f90
    $FC -I . -c -fPIC src_sjm/check_nan.f90
    $FC -I . -c -fPIC src_f90_lite/ezlhconv.f90
    gcc -c -fPIC src_c_lite/readNh.c
    $FC -I . -c -fPIC src_sjm/gmi_land_ret.f90
    $FC -I . -c -fPIC src_f90_lite/retTablesInt.half.f90
    $FC -I . -c -fPIC src_sjm/oe_routines.f90
    $FC -I . -c -fPIC src_sjm/algebra.f90
    $FC -I . -c -fPIC src_sjm/normal.f90
    $FC -I . -c -fPIC src_f90_lite/beamConvP.f90 
    $FC -I . -c -fPIC src_f90_lite/beamConvSet.f90 
    $FC -I . -c -fPIC src_f90_lite/sst.rend.f90
    gcc -I . -c -fPIC src_c_lite/screenocean.c
    $FC -I . -c -fPIC src_f90_lite/asciiCon.f90
    $FC -I . -c -fPIC src_f90_lite/outputminmax.f90
    $FC -I . -c -fPIC src_f90_lite/radarRet_P2.f90
    gcc -I . -c -fPIC src_c_lite/clearsc.c
    $FC -c -fPIC src_f90_lite/convAllFreq.f90
    $FC -c -fPIC src_f90_lite/conPix2.py.f90
    $FC -c -fPIC src_f90_lite/resampGMI.f90
    $FC -c -fPIC src_f90_lite/radarRet_P2_py.f90
    $FC -c -fPIC src_f90_lite/radarRet.f90
    $FC -c -fPIC src_f90_lite/latlon.f90
    $FC -c -fPIC src_f90_lite/interpol.f90
    $FC -c -fPIC src_f90_lite/setOpt.f90
    $FC -c -fPIC src_f90_lite/local_rad_module.f90
    $FC -c -fPIC src_f90_lite/cloud.f90
    $FC -c -fPIC src_f90_lite/allocateMem.f90
    g++-14 -c -fPIC -DGFOR -I src_c_lite/ src_c_lite/ensFilter.cc
    $FC -c -fPIC src_f90_lite/fhb1_noNaN.f90
fi

#$FC -c -fPIC src_f90_lite/radarRet_P2_py.f90
#g++-14 -c -fPIC -DGFOR -I src_c_lite/ src_c_lite/fModelFortran_py.cc

$FC -c -fopenmp -fPIC src_f90_lite/radar_prof_omp.f90

f2py  -c --f90flags="-fopenmp"  -m cAlg src_f90_lite/mainf_lite.f90 src_f90_lite/test_string.f90 src_f90_lite/radarRet_P2_py.f90 src_f90_lite/radar_f2py.f90 set_and_get_fields.f90 globModule.o f90DataTypes.o random.o writegif.o weightModule.o nbin.o missing_flags.o cloud.o allocateMem.o readTables_nonsph.o absorb.o bisection.o gcloud.o geomask.o read_melt_percentages.o ensFilter.o fModelFortran.NUBF.o  gEnv.o fhb1_noNaN.o geophysEns.o radtran_tau_dble.o rterain.o band_dble.o GMIRetTypes.o GMIRet.o gmi_ocean_ret_raob.o emissModule.o lut_routines_sjm.o atm_routines.o calcPIA.o dboux.o rosen.o fmodel.o check_nan.o ezlhconv.o gmi_land_ret.o readNh.o retTablesInt.half.o oe_routines.o algebra.o normal.o multiscatter-1.2.10/lib/libmultiscatter.a beamConvSet.o beamConvP.o sst.rend.o screenocean.o outputminmax.o asciiCon.o clearsc.o convAllFreq.o convPix2.py.o radarRet.o resampGMI.o latlon.o interpol.o setOpt.o local_rad_module.o fModelFortran_py.o radar_prof_omp.o -lblas -llapack -lstdc++ -lgomp
