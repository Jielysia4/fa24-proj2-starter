.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the number of elements to use is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:
    li a5 1
    blt a2 a5 Exceptions_1
    blt a3 a5 Exceptions_2
    blt a4 a5 Exceptions_2

    # Prologue
    addi sp sp -20
    sw s0 0(sp) # address
    sw s1 4(sp) # index of m0
    sw s2 8(sp) # index of m1
    sw s3 12(sp) # dot_product
    sw s4 16(sp) # count

    # initial
    li s1 0
    li s2 0
    li s3 0
    li s4 0
loop_start:
    slli s1 s1 2
    add s0 a0 s1
    srli s1 s1 2
    lw a6 0(s0)
    slli s2 s2 2
    add s0 a1 s2
    srli s2 s2 2
    lw a7 0(s0)
    mul a6 a7 a6
    add s3 s3 a6
    addi s4 s4 1
    bge s4 a2 loop_end
    add s1 s1 a3
    add s2 s2 a4
    j loop_start










loop_end:
    mv a0 s3
    
    # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    lw s3 12(sp)
    lw s4 16(sp)
    addi sp sp 20

    jr ra

Exceptions_1:
    li a0 36
    jal exit
Exceptions_2:
    li a0 37
    jal exit