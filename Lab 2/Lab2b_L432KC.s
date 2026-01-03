/*Author - Lab Tech. Last edited on Jan 14, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global TestAsmCall
.global printf
.global cr
.syntax unified

.text
TestAsmCall:
PUSH {lr}
/*--------------------------------------*/

/*-------Students write their code here ------------*/

/*--------------------------------------*/
/* Author: Misbah Ahmed Nauman, Student ID: 1830574 */
/* Author: Muhammad Ayaan Hafeez, Student ID: 1805075*/
/*--------------------------------------*/ 



LDR R0, =0x20001000       // Load base address of operational code
LDR R1, [R0]              // Load number of data points (n)
LDR R2, [R0, #4]          // Load address of X array
LDR R3, [R0, #8]          // Load address of Y array
LDR R5, [R0, #0x10]       // Load address to store final result

LDR R6, [R2]              // Load first X value (X[0])
LDR R7, [R2, #4]          // Load second X value (X[1])
SUB R8, R7, R6            // Compute delta_x = X[1] - X[0]

MOV R9, #0                // Initialize integer_sum
MOV R10, #0               // Initialize fraction_count (for delta_x=1 handling)

MOV R0, R1                // Copy number of data points to R0
SUB R0, R0, #1            // Adjust for (n-1) iterations
MOV R6, #0                // Initialize loop index (i = 0)

loop:
    CMP R6, R0                // Check if i >= n-1
    BGE loop_end              // Exit loop if all iterations are done

    LDR R11, [R3, R6, LSL #2] // Load Y[i]
    ADD R7, R6, #1            // Compute i+1
    LDR R12, [R3, R7, LSL #2] // Load Y[i+1]
    ADD R11, R11, R12         // Compute sum = Y[i] + Y[i+1]

    CMP R8, #1                // Check delta_x value
    BEQ case1                 // If delta_x = 1, go to case1
    CMP R8, #2
    BEQ case2                 // If delta_x = 2, go to case2
    CMP R8, #4
    BEQ case3                 // If delta_x = 4, go to case3

case1:                         // Case when delta_x = 1
    LSR R12, R11, #1         // Perform integer division: term = sum / 2
    ADD R9, R9, R12          // Add term to integer_sum
    TST R11, #1              // Check if sum is odd
    BNE increment_fraction_count
    B case_end

increment_fraction_count:
    ADD R10, R10, #1       // Increment fraction_count if sum was odd
    B case_end

case2:                         // Case when delta_x = 2
    ADD R9, R9, R11          // term = sum (since delta_x = 2)
    B case_end

case3:                         // Case when delta_x = 4
    LSL R12, R11, #1         // Multiply sum by 2: term = sum * 2
    ADD R9, R9, R12          // Add term to integer_sum

case_end:
    ADD R6, R6, #1           // Increment loop index (i)
    B loop                   // Repeat loop

loop_end:
    CMP R8, #1                // Check if delta_x = 1
    BNE store_result          // If not, skip fraction adjustment

    ADD R9, R9, R10, LSR #1   // Add fraction_count / 2 to integer_sum
    TST R10, #1               // Check if fraction_count is odd
    BNE fractional_part       // If odd, adjust final sum
    B store_result

fractional_part:
    ADD R9, R9, #1          // Round up final result if fraction_count was odd

store_result:
    STR R9, [R5]              // Store final computed area result

END:



/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
POP {PC}

.data
/*--------------------------------------*/
