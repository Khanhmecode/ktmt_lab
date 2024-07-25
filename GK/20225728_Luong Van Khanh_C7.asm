.data
xau: .space 10        # Khai báo m?ng 
in: .asciiz "Nhap xau ki tu: "
out: .asciiz "Xau ki tu sau khi chuyen: "

.text
main:
    li $v0,54
    la $a0,in
    la $a1,xau
    la $a2,10	
    syscall

    # G?i hàm ?? chuy?n ??i xâu kí t?
    la $a0, xau           # truy?n ??a ch? c?a xâu kí t? vào $a0
    jal chuyen_doi

    # In ra xâu k?t qu?
    li $v0, 4                  
    la $a0, out              # load ??a ch? c?a chu?i c?n in
    syscall

    # In xâu k?t qu?
    li $v0, 4                   
    la $a0, xau          # load ??a ch? c?a xâu k?t qu?
    syscall

    # K?t thúc ch??ng trình
    li $v0, 10               
    syscall


chuyen_doi:
	# L?p qua t?ng ký t? trong xâu kí t?
	la $t0, 0                   #  ch? s? c?a ký t?
loop:
        lb $t1, 0($a0)          # ??c ký t? t?i ??a ch? $a0 và l?u vào $t1
        beqz $t1, end     # n?u ký t? là NULL, thoát kh?i vòng l?p

        # Ki?m tra ký t? là ch? th??ng
        li $t2, 97              # ASCII c?a 'a'
        li $t3, 122             # ASCII c?a 'z'
        blt $t1, $t2, NOT   # n?u ký t? nh? h?n 'a', không ph?i ch? th??ng
        bgt $t1, $t3, NOT   # n?u ký t? l?n h?n 'z', không ph?i ch? th??ng

        # th??ng => hoa
        addi $t1, $t1, -32      
        sb $t1, 0($a0)         
        j NEXT       

NOT:
        li $t2, 65              # ASCII c?a 'A'
        li $t3, 90              # ASCII c?a 'Z'
        blt $t1, $t2, NEXT   # n?u ký t? nh? h?n 'A', không ph?i ch? hoa
        bgt $t1, $t3, NEXT   # n?u ký t? l?n h?n 'Z', không ph?i ch? hoa

        # hoa => th??ng 
        add $t1, $t1, 32        
        sb $t1, 0($a0)          

NEXT:
        addi $a0, $a0, 1        # di chuy?n ??a ch? ?? tr? vào ký t? ti?p theo trong xâu kí t?
        j loop
        
end:
        jr $ra                      
