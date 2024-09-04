        program diffusion_2d
        implicit none
        integer :: i, mi, ri, j, k, time, maxtime, numruns, found
        integer :: bp, bnp, shift, bonds, step, chk, chk2
        integer :: cntNP, cntP, cnt1, cnt2, bond_pass, cntt1, cntt2
        real(8), dimension(10000) :: bx, by, bxx, byy, f, ff
        real(8), dimension(10000) :: bpx, bpy, bnpx, bnpy, flagp, flagnp
        real(8) :: x, y, t, Delta_t, x_rec, y_rec, t_rec
        real(8) :: rate_left, rate_right, rate_up, rate_down, total_rate
        real(8) :: cumrate, rannum, rand1, rand2, rtime, rpos, rand3, flip, rnum
        real(8) :: sumx, sumy , sumx2, sumy2, sumxy
        real(8) :: a(10000), b(10000), px(10000), py(10000), n, r, cumuflu
        real(8) :: total_rate_bond_remove, total_rate_bond_add, rate_bond_remove, rate_bond_add
        real(8) :: bondprob, Lxy, nodes, tau

        time = 500
        numruns = 100
        Lxy = 20.0
       
        bonds = 1012
        nodes = 22.0
        bondprob = 0.1602
        tau = 1.0
        rate_bond_add = bondprob/tau
        rate_bond_remove = (rate_bond_add*(1-bondprob)/(bondprob))
        print*, tau, bondprob, rate_bond_add, rate_bond_remove, nodes


        
        
        open(unit = 125,file= "diffusion_time.dat")
        close(125)
       !open(unit = 125,file= "diffusion_time.dat",Access = 'append')
       !open(unit = 125,file= "diffusion_time.dat",status="unknown", action="write")
      
      
 !***********read bond file***************
 open(121,file="bond_pos_L22n22.dat")
 do i= 1, bonds
  read(121,*) a(i), b(i), f(i)
  bx(i) = a(i)
  by(i) = b(i)
 enddo
 close(121)
       
       do mi = 1, time   ! time loop
        sumx = 0.0
        sumy = 0.0
        sumx2 = 0.0
        sumy2 = 0.0
        sumxy = 0.0

    
       do ri = 1, numruns
 
        x = 0.0
        y = 0.0
        t = 0.0


       maxtime  = mi 

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

    !     print*,mi, ri, rnum, bondprob, j, f(j)
       enddo

!       print*, bondprob, mi, ri, cntt1, cntt2, "cntt_count"
       do while (t .lt. maxtime)
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

!************************ movement starts **********************************************************


            call random_number(rtime)                    !call the random points
            rand1 = rtime
            
            total_rate = rate_left + rate_right + rate_up + rate_down + total_rate_bond_add &
            + total_rate_bond_remove

            Delta_t = (1.0/total_rate)*log(1.0/rand1)
            t = t + Delta_t
            
      !      print*, mi,ri,total_rate,t

     !print*,mi, ri, t, Delta_t, total_rate, rand1! total_rate_bond_add, total_rate_bond_remove, "bond_add_remove"
            
            if(t .lt. maxtime) then
 
          !          print*, mi, ri, t, maxtime, Delta_t, "=="! total_rate_bond_add, total_rate_bond_remove, "bond_add_remove"
           
             call random_number(rpos)                   !call the random points
            rand2 = rpos

                cumrate = 0.0
                found = 0
                cumrate = cumrate + rate_left
        !   print*, mi, ri, t,"time & run" 
                if((rand2 .lt. (cumrate/total_rate)) .and. (found .eq. 0)) then
                 !       print*, mi, ri, t, rand2, (cumrate/total_rate), "pass_LEFT"
                    x = x - 1.0
                    y = y
                    found = 1
                   ! write(123,*) mi, ri, t, x, y ,rand2, rate_left,  "L"
            endif
                
                cumrate = cumrate + rate_right
            if((rand2 .lt. (cumrate/total_rate)) .and. (found .eq. 0)) then
                 !       print*, mi, ri, t, rand2, (cumrate/total_rate), "pass_RIGHT"
                    x = x + 1.0
                    y = y
                    found = 1
                   ! write(123,*) mi, ri, t, x, y , rand2, rate_right, "R"
            endif

                cumrate = cumrate + rate_up
              if((rand2 .lt. (cumrate/total_rate)) .and. (found .eq. 0)) then
                 !       print*, mi, ri, t, rand2, (cumrate/total_rate), "pass_UP"
                    x = x 
                    y = y + 1.0
                    found = 1
                   ! write(123,*) mi, ri, t, x, y ,rand2, rate_up, "U"

              endif
              
                cumrate = cumrate + rate_down
             if((rand2 .le. (cumrate/total_rate)) .and. (found .eq. 0)) then
                  !      print*, mi, ri, t, rand2, (cumrate/total_rate), "pass_DOWN"
                    x = x 
                    y = y - 1.0
                    found = 1
                   ! write(123,*) mi, ri, t, x, y , rand2, rate_down,"D"
              endif


                        
 !***********************************Bond fluctuation*******************************************
         call random_number(flip)                    !call the random points
               rand3 = flip
               cnt1 = 0; cnt2 = 0
               bond_pass = 0
               cumrate = cumrate + total_rate_bond_add
                     
                 if ((rand2 .le. (cumrate/total_rate)) .and. (found .eq. 0)) then
                        found = 1
                    do i = 1, bonds 
                     if (f(i) .eq. -1) then
                        cnt1 = cnt1 + 1
                      if ((rand3 .le. (real(cnt1)/real(cntNP))) .and. (bond_pass .eq. 0)) then
                       f(i) = 1
                       bond_pass = 1
                      endif
                     endif
                    enddo 
                 endif
             
              cumrate = cumrate + total_rate_bond_remove
                if ((rand2 .le. (cumrate/total_rate)) .and. (found .eq. 0)) then
                        found = 1
                 do i = 1, bonds       
                    if ((f(i) .eq. 1)) then
                        cnt2 = cnt2 + 1
                  !      print*, cnt2, cntP, "cnt_present_bond"
                   !     print*, mi, ri, i, rand3, (real(cnt2)/real(cntP)), "condition_bond_remove"
                      if ((rand3 .le. (real(cnt2)/real(cntP))) .and. (bond_pass .eq. 0)) then
                        f(i) = -1
                        bond_pass = 1
                   !    print*, mi, ri, t, i, bx(i), by(i), "bond_remove"
                      endif
                    endif
                      ! print*, mi, ri, t, i, f(i), "remove"
                 enddo 
               endif
 
        elseif (t .gt. maxtime) then
                t = maxtime
            endif 
     enddo             ! do while loop
    
         x_rec = x*(Lxy/(nodes-1.0))
         y_rec = y*(Lxy/(nodes-1.0))
         t_rec = t*((Lxy/(nodes-1.0))*(Lxy/(nodes-1.0)))

         sumx = sumx + x_rec
         sumy = sumy + y_rec
         sumx2 = sumx2 + ((x_rec)**2)
         sumy2 = sumy2 + ((y_rec)**2)
         sumxy = sumxy + ((x_rec)**2 + (y_rec)**2)
   !      print*, mi, sumx, sumy, sumx2, sumy2, sumxy, "sum1"    
    enddo                              !run loop

         sumx = sumx/real(numruns)
         sumy = sumy/real(numruns)
         sumx2 = sumx2/real(numruns)
         sumy2 = sumy2/real(numruns)
         sumxy = sumxy/real(numruns)
         
         open(unit = 125,file= "diffusion_time.dat",Access = 'append')
         write(125,*) mi, t_rec, sumx2, sumy2, sumxy 
         close(125)   
!         write(125,*) mi, (x_rec)**2, (y_rec)**2, ((x_rec)**2 + (y_rec)**2), "chk"    
!         print*, mi, sumx, sumy, sumx2, sumy2, sumxy, "sum"    

  enddo   ! time loop

end program
