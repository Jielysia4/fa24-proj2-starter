.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
#   - If malloc returns an error,
#     this function terminates the program with error code 26
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fread error or eof,
#     this function terminates the program with error code 29
# ==============================================================================
read_matrix:

    # Prologue
    addi sp sp -28
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    sw s3 12(sp)
    sw s4 16(sp)
    sw s5 20(sp)
    sw ra 24(sp)

    mv s0 a0
    mv s1 a1
    mv s2 a2

    mv a0 s0
    li a1 0
    jal ra fopen
    mv s4 a0
    li s3 -1
    beq s4 s3 error_2

    mv a0 s4
    mv a1 s1
    li a2 4
    jal ra fread
    li s3 4
    bne a0 s3 error_4

    mv a0 s4
    mv a1 s2
    li a2 4
    jal ra fread
    bne a0 s3 error_4

    lw s1 0(s1)
    lw s2 0(s2)

    mul s5 s1 s2
    slli s5 s5 2
    mv a0 s5
    jal ra malloc

    li s3 0
    beq a0 s3 error_1

    mv s1 a0
    mv a0 s4
    mv a1 s1
    mv a2 s5
    jal ra fread
    bne a0 s5 error_4
    
    mv a0 s4
    jal ra fclose
    li s3 -1
    beq a0 s3 error_3

    # Epilogue
    mv a0 s1
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw ra 24(sp)
    addi sp sp 28

    jr ra

error_1:
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw ra 24(sp)
    addi sp sp 28
    li a0 26
    j exit

error_2:
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw ra 24(sp)
    addi sp sp 28
    li a0 27
    j exit

error_3:
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw ra 24(sp)
    addi sp sp 28
    li a0 28
    j exit

error_4:
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    lw s5 20(sp)
    lw ra 24(sp)
    addi sp sp 28
    li a0 29
    j exit