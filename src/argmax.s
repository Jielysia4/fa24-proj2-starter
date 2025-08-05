.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Prologue
    addi  sp sp -12
    sw s0 0(sp) # address of the array
    sw s1 4(sp) # i
    sw s2 8(sp) # the current maxnum
    mv s0 a0
    li a0 0 # maxindex
    li s1 0
    li s2 0
    li a2 1
    bltu a1 a2 Exceptions
loop_start:
    lw a2 0(s0) # store element
    blt s2 a2 loop_continue
loop_continue_two:
    addi s1 s1 1
    addi s0 s0 4
    bge s1 a1 loop_end
    j loop_start


loop_continue:
    mv a0 s1
    mv s2 a2
    j loop_continue_two


loop_end:
    # Epilogue
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    addi sp sp 12
    jr ra

Exceptions:
    lw s0 0(sp)
    lw s1 4(sp)
    lw s2 8(sp)
    addi sp sp 12
    li a0 36
    jal exit