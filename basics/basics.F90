! Comments start with a ! and can be anywhere in a line
! Multi-line comments should be done with a ! at the beginning of each line
module b_mod !! This is a module statement.  It opens a module
implicit none !! ALWAYS USE IMPLICIT NONE
private !! everything not declared public is not available in a USE statement
  integer(kind=4),public :: i4 ! 32 bit integer declared as public
  integer(kind=8) :: i8 ! 64 bit integer
  real(kind=4)    :: r4 ! 32 bit floating point value
  real(kind=8)    :: r8 ! 64 bit floating point value or double
  logical         :: tf ! logical true false variable
  character(len=5):: string ! String variable that is 5 characters long 

  public :: r4, tf, string  ! These are all of the variables and routines and functions that are 
                            ! available outside of this module
end module b_mod ! To end a module, use end module
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
module c_mod ! the c_mod module
 use b_mod !c_mod is using anything public in b_mod
 implicit none ! implicit none goes underneat any USE statements
 private
 integer (kind=4), parameter :: III = 200 ! A parameter CANNOT be changed
 integer (kind=4) :: ic
 
 public :: ic, iii, add_integer_kind_4, add_i_k_4  !these are available outside of c_mod

 contains  ! This is where the subrotuines and functions live in this module

 subroutine add_integer_kind_4(i1, i2, res) !SUBROUTINE that is CALLed with arguments in ()
  integer (kind=4), intent(in) :: i1 ! INTENT(IN) variables can not be changed
  integer (kind=4), intent(in) :: i2
  integer (kind=4), intent(out) :: res ! INTENT(OUT) variables MUST be set

 res = i1 + i2
 end subroutine add_integer_kind_4

 function add_i_k_4 (i1, i2) result (res) !The function has a result that is decalred as a variable
  integer (kind=4), intent(in) :: i1 ! INTENT(IN) variables can not be changed
  integer (kind=4), intent(in) :: i2
  integer (kind=4) :: res ! The RESULT variable MUST be set

   res = i1 + i2
 end function add_i_k_4
 

end module c_mod
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
program basic_program  ! This is the main program to be run

 use b_mod
 use c_mod
 implicit none 

 integer(kind=4) :: i !declared a local i*4 integer (example 1)
 !! example 1
 ic = 10 !set values for the module level integers
 i4 = 20
 i = ic + i4 !do some math
 write (6,*) "Example 1.  i = ", i !Write the output as a string and an integer
 !! example 2 calling a subroutine
 i = 0
 !! use CALL to call a subroutine
 call add_integer_kind_4(ic, i4, i) ! Names of arguments are positional and don't have to match the local argument
                                    ! name
 write (6,*) "Example 2.  call add_integer_kind_4(ic, i4, i) i= ", i !Write the output as a string and an integer
!! Example 3 using a function
 i = 0
 i = add_i_k_4(ic, i4)
 write (6,*) "Example 3.  i = add_i_k_4(ic, i4) i= ", i !Write the output as a string and an integer
 write (6,*) "Example 3. ", add_i_k_4(ic, i4) ! Can use the function as a number
 i = III - add_i_k_4(ic, i4) ! Can use the function as a number in a mathematical statement
 write (6,*) "Example 3. III - add_i_k_4(ic, i4) ", i 

end program basic_program ! end you main program with END PROGRAM
