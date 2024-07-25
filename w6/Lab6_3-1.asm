.data
    space: .asciiz " "
    array: .word 5, 3, 8, 4, 2, 1
    length: .word 6  # Length of the array

.text
sort:
    la $a0, array  # Load the address of the array into $a0
    lw $s0, length  # Load the length of the array into $a1
    li $t0,0	#i=0
    outer_loop:
    bge $t0,$s0,end_sort		#end if done
    addi $t1,$0,0			#y=0
    addi $t0,$t0,1			#i++   
	inner_loop:
		sub $t8,$s0,$t0
		bge $t1,$t8,outer_loop
		sll $t2, $t1, 2  	#t2 = 4*y
		add $t3, $t2, $a0 	#t3 = &A[y]
		lw $t4, 0($t3)	  	#t4 = A[y]
		addi $t7,$t3,4  	#t7 = &A[y+1] 
		lw $t5, 0($t7)  	#t5 = A[y+1]
		slt $t6,$t4,$t5 	#compare A[y] with A[y+1]
		bnez $t6,next
		sw $t4,0($t7)		#swap A[y] and A[y+1]
		sw $t5,0($t3)
	next:
		addi $t1,$t1,1		#y++
		j inner_loop
end_sort:

print:
    la $a3, array  # Load the address of the array into $a0
    lw $a1, length  # Load the length of the array into $a1

    # Loop to print each element of the array
    loop:
        lw $t0, 0($a3)  # Load the current element into $t0

        # Print the current element
        li $v0, 1
        move $a0, $t0
        syscall

        # Print a space
        li $v0, 4
        la $a0, space
        syscall

        addiu $a3, $a3, 4  # Move to the next element
        addiu $a1, $a1, -1  # Decrement the length
        bgtz $a1, loop  # If length > 0, repeat the loop

    # Exit the program
    li $v0, 10
    syscall




