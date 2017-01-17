module reductions

#define MPI_MASTER 0
#include "sll_working_precision.h"
#include "sll_memory.h"
#include "sll_assert.h"

 use sll_m_remapper
 use sll_m_xml_io
 use sll_m_collective
 use sll_m_utilities
 use mpi

 implicit none
 
 public :: compute_mass
 private

 sll_int32  :: i, j, k, l
 sll_int32  :: loc_sz_i,loc_sz_j,loc_sz_k,loc_sz_l

contains

 subroutine compute_mass(layout, f,  mass)
  
 type(sll_t_layout_4d), pointer , intent(in) :: layout
 sll_real64, dimension(:,:,:,:), pointer , intent(in) :: f
 sll_real64, intent(out)             :: mass
 sll_int32                           :: error
 sll_int32                           :: prank
 sll_int32                           :: comm
 sll_real64                          :: sumloc

 mass = 0.0_f64

 prank = sll_f_get_collective_rank(sll_v_world_collective)
 comm  = sll_v_world_collective%comm
 call sll_o_compute_local_sizes(layout,loc_sz_i,loc_sz_j,loc_sz_k,loc_sz_l)        
 sumloc = 0.0_f64
 do l=1,loc_sz_l
   do j=1,loc_sz_j
      do i=1,loc_sz_i
         sumloc = sumloc + sum(f(i,j,:,l))
      end do
   end do
 end do
 call mpi_reduce(sumloc, mass,1,MPI_REAL8,MPI_SUM,MPI_MASTER,comm,error)

 if ( prank == MPI_MASTER) print*, 'mass = ', mass

 end subroutine compute_mass

end module reductions
