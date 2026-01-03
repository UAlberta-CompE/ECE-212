/*Author - Lab Tech. Last edited on Jan 14, 2022 */
/*-----------------DO NOT MODIFY--------*/
/* Author: Misbah Ahmed Nauman, Student ID: 1830574 */
/* Author: Muhammad Ayaan Hafeez, Student ID: 1805075*/
.global Display
.global printf
.global cr
.extern value
.extern getstring
.syntax unified

.text
Display:
/*-----------------Students write their subroutine here--------------------*/
	PUSH {LR} // Save return address
	PUSH {R10}
	PUSH {R6}
	PUSH {R5}
	PUSH {R4}

	LDR R5, [SP,#24] // Load base address of array
	LDR R0, =Label1
	BL printf
	BL cr

	LDR R0, =LabelNumEntries // Load label for "Number of entries"
	BL printf

	LDR R4, [SP,#20] // Load number of elements
	MOV R0, R4
	BL value // Display number of entries
	BL cr
	MOV R6, #0 // Index counter

DisplayLoop:
	CMP R6, R4 // Check if we've printed all elements
	BGE DoneDisplay // If done, exit

	LDR R0, [R5, R6, LSL #2] // Load current array element
	// Call print subroutine
	BL value
	BL cr

	ADD R6, R6, #1 // Move to next element
	B DisplayLoop // Repeat

DoneDisplay:
	LDR R0, =Exit
	BL printf
	BL cr

	POP {R4}
	POP {R5}
	POP {R6}
	POP {R10}
	POP {PC} // Restore return address
/*-------Code ends here ---------------------*/

/*-----------------Add your strings here in the data section--------*/
.data
Label1:
.string "The numbers are sorted with bubblesort algorithm"
LabelNumEntries:
.string "The number of entries entered was "
NumOrder:
.string "Sorted from smallest to biggest, the numbers are:"
Exit:
.string "Program ended"
