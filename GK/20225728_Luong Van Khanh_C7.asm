.data
xau: .space 10        # Khai b�o m?ng 
in: .asciiz "Nhap xau ki tu: "
out: .asciiz "Xau ki tu sau khi chuyen: "

.text
main:
    li $v0,54
    la $a0,in
    la $a1,xau
    la $a2,10	
    syscall

    # G?i h�m ?? chuy?n ??i x�u k� t?
    la $a0, xau           # truy?n ??a ch? c?a x�u k� t? v�o $a0
    jal chuyen_doi

    # In ra x�u k?t qu?
    li $v0, 4                  
    la $a0, out              # load ??a ch? c?a chu?i c?n in
    syscall

    # In x�u k?t qu?
    li $v0, 4                   
    la $a0, xau          # load ??a ch? c?a x�u k?t qu?
    syscall

    # K?t th�c ch??ng tr�nh
    li $v0, 10               
    syscall


chuyen_doi:
	# L?p qua t?ng k� t? trong x�u k� t?
	la $t0, 0                   #  ch? s? c?a k� t?
loop:
        lb $t1, 0($a0)          # ??c k� t? t?i ??a ch? $a0 v� l?u v�o $t1
        beqz $t1, end     # n?u k� t? l� NULL, tho�t kh?i v�ng l?p

        # Ki?m tra k� t? l� ch? th??ng
        li $t2, 97              # ASCII c?a 'a'
        li $t3, 122             # ASCII c?a 'z'
        blt $t1, $t2, NOT   # n?u k� t? nh? h?n 'a', kh�ng ph?i ch? th??ng
        bgt $t1, $t3, NOT   # n?u k� t? l?n h?n 'z', kh�ng ph?i ch? th??ng

        # th??ng => hoa
        addi $t1, $t1, -32      
        sb $t1, 0($a0)         
        j NEXT       

NOT:
        li $t2, 65              # ASCII c?a 'A'
        li $t3, 90              # ASCII c?a 'Z'
        blt $t1, $t2, NEXT   # n?u k� t? nh? h?n 'A', kh�ng ph?i ch? hoa
        bgt $t1, $t3, NEXT   # n?u k� t? l?n h?n 'Z', kh�ng ph?i ch? hoa

        # hoa => th??ng 
        add $t1, $t1, 32        
        sb $t1, 0($a0)          

NEXT:
        addi $a0, $a0, 1        # di chuy?n ??a ch? ?? tr? v�o k� t? ti?p theo trong x�u k� t?
        j loop
        
end:
        jr $ra                      
