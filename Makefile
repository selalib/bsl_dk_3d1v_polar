SIM_NAME=bsl_dk_3d1v_polar
SLL_DIR=/opt/selalib
FC = h5pfc
FFLAGS = -w -ffree-line-length-none -fall-intrinsics -O3 -fPIC -march=native
FLIBS = -L${SLL_DIR}/lib -lselalib -lfftw3 -ldfftpack
build: reductions.F90 sll_m_sim_${SIM_NAME}.F90 ${SIM_NAME}.F90 
	${FC} ${FFLAGS} -o ${SIM_NAME} $^ -I${SLL_DIR}/include/selalib ${FLIBS}

run: build
	mpirun -np 8 ${SIM_NAME}

clean: 
	rm -f *.o bsl_dk_3d1v_polar *.mod
