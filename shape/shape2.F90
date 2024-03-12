module s_mod ! Module statement
implicit none ! Always use implicit none
private ! Declare everything private

real, parameter :: pi = 3.14159 ! An unchangable parameter value of pi

type shape_type ! Fortran derived type data structure
private
 real :: area !< Area 
 real :: perimeter !< 
 contains ! List the type bound procedures below contains within the data structure
 procedure :: set_area
 procedure :: set_perimeter
 procedure :: get_area
 procedure :: get_perimeter
end type shape_type

public :: pi, shape_type ! List only what needs to be public

contains ! List the module procedures below the module contains

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


!> Subroutine that sets the variable area
subroutine set_area (shp, set)
 class(shape_type), intent(inout) :: shp !< This is what makes it a type bound procedure.  Use class to declare it
 real :: set !< Has to be the same type as area here
 shp%area = set
end subroutine set_area
!> Subroutine that sets the variable perimeter
subroutine set_perimeter (shp, set)
 class(shape_type), intent(inout) :: shp !< This is what makes it a type bound procedure.  Use class to declare it
 real :: set !< Has to be the same type as perimeter here
 shp%perimeter = set
end subroutine set_perimeter

end module s_mod
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
program shape_example !< Program statement to tell the compiler this is the main program

use s_mod ! How to include modules that are compiled

implicit none ! Always use implicit none

 type (shape_type) :: square ! Declase the variable s with the type of shape_type.  s now has 
                        ! the variables in shape_type

!! Use the setters to set the values
 call square%set_area(25).  ! set the area in s to 25
 call square%set_perimeter(20.) ! set the perimeter in s to 20

!> Print the values of the area and perimeter
!! Use the getters to get the values
 write (6,*) "Area = ", square%get_area()
 write (6,*) "perimeter = ",square%get_perimeter()
end program shape_example
