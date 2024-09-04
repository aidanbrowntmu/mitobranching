        program diffusion_2d
        implicit none
        integer :: i, mi, ri, j, k, time, maxtime, numruns, found, thisbond
        integer :: bp, bnp, shift, bonds, step, foundtarget
        integer :: cntNP, cntP, cnt1, cnt2, bond_pass, cntt1, cntt2
        real(8), dimension(10000) :: bx, by, f, bondtime
        real(8), dimension(10000) :: bpx, bpy, bnpx, bnpy, flagp, flagnp
        real(8), dimension(1000) :: a, b, px, py
        real(8) :: x, y, t, Delta_t, x_rec, y_rec, timedifference, x_found, y_found
        real(8) :: cumrate, rate_left, rate_right, rate_up, rate_down, total_rate
        real(8) :: rannum, rand1, rand2, rtime, rpos, rand3, flip, rnum, rprob, randagain
        real(8) :: rinitx, rfindx, rinity, rfindy
        real(8) :: sumx, sumy , sumx2, sumy2, sumxy, n, r, cumuflu
        real(8) :: total_rate_bond_remove, total_rate_bond_add, rate_bond_remove, rate_bond_add
        real(8) :: bondprob, section1, section2, section3
        real(8) ::  pfuse, probbondexists, boxend
        boxend = 10.0
        time = 100
        numruns = 100
        bonds= 840
        rate_bond_add = 0.1
        rate_bond_remove = 0.9
        bondprob = rate_bond_add/(rate_bond_add + rate_bond_remove)
      
 !***********read bond file***************
 open(121,file="bond_pos_10X10.dat")
 do i= 1, bonds
  read(121,*) a(i), b(i), f(i)
  bx(i) = a(i)
  by(i) = b(i)
 enddo
 close(121)
       
    
       do ri = 1, numruns
           call random_number(rinitx)
           call random_number(rinity)
            x = nint((1-2.0*rinitx)*boxend)
            y = nint((1-2.0*rinity)*boxend)
            print*, ri, x, y, "start"
            open(unit = 129,file= "xy_time_start.dat",Access = 'append')
            write(129,*)  ri, t, x, y
            close(129)

            call random_number(rfindx)
            call random_number(rfindy)
            x_found = (nint((1-2.0*rfindx)*boxend))
            y_found = (nint((1-2.0*rfindy)*boxend))
            print*, ri, x_found, y_found, "end"
           t = 0.0



       
           foundtarget = 0
      
         do while (foundtarget .eq. 0)

           cntt1 = 0; cntt2 = 0
          do j = 1, bonds
           call random_number(rnum)
           if(rnum .le. bondprob) then
               cntt1 = cntt1 + 1
               f(j) = 1
            else
               cntt2 = cntt2 + 1
               f(j) = -1
            endif
            bondtime(j) = 0.0
          enddo

           rate_left = 1.0
            if((x .lt. 0.0) .and. (x .ge. -(boxend))) then
                  rate_left = 1.0
            endif

             if((x .le. -(boxend))) then
              rate_left = 0.0
            endif

                    rate_right = 1.0
            if((x .gt. 0.0) .and. (x .le. (boxend))) then
                  rate_right = 1.0
             endif

             if((x .ge. (boxend))) then
              rate_right = 0.0
            endif

                  rate_up = 1.0
            if((y .gt. 0.0) .and. (y .le. (boxend))) then
                  rate_up = 1.0
            endif

             if((y .ge. (boxend))) then
              rate_up = 0.0
            endif


                  rate_down = 1.0
             if((y .lt. 0.0) .and. (y .ge. -(boxend))) then
                  rate_down = 1.0
             endif

             if((y .le. -(boxend))) then
              rate_down = 0.0
            endif

  !************************ movement starts **********************************************************

            call random_number(rtime)                    !call the random points
            rand1 = rtime
            
            total_rate = rate_left + rate_right + rate_up + rate_down! + total_rate_bond_add &
            !+ total_rate_bond_remove
            Delta_t = (1.0/total_rate)*log(1.0/rand1)
            t = t + Delta_t
            
           
             call random_number(rpos)                   !call the random points
             rand2 = rpos

  !============================= moving LEFT =================================================
                cumrate = 0.0
                found = 0
                cumrate = cumrate + rate_left
                if((rand2 .lt. (cumrate/total_rate)) .and. (found .eq. 0)) then
                    found = 1
                    do i = 1, bonds
                      if ((bx(i) .lt. x) .and. (bx(i) .gt. (x - 1.0)) .and. (by(i) .eq. y)) then
                        thisbond = i
                      endif
                    enddo
                    
                    timedifference = t - bondtime(thisbond)
                    if(f(thisbond) .eq. 1) then
                      pfuse = 1.0
                    else
                      pfuse = 0.0
                    endif
                    probbondexists = pfuse*exp(-(rate_bond_add + rate_bond_remove)*timedifference) &
   + (rate_bond_add/(rate_bond_add + rate_bond_remove))*(1.0 - exp(-(rate_bond_add + rate_bond_remove)*timedifference))
                    
                    call random_number(rprob)
                    randagain = rprob
                    if(randagain .lt. probbondexists) then
                      x = x - 1.0
                      y = y
                      f(thisbond) = 1
                     else
                      f(thisbond) = -1
                    endif
                    bondtime(thisbond) = t
             endif
                
   !============================= moving RIGHT =================================================
                cumrate = cumrate + rate_right
              if((rand2 .lt. (cumrate/total_rate)) .and. (found .eq. 0)) then
                    found = 1
                do i = 1, bonds      
                if ((bx(i) .gt. x) .and. (bx(i) .lt. (x + 1.0)) .and. (by(i) .eq. y)) then
                   thisbond = i
                endif       
                enddo 

                   timedifference = t - bondtime(thisbond)
                   if(f(thisbond) .eq. 1) then
                     pfuse = 1.0
                    else
                     pfuse = 0.0
                   endif
                 probbondexists = pfuse*exp(-(rate_bond_add + rate_bond_remove)*timedifference) &
   + (rate_bond_add/(rate_bond_add + rate_bond_remove))*(1.0 - exp(-(rate_bond_add + rate_bond_remove)*timedifference))

                    call random_number(rprob)
                    randagain = rprob
                    if(randagain .lt. probbondexists) then
                      x = x + 1.0
                      y = y
                      f(thisbond) = 1
                    else
                      f(thisbond) = -1
                    endif
                    bondtime(thisbond) = t
              endif

!=============================moving UP =================================================
                cumrate = cumrate + rate_up
              if((rand2 .lt. (cumrate/total_rate)) .and. (found .eq. 0)) then
                    found = 1
                do i = 1, bonds
                 if ((by(i) .gt. y) .and. (by(i) .lt. (y + 1.0)) .and. (bx(i) .eq. x)) then
                   thisbond = i
                 endif
                enddo  
                    
                   timedifference = t - bondtime(thisbond)
                   if(f(thisbond) .eq. 1) then
                     pfuse = 1.0
                    else
                     pfuse = 0.0
                   endif
                   probbondexists = pfuse*exp(-(rate_bond_add + rate_bond_remove)*timedifference) &
   + (rate_bond_add/(rate_bond_add + rate_bond_remove))*(1.0 - exp(-(rate_bond_add + rate_bond_remove)*timedifference))

                    call random_number(rprob)
                    randagain = rprob
                    if(randagain .lt. probbondexists) then
                     x = x 
                     y = y + 1.0
                      f(thisbond) = 1
                     else
                      f(thisbond) = -1
                    endif
                    bondtime(thisbond) = t
               endif
              
 !============================= moving DOWN =================================================
                cumrate = cumrate + rate_down
             if((rand2 .le. (cumrate/total_rate)) .and. (found .eq. 0)) then
                    found = 1

                 do i = 1, bonds
                  if ((by(i) .lt. y) .and. (by(i) .gt. (y - 1.0)) .and. (bx(i) .eq. x)) then
                   thisbond = i
                  endif
                 enddo
                   
                 timedifference = t - bondtime(thisbond)
                  if(f(thisbond) .eq. 1) then
                    pfuse = 1.0
                   else
                    pfuse = 0.0
                  endif
                   probbondexists = pfuse*exp(-(rate_bond_add + rate_bond_remove)*timedifference) &
  + (rate_bond_add/(rate_bond_add + rate_bond_remove))*(1.0 - exp(-(rate_bond_add + rate_bond_remove)*timedifference))

                   call random_number(rprob)
                   randagain = rprob
                   if(randagain .lt. probbondexists) then
                    x = x 
                    y = y - 1.0
                    f(thisbond) = 1
                    else
                    f(thisbond) = -1
                   endif
                   bondtime(thisbond) = t
              endif

           if((x .eq. x_found) .and. (y .eq. y_found)) then
             foundtarget = 1
            open(unit = 124,file= "xy_time_target.dat",Access = 'append')
             write(124,*) ri, t, x, y, x_found, y_found
             close(124)
           endif

     enddo             ! do while loop
    
  enddo   ! time loop

end program
