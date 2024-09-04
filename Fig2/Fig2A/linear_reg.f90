program linreg
   implicit none                                                                    ! no default data types
   integer, parameter  :: dbl = kind (0.0d0)                                          ! define kind for double precision
   integer, parameter  :: step = 200                                                   ! define kind for double precision
   integer :: i, t(500)
   real(dbl)           ::  b                                                        ! y-intercept of least-squares best fit line
   real(dbl)           ::  m                                                        ! slope of least-squares best fit line
   real(dbl)           ::  n = 0.0d0                                                ! number of data points
   real(dbl)           ::  r                                                        ! squared correlation coefficient
   character (len=80)  ::  str                                                      ! input string
   real(dbl)           ::  sumx  = 0.0d0                                            ! sum of x
   real(dbl)           ::  sumx2 = 0.0d0                                            ! sum of x**2
   real(dbl)           ::  sumxy = 0.0d0                                            ! sum of x * y
   real(dbl)           ::  sumy  = 0.0d0                                            ! sum of y
   real(dbl)           ::  sumy2 = 0.0d0                                            ! sum of y**2
   real(dbl), dimension(500) ::  x                                                        ! input x, t data
   real(dbl), dimension(500) ::  y, z                                                        ! input y, z data

 !  write (unit=*, fmt="(a)") " LINREG - Perform linear regression"                  ! print introductory message
 !  write (unit=*, fmt="(a/)") "   (Enter END to stop data entry and compute"//  &
!                              " linear regression.)"
   open (123,file = "diffusion_time.dat")
   do      i = 1, step                                                                     ! loop for all data points
    !  write (unit=*, fmt="(a)", advance="no") " Enter x y:  "                       ! prompt to enter data
    !  read (unit=*, fmt="(a)") str                                                  ! read x and y into string
    !  if (str == "end" .or. str == "END") exit                                      ! if no more data, then exit loop
     ! read (unit=str, fmt=*) x, y                                                   ! else read x and y from string
      read (123,*) t(i), x(i), y(i), z(i)                                                  ! else read x and y from string

      n = n + 1.0d0                                                                 ! increment number of data points by 1
      sumx  = sumx + t(i)                                                              ! compute sum of x
      sumx2 = sumx2 + t(i) * t(i)                                                         ! compute sum of x**2
      sumxy = sumxy + t(i) * z(i)                                                         ! compute sum of x * y
      sumy  = sumy + z(i)                                                              ! compute sum of y
      sumy2 = sumy2 + z(i) * z(i)                                                         ! compute sum of y**2
   end do
print*, n
   m = (n * sumxy  -  sumx * sumy) / (n * sumx2 - sumx**2)                          ! compute slope
   b = (sumy * sumx2  -  sumx * sumxy) / (n * sumx2  -  sumx**2)                    ! compute y-intercept
   r = (sumxy - sumx * sumy / n) /                                     &            ! compute correlation coefficient
                     sqrt((sumx2 - sumx**2/n) * (sumy2 - sumy**2/n))

   write (unit=*, fmt="(/a,es15.6)") " Slope        m = ", m                        ! print results
   write (unit=*, fmt="(a, es15.6)") " y-intercept  b = ", b
   write (unit=*, fmt="(a, es15.6)") " Correlation  r = ", r

end program linreg
