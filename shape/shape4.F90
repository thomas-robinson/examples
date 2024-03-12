module s_mod ! Module statement
implicit none ! Always use implicit none
private ! Declare everything private

real, parameter :: pi = 3.14159 ! An unchangable parameter value of pi

type, abstract :: shape_type ! Abstract class derived type data structure
private
 real :: area !< Area 
 real :: perimeter !< 
 contains ! List the type bound procedures below contains within the data structure
 procedure :: get_area
 procedure :: get_perimeter
end type shape_type

type, extends(shape_type) :: rectangle_type
private
 real :: length
 real :: width
 contains
 procedure :: set_l_w
 procedure :: set_area => calculate_rectangle_area 
 procedure :: set_perimeter => calculate_rectangle_perimeter 
end type

type, extends(rectangle_type) :: square_type
 contains
 procedure :: set_l
 procedure :: set_area => calculate_square_area !! Overrides rectangle subroutine
 procedure :: set_perimeter => calculate_square_perimeter !! Overrides rectangle subroutine
end type

public :: pi, shape_type, rectangle_type, square_type ! List only what needs to be public

contains ! List the module procedures below the module contains

!> Set the length of the square
subroutine set_l (this, l)
  class (square_type) :: this !< rectangle object
  real :: l !< Length
  this%length = l
  this%width = l
  call this%set_area()
  call this%set_perimeter()
end subroutine set_l
!> 
subroutine calculate_square_area (this)
  class (square_type) :: this !< rectangle object
  this%area = this%length**2
end subroutine calculate_square_area
subroutine calculate_square_perimeter (this)
  class (square_type) :: this !< rectangle object
  this%perimeter = this%length * 4
end subroutine calculate_square_perimeter
!> Sets the length and width
subroutine set_l_w (this, l, w)
  class (rectangle_type) :: this !< rectangle object:
  real :: l !< Length
  real :: w !< width
  this%length = l
  this%width = w
  call this%set_area()
  call this%set_perimeter()
end subroutine set_l_w

!> Calculates the area of the rectangle
subroutine calculate_rectangle_area (this)
  class (rectangle_type) :: this !< rectangle object
  this%area = this%length * this%width
end subroutine calculate_rectangle_area

!> Calculates the perimeter of the rectangle
subroutine calculate_rectangle_perimeter (this)
  class (rectangle_type) :: this !< rectangle object
  this%perimeter = this%length + this%width + this%length + this%width
end subroutine calculate_rectangle_perimeter
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!> Function that gets the variable area
!> \returns a copy of area
pure function get_area (this) result(res)
 class(shape_type), intent(in) :: this !< This is what makes it a type bound procedure.  Use class to declare it
 real :: res !< This is the result and needs to be the same type as the variable
 res = this%area
end function get_area
!> Function that gets the variable perimeter
!> \returns a copy of perimeter
pure function get_perimeter (this) result(res)
 class(shape_type), intent(in) :: this !< This is what makes it a type bound procedure.  Use class to declare it
 real :: res !< This is the result and needs to be the same type as the variable
 res = this%perimeter
end function get_perimeter

end module s_mod
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
program shape_example !< Program statement to tell the compiler this is the main program

use s_mod ! How to include modules that are compiled

implicit none ! Always use implicit none

type(square_type) , target :: square !! This is a square
class(shape_type) , pointer :: unknown_shape !! This can be used for any shape
unknown_shape => square

!! Use select type to call the right routines
select type (unknown_shape)
  type is (rectangle_type)
    call unknown_shape%set_l_w(5.0 , 5.0)
  type is (square_type)
    call unknown_shape%set_l(25.0)
  class default
    write (6,*) "The type is not added to this select type"
end select

!> Print the values of the area and perimeter
!! Because all shapes have these routines, we can use them without a select type
 write (6,*) "Area = ", unknown_shape%get_area()
 write (6,*) "perimeter = ",unknown_shape%get_perimeter()
end program shape_example
