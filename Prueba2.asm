.data
vocales: .asciiz "aeiou"
input : .asciiz "Ingrese la cadena(1024): "
print: .asciiz "\n Total de vocales: " 
buffer: .space 1024
.text

main: li $t0, 0
      li $t1, 1
      li $t2, 0
      li $t3, 1
      li $t4, 0
      la  $a0, input
      li  $v0, 4
      syscall

      la  $a0, buffer
      li  $a1, 1024
      li  $v0, 8
      syscall

      la $t0, buffer

input_loop: 
    beqz $t1 jump
    lb $t1, ($t0)
    jal vocals_lookup
    addi $t0 $t0 1
    b input_loop

vocals_lookup:
    beqz $t3 vocals_return
    beq $t1 $t3 vocal_found
    lb $t3 vocales($t2)
    addi $t2 $t2 1
    b vocals_lookup

vocal_found: 
    addi $t4 $t4 1
    b vocals_return

vocals_return:
    li $t2 0
    li $t3 1
    jr $ra

jump:
    la $a0 print
    li $v0 4
    syscall
    move $a0 $t4
    li $v0 1
    syscall 
    b exit

exit: li $v0 10
     syscall