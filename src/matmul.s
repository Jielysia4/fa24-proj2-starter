.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 38
# =======================================================
matmul:

    # Error checks
    li t0 1
    blt a1 t0 Exceptions
    blt a2 t0 Exceptions
    blt a4 t0 Exceptions
    blt a5 t0 Exceptions
    bne a2 a4 Exceptions

    # Prologue
    addi sp sp -30
    sw s0 0(sp)
    sw s1 4(sp) 
    sw s2 8(sp) 
    sw s3 12(sp) 
    sw s4 16(sp)
    sw s5 20(sp)
    sw s6 25(sp)
  
  # store the "a" registers
    mv s0 a0
    mv s1 a1
    mv s2 a2
    mv s3 a3
    mv s4 a4
    mv s5 a5
    mv s6 a6
    li t0 0 # i
    li t1 0 # j

outer_loop_start:
    bge t0 s1 outer_loop_end




inner_loop_start:
    bge t1 s5 inner_loop_end
    mul t2 t0 s2 # i * rows of m0

    slli t2 t2 2
    add a0 s0 t2

    slli t1 t1 2
    add a1 s3 t1
    srli t1 t1 2

    mv a2 s2
    li a3 1
    mv a4 s5

    addi sp sp -16
    sw t0 0(sp)
    sw t1 4(sp)
    sw t2 8(sp)
    sw ra 12(sp)
    jal ra dot
    lw t0 0(sp)
    lw t1 4(sp)
    lw t2 8(sp)
    lw ra 12(sp)
    addi sp sp 16

    mul t2 t0 s5
    add t2 t2 t1
    slli t2 t2 2
    add t2 t2 s6
    sw a0 0(t2)
    addi t1 t1 1 # j + 1
    j inner_loop_start

inner_loop_end:
    addi t0 t0 1 # i + 1
    li t1 0 # t1 = 0
    j outer_loop_start




outer_loop_end:


    # Epilogue
    lw s0 0(sp)
    lw s1 4(sp) 
    lw s2 8(sp) 
    lw s3 12(sp) 
    lw s4 16(sp)
    lw s5 20(sp)
    lw s6 25(sp)
    addi sp sp 30
    jr ra

Exceptions:
    li a0 38
    j exit