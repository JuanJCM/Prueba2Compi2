.data
vocales: .asciiz "aeiou"
input: .asciiz "Ingrese la cadena de entrada(sin limite):"
print: .asciiz "\n Total de vocales: " 
.text

main: li $t0, 0
      li $t1, 1
      li $t2, 0
      li $t3, 1
      li $t4, 0
      la $a0, input 
      li $v0, 4
      syscall
      li $v0, 8


input_loop: 
    beqz $t1 jump
    lb $t1 input($t0)
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
    la $a0 jump
    li $v0 4
    syscall
    move $a0 $t4
    li $v0 1
    syscall 
    b exit

exit: li $v0 10
     sycall