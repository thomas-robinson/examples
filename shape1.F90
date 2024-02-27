module s_mod
implicit none

real, parameter :: pi = 3.14159

type shape_type
 real :: area
 real :: perimeter
end type shape_type

end module s_mod

program shape_example

use s_mod

implicit none

 type (shape_type) :: s

 s%area=25.
 s%perimeter = 20.

 write (6,*) "Area = ", s%area
 write (6,*) "perimeter = ",s%perimeter
end program shape_example
