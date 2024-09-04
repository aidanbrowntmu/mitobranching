        program diffusion_2d
        implicit none
        integer :: i, mi, ri, j, k, time, maxtime, numruns, found
        integer :: foundtarget, relaxed
        integer :: bp, bnp, shift, bonds, step, chk, chk2, flip_pass
        integer :: cntNP, cntP, cnt,cnt1(10000), cnt2, bond_pass, cntt1, cntt2, flip_cnt
        integer :: cnt_bond, cnt_nobond, started
        integer :: cntx1, cntx2, cnty1, cnty2, cnt1_total, cntxx1, cntxx2, cntyy1, cntyy2, cnt2_total
        real(8), dimension(10000) :: bx, by, bxx, byy, f, ff, xposnext, yposnext
        real(8), dimension(10000) :: bpx, bpy, bnpx, bnpy, flagp, flagnp, xpos, ypos
        real(8) :: x, y, t, Delta_t, x_rec, y_rec, tau
        real(8) :: rate_left, rate_right, rate_up, rate_down, total_rate
        real(8) :: cumrate, rannum, rand1, rand2, rtime, rpos, rand3, randflip, flip, rflip, rnum
        real(8) :: sumx, sumy , sumx2, sumy2, sumxy
        real(8) :: a(10000), b(10000), px(10000), py(10000), n, r, cumuflu
        real(8) :: total_rate_bond_remove, total_rate_bond_add, rate_bond_remove, rate_bond_add
        real(8) :: bondprob, rate_bond_fusion, sum_bond_fusion
        real(8) :: boxend, rinitx, rinity, rfindx, rfindy, x_found, y_found, nodes, Lxy
    !    tau = 0.1

        time = 1
        numruns = 100
        Lxy = 20.0
      
        boxend = 10.0
        bonds = 220
        nodes = 10.0
        bondprob = 0.8525

        tau = 0.1

        rate_bond_add = bondprob/tau
        rate_bond_remove = (rate_bond_add*(1-bondprob)/(bondprob))
        print*, tau, bondprob, rate_bond_add, rate_bond_remove, nodes

 !*********************read bond file***************
 open(121,file="bond_pos_L10n10.dat")
 do i= 1, bonds
  read(121,*) a(i), b(i), xpos(i), ypos(i), xposnext(i), yposnext(i)
  bx(i) = a(i)
  by(i) = b(i)
 enddo
 close(121)
!***************************************************       
        do ri = 1, numruns

            call random_number(rinitx)
            call random_number(rinity)
            x = nint((1-rinitx)*boxend)
            y = nint((1-rinity)*boxend)
             open(unit = 127,file= "xy_time_start.dat",Access = 'append')
             write(127,*) ri, t*((Lxy/(nodes-1.0))*(Lxy/(nodes-1.0))), x, y
        !     write(*,*) ri,  t, x, y, "start"
             close(127)

           
            call random_number(rfindx)
            call random_number(rfindy)
            x_found = (nint((1-rfindx)*boxend))
            y_found = (nint((1-rfindy)*boxend))
        !    print*, ri, t, x_found, y_found, "end"

           t = 0.0
!*********************select the bonds*****************************************************
       cntt1 = 0; cntt2 = 0
       do j = 1, bonds
         call random_number(rnum)
         if(rnum .le. bondprob) then
                 cntt1 = cntt1 + 1
           f(j) = -1
         else
                 cntt2 = cntt2 + 1
           f(j) = -1
         endif
       enddo
      
          foundtarget = 0
          relaxed = 0
          started = 0

           do while (foundtarget .eq. 0 .or. relaxed .eq. 0) ! .or. started .eq. 0)

  !**********************define rates*********************************************************       
                  rate_left = 0.0
                do i = 1, bonds
                 if ((f(i) .eq. 1) .and. (bx(i) .lt. x) .and. (bx(i) .gt. (x - 1.0)) .and. (by(i) .eq. y)) then        !move towards left
                        rate_left = 1.0*((nodes-1.0)/Lxy)*((nodes-1.0)/Lxy)
                 elseif ((f(i) .eq. -1) .and. (bx(i) .lt. x) .and. (bx(i) .gt. (x - 1.0)) .and. (by(i) .eq. y)) then       
                        rate_left = 0.0
                 endif
                enddo
                
                   rate_right = 0.0
                do i = 1, bonds
                 if ((f(i) .eq. 1) .and.(bx(i) .gt. x) .and. (bx(i) .lt. (x + 1.0)) .and. (by(i) .eq. y)) then
                       rate_right = 1.0*((nodes-1.0)/Lxy)*((nodes-1.0)/Lxy)
                 elseif ((f(i) .eq. -1) .and.(bx(i) .gt. x) .and. (bx(i) .lt. (x + 1.0)) .and. (by(i) .eq. y)) then
                       rate_right = 0.0
                endif
               enddo       
               
                 rate_up = 0.0
               do i = 1, bonds
                 if ((f(i) .eq. 1) .and. (by(i) .gt. y) .and. (by(i) .lt. (y + 1.0)) .and. (bx(i) .eq. x)) then
                    rate_up = 1.0*((nodes-1.0)/Lxy)*((nodes-1.0)/Lxy)
               elseif ((f(i) .eq. -1) .and. (by(i) .gt. y) .and. (by(i) .lt. (y + 1.0)) .and. (bx(i) .eq. x)) then
                    rate_up = 0.0
                 endif
               enddo  
               
                 rate_down = 0.0
               do i = 1, bonds
                if ((f(i) .eq. 1) .and.(by(i) .lt. y) .and. (by(i) .gt. (y - 1.0)) .and. (bx(i) .eq. x)) then
                      rate_down = 1.0*((nodes-1.0)/Lxy)*((nodes-1.0)/Lxy)
                elseif ((f(i) .eq. -1) .and.(by(i) .lt. y) .and. (by(i) .gt. (y - 1.0)) .and. (bx(i) .eq. x)) then
                      rate_down = 0.0
                endif
               enddo

!******************************** find the rates for bond addition and removal ***********************
               cntNP = 0; cntP = 0

               do i = 1, bonds
                if (f(i) .eq. -1) then
                 cntNP = cntNP + 1
                endif
               enddo
               total_rate_bond_add = cntNP*rate_bond_add

               do i = 1, bonds
                if (f(i) .eq. 1) then
                 cntP = cntP + 1
                endif
               enddo
               total_rate_bond_remove = cntP*rate_bond_remove

!*****************************Gillespie_algorithm****************************************************
            call random_number(rtime)                    !call the random points
            rand1 = rtime
            
            total_rate = rate_left + rate_right + rate_up + rate_down + total_rate_bond_add &
            + total_rate_bond_remove

            Delta_t = (1.0/total_rate)*log(1.0/rand1)
            t = t + Delta_t
            
!****************************movement starts**********************************************************

         if (t .gt. 10.0*tau .and. started .eq. 0) then
          !  call random_number(rinitx)
          !  call random_number(rinity)
          !  x = nint((1-2.0*rinitx)*boxend)
          !  y = nint((1-2.0*rinity)*boxend)
          !   open(unit = 127,file= "xy_time_start.dat",Access = 'append')
          !   write(127,*) ri, t, x, y
          !   write(*,*)  ri, t, x, y, "start"
          !   close(127)
            foundtarget = 0
            relaxed = 1
            t = Delta_t
            started = 1
         !   do i = 1, bonds
          !   if (f(i) .eq. 1) then
          !   write(555,*)  xpos(i), ypos(i), t, mi, ri
          !   write(555,*) xposnext(i), yposnext(i), t, mi, ri
          !   write(555,*)
          !   write(555,*)
          !  endif
          !  enddo
         endif
         
 
             call random_number(rpos)                   !call the random points
              rand2 = rpos

              cumrate = 0.0
              found = 0
              cumrate = cumrate + rate_left
            if((rand2 .lt. (cumrate/total_rate)) .and. (found .eq. 0)) then
                    x = x - 1.0
                    y = y
                    found = 1
            !        write(123,*) mi, ri, t, x, y ,rand2, rate_left,  "L"
            endif
                
                cumrate = cumrate + rate_right
           if((rand2 .lt. (cumrate/total_rate)) .and. (found .eq. 0)) then
                    x = x + 1.0
                    y = y
                    found = 1
           endif

                cumrate = cumrate + rate_up
           if((rand2 .lt. (cumrate/total_rate)) .and. (found .eq. 0)) then
                    x = x 
                    y = y + 1.0
                    found = 1

            endif
              
                cumrate = cumrate + rate_down
           if((rand2 .le. (cumrate/total_rate)) .and. (found .eq. 0)) then
                    x = x 
                    y = y - 1.0
                    found = 1
           endif
                        
 !***********************************Bond fluctuation*******************************************
         call random_number(flip)                    !call the random points
               rand3 = flip
               do i = 1, bonds
                cnt1(i) = 0
               enddo
               cnt = 0
               cnt2 = 0
               bond_pass = 0
               flip = 0
               flip_cnt = 0
               cumrate = cumrate + total_rate_bond_add
                     
           if ((rand2 .le. (cumrate/total_rate)) .and. (found .eq. 0)) then
             found = 1

            do i = 1, bonds 
               cntx1 = 0; cntx2 = 0; cnty1 = 0; cnty2 = 0
               cntxx1 = 0; cntxx2 = 0; cntyy1 = 0; cntyy2 = 0
               
               if (f(i) .eq. -1) then
                      cnt = cnt + 1
                      if ((rand3 .le. (real(cnt)/real(cntNP))) .and. (bond_pass .eq. 0) ) then
                       bond_pass = 1

!*********************************** select the nodes and adjecent bonds ****************************
                      do j = 1, bonds               ! selected non-bonds
                         if (f(j) .eq. 1) then
                            if (bx(j) .eq. (xpos(i)-0.5) .and. (by(j) .eq. ypos(i))) then  ! bonds around 1st node in left
                                 if (i .ne. j) then
                                 cntx1 = cntx1 + 1
                                 endif
                             endif

                            if (bx(j) .eq. (xpos(i)+0.5) .and. (by(j) .eq. ypos(i))) then   ! bonds around 1st node in right
                                 if (i .ne. j) then
                                 cntx2 = cntx2 + 1
                                 endif
                             endif

                            if (bx(j) .eq. (xposnext(i)-0.5) .and. (by(j) .eq. yposnext(i))) then ! bonds around 2nd node left
                                 if (i .ne. j) then
                                 cntxx1 = cntxx1 + 1
                                 endif
                             endif


                             if (bx(j) .eq. (xposnext(i)+0.5) .and. (by(j) .eq. yposnext(i))) then  ! bonds around 2nd node in right
                                 if (i .ne. j) then
                                 cntxx2 = cntxx2 + 1
                                 endif
                             endif

                             if (bx(j) .eq. (xpos(i)) .and. (by(j) .eq. (ypos(i)-0.5))) then  ! bonds around 1st node in down
                                 if (i .ne. j) then
                                 cnty1 = cnty1 + 1
                                 endif
                             endif

                             if (bx(j) .eq. (xpos(i)) .and. (by(j) .eq. (ypos(i)+0.5))) then ! bonds around 1st node in up
                                 if (i .ne. j) then
                                  cnty2 = cnty2 + 1
                                 endif
                             endif

                             if (bx(j) .eq. (xposnext(i)) .and. (by(j) .eq. (yposnext(i)-0.5))) then  ! bonds around 2nd node in down
                                 if (i .ne. j) then
                                 cntyy1 = cntyy1 + 1
                                 endif
                             endif
                      
                             if (bx(j) .eq. (xposnext(i)) .and. (by(j) .eq. (yposnext(i)+0.5))) then ! bonds around 2nd node in up
                                 if (i .ne. j) then
                                  cntyy2 = cntyy2 + 1
                              !   write(222,*) t, i, j, bx(i), by(i), bx(j), by(j), cntyy2, "=="
                                 endif
                             endif
                     endif  ! end of f(j) 'if' loop
                  enddo          ! end bonds loop j
!***********************************************************************************************************
                  cnt1_total = cntx1 + cntx2 + cnty1 + cnty2
                  cnt2_total = cntxx1 + cntxx2 + cntyy1 + cntyy2
        
                  
                  if ((cnt1_total .lt. 4) .and. (cnt2_total .lt. 4)) then
                   f(i) = 1
                 endif   
            
               endif ! end of 'cnt1/cntNP' 'if'  loop
              endif ! end of f(i) 'if'  loop
             enddo     ! end bonds loop i
     endif  ! end of cumrate-total bond add 'if' loop
             
              cumrate = cumrate + total_rate_bond_remove
                if ((rand2 .le. (cumrate/total_rate)) .and. (found .eq. 0)) then
                        found = 1
                 do i = 1, bonds       
                    if ((f(i) .eq. 1)) then
                        cnt2 = cnt2 + 1
                      if ((rand3 .le. (real(cnt2)/real(cntP))) .and. (bond_pass .eq. 0)) then
                        f(i) = -1
                        bond_pass = 1
                      endif
                    endif
                 enddo 
           endif
          if((x .eq. x_found) .and. (y .eq. y_found) .and. started .eq. 1) then
             foundtarget = 1
            open(unit = 124,file= "xy_time_target.dat",Access = 'append')
             write(124,*) ri, t
             close(124)
           endif
     enddo             ! do while loop
    

!**********************************recalculate bond rates************************************************************** 
              cnt_bond = 0; cnt_nobond = 0 
               do i = 1, bonds
                 if (f(i) .eq. 1) then
                        cnt_bond = cnt_bond + 1
                  else
                  cnt_nobond = cnt_nobond + 1
                 endif
              enddo
              rate_bond_fusion = real(cnt_bond)/real((cnt_bond + cnt_nobond))
           !   rate_bond_remove_new = real(cnt_nobond)/real((cnt_bond + cnt_nobond))
        write(777,*)  ri, rate_bond_fusion, cnt_bond, cnt_nobond
!**************************************************************************************************************************  
        enddo                              !run loop

end program
