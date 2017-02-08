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

 subroutine compute_mass(layout, f,x1_min, delta1, Nc_x1, mass, l2norm)
  
 type(sll_t_layout_4d), pointer , intent(in) :: layout
 sll_real64, dimension(:,:,:,:), pointer , intent(in) :: f
 sll_real64, intent(in)              :: x1_min, delta1
 sll_int32, intent(in)               :: Nc_x1
 sll_real64, intent(out)             :: mass, l2norm
 sll_int32                           :: error
 sll_int32                           :: prank
 sll_int32                           :: comm
 sll_real64                          :: sumloc, l2normloc
 sll_real64                          :: x1

 mass = 0.0_f64
 l2norm=0.0_f64
 
 prank = sll_f_get_collective_rank(sll_v_world_collective)
 comm  = sll_v_world_collective%comm
 call sll_o_compute_local_sizes(layout,loc_sz_i,loc_sz_j,loc_sz_k,loc_sz_l)        
 sumloc   = 0.0_f64
 l2normloc=0.0_f64
 do l=1,loc_sz_l-1
   do j=1,loc_sz_j-1
      do i=1,loc_sz_i-1
         x1     =x1_min+real(i-1,f64)*delta1
         sumloc    = sumloc    + sum(f(i,j,:,l)*x1)
         l2normloc = l2normloc + norm2(f(i,j,:,l)*sqrt(x1))**2 
      end do
   end do
 end do
 call mpi_reduce(sumloc, mass,1,MPI_REAL8,MPI_SUM,MPI_MASTER,comm,error)
 call mpi_reduce(l2normloc, l2norm,1,MPI_REAL8,MPI_SUM,MPI_MASTER,comm,error)

! if ( prank == MPI_MASTER) print*, 'mass = ', mass,loc_sz_i,loc_sz_j,loc_sz_l

! print*, 'mass reduction = ', mass,loc_sz_i,loc_sz_j,loc_sz_l,loc_sz_k
 
 end subroutine compute_mass


end module reductions
