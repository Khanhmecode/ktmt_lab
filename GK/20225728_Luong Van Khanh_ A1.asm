.data
 mes1:.asciiz "Nhap so nguyen duong N"
 mes0:.asciiz "Day la so am, nhap lai \n"
 mes2:.asciiz "Cac so thoa man la : "
 mes3:.asciiz " "
.text
main:
    li $v0,51 #nhap N	
    la $a0,mes1
    syscall 
    move $t1,$a0
checkN:
    bltz $t1,lai
        
    li $v0,4 # in ra mes2
    la $a0,mes2
    syscall
    
    li $t8,3
    li $t9,5
    li $s0,0 #gan i=0
    j loop
lai:
    li $v0,4
    la $a0,mes0
    syscall
    j main # Nhap lai N     
loop:    
    slt $t0,$s0,$t1
    beq $t0,$0,end # if i>=N => end
    rem $t2,$s0,$t8
    beqz $t2,print # if i chia het cho 3
    rem $t3,$s0,$t9
    beqz $t3,print # if i chia het cho 5 
    j con
print:
    li $v0,1 #in so i thoa man 
    move $a0,$s0
    syscall 
    li $v0,4
    la $a0,mes3 #in dau cach
    syscall
    
    j con
con:
    addi $s0,$s0,1 #i++
    j loop
end:           
    li $v0,10
    syscall
