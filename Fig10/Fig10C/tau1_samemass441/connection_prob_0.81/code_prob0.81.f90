        program diffusion_2d
        implicit none
        integer :: i, mi, ri, j, k, time, maxtime, numruns, found
        integer :: bp, bnp, shift, bonds, step, chk, chk2, flip_pass
        integer :: cntNP, cntP, cnt,cnt1(10000), cnt2, bond_pass, cntt1, cntt2, flip_cnt
        integer :: cnt_bond, cnt_nobond, started
        integer :: cntx1, cntx2, cnty1, cnty2, cnt1_total, cntxx1, cntxx2, cntyy1, cntyy2, cnt2_total
        real(8), dimension(10000) :: bx, by, bxx, byy, f, ff, xposnext, yposnext
        real(8), dimension(10000) :: bpx, bpy, bnpx, bnpy, flagp, flagnp, xpos, ypos
        real(8) :: x, y, t, Delta_t, x_rec, y_rec, t_rec, tau
        real(8) :: rate_left, rate_right, rate_up, rate_down, total_rate
        real(8) :: cumrate, rannum, rand1, rand2, rtime, rpos, rand3, randflip, flip, rflip, rnum
        real(8) :: sumx, sumy , sumx2, sumy2, sumxy
        real(8) :: a(10000), b(10000), px(10000), py(10000), n, r, cumuflu
        real(8) :: total_rate_bond_remove, total_rate_bond_add, rate_bond_remove, rate_bond_add
        real(8) :: bondprob, rate_bond_fusion, sum_bond_fusion, Lxy, nodes
        time = 100
        numruns = 100
        Lxy = 20.0

        bonds = 420
        nodes = 14.0
        rate_bond_add = 0.8199
        
        tau = 1.0

        rate_bond_remove = ((1.0/tau)-rate_bond_add)
        bondprob = rate_bond_add/(rate_bond_add+rate_bond_remove)

        !rate_bond_remove = (rate_bond_add*(1-bondprob)/(bondprob))
       !rate_bond_add = bondprob/tau
        print*, tau, "tau"
        print*, bondprob,"bondprob"
        print*,  rate_bond_add,"rate add"
        print*,  rate_bond_remove,"remove"
      
 !*********************read bond file***************
 open(121,file="bond_pos_L14n14.dat")
 do i= 1, bonds
  read(121,*) a(i), b(i), xpos(i), ypos(i), xposnext(i), yposnext(i)
  bx(i) = a(i)
  by(i) = b(i)
 enddo
 close(121)
!***************************************************       
     
     do mi = 1, time   ! time loop

        sumx = 0.0
        sumy = 0.0
        sumx2 = 0.0
        sumy2 = 0.0
        sumxy = 0.0
        sum_bond_fusion = 0.0
       
        do ri = 1, numruns
        t = 0.0
        x = 0.0
        y = 0.0
        started =0
        maxtime  = mi 

   !     print*, 1.0*((nodes-1.0)/Lxy)*((nodes-1.0)/Lxy)

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
      
       do while (t .lt. maxtime .or. started .eq. 0)

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
            x = 0.0
            y = 0.0
            t = Delta_t
            started = 1
          endif
         
      
         if(t .lt. maxtime .or. started .eq. 0) then
 
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
             !       write(123,*) mi, ri, t, x, y , rand2, rate_right, "R"
           endif

                cumrate = cumrate + rate_up
           if((rand2 .lt. (cumrate/total_rate)) .and. (found .eq. 0)) then
                    x = x 
                    y = y + 1.0
                    found = 1
              !      write(123,*) mi, ri, t, x, y ,rand2, rate_up, "U"

            endif
              
                cumrate = cumrate + rate_down
           if((rand2 .le. (cumrate/total_rate)) .and. (found .eq. 0)) then
                    x = x 
                    y = y - 1.0
                    found = 1
               !     write(123,*) mi, ri, t, x, y , rand2, rate_down,"D"
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
                               !  write(222,*) t, i, j, bx(i), by(i), bx(j), by(j), cntx1, "=="
                                 endif
                             endif

                            if (bx(j) .eq. (xpos(i)+0.5) .and. (by(j) .eq. ypos(i))) then   ! bonds around 1st node in right
                                 if (i .ne. j) then
                                 cntx2 = cntx2 + 1
                               !  write(222,*) t, i, j, bx(i), by(i), bx(j), by(j), cntx2, "=="
                                 endif
                             endif

                            if (bx(j) .eq. (xposnext(i)-0.5) .and. (by(j) .eq. yposnext(i))) then ! bonds around 2nd node left
                                 if (i .ne. j) then
                                 cntxx1 = cntxx1 + 1
                               !  write(222,*) t, i, j, bx(i), by(i), bx(j), by(j), cntxx1, "=="
                                 endif
                             endif


                             if (bx(j) .eq. (xposnext(i)+0.5) .and. (by(j) .eq. yposnext(i))) then  ! bonds around 2nd node in right
                                 if (i .ne. j) then
                                 cntxx2 = cntxx2 + 1
                               !  write(222,*) t, i, j, bx(i), by(i), bx(j), by(j), cntxx2, "=="
                                 endif
                             endif

                             if (bx(j) .eq. (xpos(i)) .and. (by(j) .eq. (ypos(i)-0.5))) then  ! bonds around 1st node in down
                                 if (i .ne. j) then
                                 cnty1 = cnty1 + 1
                               !  write(222,*) t, i, j, bx(i), by(i), bx(j), by(j), cnty1, "=="
                                 endif
                             endif

                             if (bx(j) .eq. (xpos(i)) .and. (by(j) .eq. (ypos(i)+0.5))) then ! bonds around 1st node in up
                                 if (i .ne. j) then
                                  cnty2 = cnty2 + 1
                               !  write(222,*) t, i, j, bx(i), by(i), bx(j), by(j), cnty2, "=="
                                 endif
                             endif

                             if (bx(j) .eq. (xposnext(i)) .and. (by(j) .eq. (yposnext(i)-0.5))) then  ! bonds around 2nd node in down
                                 if (i .ne. j) then
                                 cntyy1 = cntyy1 + 1
                              !   write(222,*) t, i, j, bx(i), by(i), bx(j), by(j), cntyy1, "=="
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
        !           if (cnt1_total .gt. 0 .and. cnt2_total .gt. 0) then
        !             write (333,*) t, cnt1_total, cnt2_total, "cnt"
        !           endif
        if ((cnt1_total .lt. 2) .and. (cnt2_total .lt. 2)) then
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
 
        elseif (t .gt. maxtime) then
                t = maxtime
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
!**************************************************************************************************************************  
   !   print*,(Lxy/(nodes-1.0)), "new"
         x_rec = x*(Lxy/(nodes-1.0))
         y_rec = y*(Lxy/(nodes-1.0))
         t_rec = t*((Lxy/(nodes-1.0))*(Lxy/(nodes-1.0)))
         !print*, ((Lxy*Lxy)/(nodes*nodes)) 
      !   print*, ((Lxy/nodes)*(Lxy/nodes)) 
!        print*, mi, ri,(Lxy/nodes), x, y, x_rec, y_rec, t, t_rec

         sumx = sumx + x_rec
         sumy = sumy + y_rec
         sumx2 = sumx2 + ((x_rec)**2)
         sumy2 = sumy2 + ((y_rec)**2)
         sumxy = sumxy + ((x_rec)**2 + (y_rec)**2)
         sum_bond_fusion = sum_bond_fusion + rate_bond_fusion
   
        enddo                              !run loop

         sumx = sumx/real(numruns)
         sumy = sumy/real(numruns)
         sumx2 = sumx2/real(numruns)
         sumy2 = sumy2/real(numruns)
         sumxy = sumxy/real(numruns)
         
         open(unit = 125,file= "diffusion_time.dat",Access = 'append')
         write(125,*) mi, t_rec, sumx2, sumy2, sumxy
         close(125)
  enddo   ! time loop

end program
