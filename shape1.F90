module s_mod ! Module statement
implicit none ! Always use implicit none

real, parameter :: pi = 3.14159 ! An unchangable parameter value of pi

type shape_type ! Fortran derived type data structure
 real :: area !< Area (all shapes have area)
 real :: perimeter !< Perimeter (all shapes have a perimeter)
end type shape_type

end module s_mod

program shape_example !< Program statement to tell the compiler this is the main program

use s_mod ! How to include modules that are compiled

implicit none ! Always use implicit none

 type (shape_type) :: square ! Declase the variable s with the type of shape_type.  s now has 
                        ! the variables in shape_type

 square%area=25.  ! set the area in s to 25
 square%perimeter = 20. ! set the perimeter in s to 20

!> Print the values of the area and perimeter
 write (6,*) "Area = ", square%area
 write (6,*) "perimeter = ",square%perimeter
end program shape_example
