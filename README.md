## Directory structure

  - bsl_dk_3d1v_polar         : executable
  - dksim4d_polar_input.nml   : input file
  - dksim4d_polar.gnu         : gnuplot script
  - dksim4d_polar_ref.dat     : reference results
  - README                    : info (this file)
  - run/                      : output directory

## HOWTO

  0. Create output directory if missing, and move into it
  ~~~
       $ mkdir run
       $ cd run
  ~~~
  
  1. Run parallel simulation within directory
  ~~~
       $ mpirun -np 4 ./bsl_dk_3d1v_polar ./dksim4d_polar_input.nml
  ~~~
  
  2. Run included gnuplot script
  ~~~
       $ gnuplot --persist dksim4d_polar.gnu
  ~~~
  
  3. Run gnuplot scripts generated at runtime
  ~~~
       $ gnuplot --persist rho_0.gnu
  ~~~
  
