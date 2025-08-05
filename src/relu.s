.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue
    addi sp sp -12
    sw s0 0(sp)
    sw s1 4(sp)
    sw s2 8(sp)
    addi s0 a0 0 # the pointer of array
    addi s1 x0 0 # bias of array in memrray or i
    addi s2 x0 1
    bge a1 s2  loop_start
    j Exceptions

loop_start:
    lw s2 0(s0)
    blt s2 x0 loop_continue
loop_start_2:
    sw s2 0(s0)
    addi s1 s1 1
    addi s0 s0 4
    bge s1 a1 loop_end
    j loop_start

    
    



loop_continue:
    addi s2 x0 0
    j loop_start_2



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
    
    