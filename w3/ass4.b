start: 
     li $t2, 4 # y=4
     li $t3, 2 # z=4
     li $t1, 2 # x=2
     li $s1, 4 # i
     li $s2, 5 #j
     add $s3, $s1,$s2
     li $s4, 1 #m
     li $s5, 2 #n
     add $s6, $s4, $s5
     slt $t0,$s6,$s3  # m+n<i+j
     beq $t0,$zero,else 
     addi $t1,$t1,1  #  then part: x=x+1 
     addi $t3,$zero,1  # z=1 
     j endif  # skip “else” part
else: addi $t2,$t2,-1  # begin else part: y=y-1 
     add $t3,$t3,$t3  # z=2*z
endif: