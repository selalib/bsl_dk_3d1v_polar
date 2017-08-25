## Installation

Follow instructions in https://gitlab.inria.fr/profile/keys
to add your ssh keys

### Download
```bash
git clone git@gitlab.inria.fr:ipso/bsl_dk_3d1v_polar.git
cd bsl_dk_3d1v_polar
```

### Dependencies
   - Fortran compiler
   - openmpi
   - hdf5 built with mpi
   - fftw
   - cmake

### selalib
   - http://selalib.gforge.inria.fr/
   
   ```bash
   make sll_build
   ```

## Directory structure

  - bsl_dk_3d1v_polar         : executable
  - dksim4d_polar_input.nml   : input file
  - dksim4d_polar.gnu         : gnuplot script
  - dksim4d_polar_ref.dat     : reference results
  - README.md                 : info (this file)

## HOWTO

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
  
