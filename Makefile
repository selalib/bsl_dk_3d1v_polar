SIM_NAME=bsl_dk_3d1v_polar
SLL_DIR ?= "/opt/selalib"
FC = h5pfc
FFLAGS = -w -ffree-line-length-none -fall-intrinsics -O3 -fPIC -march=native -I${SLL_DIR}/include/selalib
FLIBS = -L${SLL_DIR}/lib -lselalib -lfftw3 -ldfftpack

${SIM_NAME}: reductions.o sll_m_sim_${SIM_NAME}.o ${SIM_NAME}.o 
	${FC} ${FFLAGS} -o ${SIM_NAME} $^ -I${SLL_DIR}/include/selalib ${FLIBS}

run: build
	mpirun -np 8 ${SIM_NAME}

clean: 
	rm -f *.o ${SIM_NAME} *.mod

selalib:
	git clone git@gitlab.inria.fr:ipso/selalib.git

sll_build: selalib
	mkdir -p $@
	cd $@; cmake ../selalib -DHDF5_PARALLEL_ENABLED=ON \
                  -DCMAKE_INSTALL_PREFIX=${SLL_DIR} \
                  -DCMAKE_BUILD_TYPE=Release \
 	          -DBUILD_TESTING=OFF -DBUILD_SIMULATIONS=OFF; make install

.SUFFIXES: $(SUFFIXES) .F90

.F90.o:
	$(FC) $(FFLAGS) -c $<

.mod.o:
	$(FC) $(FFLAGS) -c $*.F90

