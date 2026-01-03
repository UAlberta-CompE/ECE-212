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

        LDR     R0, =0x20001000          // Load base address of the data
        LDR     R1, [R0]                 // Load size of arrays
        LDR     R2, [R0, #4]             // Load address of first array
        LDR     R3, [R0, #8]             // Load address of second array
        LDR     R4, [R0, #12]            // Load destination address for Register Indirect w/ Offset
        LDR     R7, [R0, #16]            // Load destination address for Indexed Register Indirect
        LDR     R8, [R0, #20]            // Load destination address for Postincrement Register Indirect

// PART 1: Register Indirect with Offset (Process first 3 values)

        LDR     R5, [R2]                 // Load first element from first array
        LDR     R6, [R3]                 // Load first element from second array
        ADD     R6, R5                   // Add values
        STR     R6, [R4]                 // Store result in destination array

        LDR     R5, [R2, #4]             // Load second element from first array
        LDR     R6, [R3, #4]             // Load second element from second array
        ADD     R6, R5                   // Add values
        STR     R6, [R4, #4]             // Store result in destination array

        LDR     R5, [R2, #8]             // Load third element from first array
        LDR     R6, [R3, #8]             // Load third element from second array
        ADD     R6, R5                   // Add values
        STR     R6, [R4, #8]             // Store result in destination array

// PART 2: Indexed Register Indirect (Process full array)

        MOV     R9, #0                   // Initialize index counter
        MOV     R10, R1                  // Load size of array into R10 (for loop condition)

Part2_Loop:
        LDR     R5, [R2, R9]             // Load current element from first array
        LDR     R6, [R3, R9]             // Load current element from second array
        ADD     R6, R5                   // Add values
        STR     R6, [R7, R9]             // Store result in destination array

        ADD     R9, #4                   // Move to next index
        SUB     R10, #1                  // Decrement loop counter
        CMP     R10, #0                  // Check if all elements are processed
        BEQ     Part3_Start               // If finished, jump to Part 3
        B       Part2_Loop                // Otherwise, repeat loop

// PART 3: Postincrement Register Indirect (Process full array)

Part3_Start:
        MOV     R11, R1                  // Load array size into R11

Part3_Loop:
        LDR     R5, [R2], #4             // Load current element from first array and increment pointer
        LDR     R6, [R3], #4             // Load current element from second array and increment pointer
        ADD     R6, R5                   // Add values
        STR     R6, [R8], #4             // Store result in destination array and increment pointer

        SUB     R11, #1                  // Decrement loop counter
        CMP     R11, #0                  // Check if all elements are processed
        BEQ     End                      // If finished, jump to end
        B       Part3_Loop                // Otherwise, repeat loop

End:



/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
POP {PC}

.data
/*--------------------------------------*/
