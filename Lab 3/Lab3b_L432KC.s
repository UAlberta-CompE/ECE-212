/*Author - Lab Tech. Last edited on Jan 14, 2022 */
/*-----------------DO NOT MODIFY--------*/
/* Author: Misbah Ahmed Nauman, Student ID: 1830574 */
/* Author: Muhammad Ayaan Hafeez, Student ID: 1805075*/
.global Sort
.global printf
.global cr
.extern value
.extern getstring
.syntax unified
.text
Sort:
/*-----------------Students write their subroutine here--------------------*/
	PUSH {LR}
	PUSH {R12}
	PUSH {R11}
	PUSH {R10}
	PUSH {R9}
	PUSH {R8}
	PUSH {R7}
	PUSH {R6}       		      // Save return address and used registers
	PUSH {R5}
	PUSH {R4}
	LDR R4,[SP,#40]              // Load number of entries from stack
	MOV R5,R0    	             // Move R0=0x20001000 to R5
	SUB R6, R4, #1
	MOV R7, #0
OuterLoop:
	CMP R7, R4
	BGE ExitSort
	MOV R8, #0          // Number of comparisons in this pass
InnerLoop:
	SUB R9, R6, R7
	CMP R8, R9
	BGE Done
	ADD R10, R8, #1
	LDR R11, [R5, R8, LSL #2]     // Load current element
	LDR R12, [R5, R10, LSL #2]    // Load next element
	CMP R11, R12                  // Compare
	BLE NoSwap
	// Swap R0 and R1
	STR R12, [R5, R8, LSL #2]     // Store smaller value in first position
	STR R11, [R5, R10, LSL #2]    // Store larger value in second position
NoSwap:
	ADD R8, #1                    // Move to next pair
	B InnerLoop
Done:
	ADD R7,#1
	B OuterLoop
ExitSort:
	MOV R10, R4
	POP {R4}
	POP {R5}
	POP {R6}
	POP {R7}
	POP {R8}
	POP {R9}
	POP {R10}
	POP {R11}
	POP {R12}
	POP {PC}        // Restore return address and used registers
/*-------Code ends here ---------------------*/
/*-----------------Add your strings here in the data section--------*/
.data
