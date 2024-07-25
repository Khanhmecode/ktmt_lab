.data 
in: .asciiz " Nhap so nguyen "
error: .asciiz "Nhap lai \n"
out: .asciiz " 2 chu so cuoi cua so nguyen do la "
.eqv SEVENSEG_LEFT 0xFFFF0010 # Dia chi cua den led 7 doan trai.
# Bit 0 = doan a;
# Bit 1 = doan b; ...
# Bit 7 = dau .
.eqv SEVENSEG_RIGHT 0xFFFF0011 # Dia chi cua den led 7 doan phai

.text 
nhapN:
	li $v0,51 #nhap N
	la $a0,in
        syscall 
        move $t1,$a0
        li $t8,10
checkN:
	blt $t1,$t8,lai
	
	li $v0,4 
	la $a0,out
	syscall
	j tachCS
lai:
	li $v0,4
	la $a0,error
	syscall
	j nhapN
tachCS:
	div $t1,$t8 # N/10
	mflo $t1 # N/=10	
	mfhi $t2 # t2 la cs cuoi 
	div $t1,$t8 
	mfhi $t3 # t3 la cs gan cuoi 
main:
add $a0,$0,$t2,  # set value for segments cs cuoi
jal SHOW_7SEG_LEFT # show
add $a0,$0,$t3 # set value for segments cs gan cuoi 
jal SHOW_7SEG_RIGHT # show
exit: li $v0, 10
syscall
endmain:
#---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT: li $t0, SEVENSEG_LEFT # assign port's address
sb $a0, 0($t0) # assign new value
jr $ra
#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT: li $t0, SEVENSEG_RIGHT # assign port's address
sb $a0, 0($t0) # assign new value
jr $ra
			
	          
