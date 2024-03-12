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

public :: pi, shape_type, rectangle_type ! List only what needs to be public

contains ! List the module procedures below the module contains

!> Sets the length and width
subroutine set_l_w (rec, l, w)
  class (rectangle_type) :: rec !< rectangle object
  real :: l !< Length
  real :: w !< width
  rec%length = l
  rec%width = w
  call rec%set_area()
  call rec%set_perimeter()
end subroutine set_l_w

!> Calculates the area of the rectangle
subroutine calculate_rectangle_area (rec)
  class (rectangle_type) :: rec !< rectangle object
  rec%area = rec%length * rec%width
end subroutine calculate_rectangle_area

!> Calculates the perimeter of the rectangle
subroutine calculate_rectangle_perimeter (rec)
  class (rectangle_type) :: rec !< rectangle object
  rec%perimeter = rec%length + rec%width + rec%length + rec%width
end subroutine calculate_rectangle_perimeter
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!> Function that gets the variable area
!> \returns a copy of area
pure function get_area (shp) result(res)
 class(shape_type), intent(in) :: shp !< This is what makes it a type bound procedure.  Use class to declare it
 real :: res !< This is the result and needs to be the same type as the variable
 res = shp%area
end function get_area
!> Function that gets the variable perimeter
!> \returns a copy of perimeter
pure function get_perimeter (shp) result(res)
 class(shape_type), intent(in) :: shp !< This is what makes it a type bound procedure.  Use class to declare it
 real :: res !< This is the result and needs to be the same type as the variable
 res = shp%perimeter
end function get_perimeter

end module s_mod
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
program shape_example !< Program statement to tell the compiler this is the main program

use s_mod ! How to include modules that are compiled

implicit none ! Always use implicit none

 type (rectangle_type) :: rectangle ! Declase the variable s with the type of rectanle_type.

!! Use the setters to set the values
 call rectangle%set_l_w(5.0 , 5.0)

!> Print the values of the area and perimeter
!! Use the getters to get the values
 write (6,*) "Area = ", rectangle%get_area()
 write (6,*) "perimeter = ",rectangle%get_perimeter()
end program shape_example
