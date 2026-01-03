/*Author - Lab Tech. Last edited on Jan 14, 2022 */
/*-----------------DO NOT MODIFY--------*/
/* Author: Misbah Ahmed Nauman, Student ID: 1830574 */
/* Author: Muhammad Ayaan Hafeez, Student ID: 1805075*/
.global Welcomeprompt
.global printf
.global cr
.extern value
.extern getstring
.syntax unified

.text
Welcomeprompt:
/*-----------------Students write their subroutine here--------------------*/
	// Save return address and used registers
	PUSH {LR}
	PUSH {R9}
	PUSH {R8}
	PUSH {R7}
	PUSH {R6}
	PUSH {R5}
	PUSH {R4}

	MOV R7, R0 // Print Welcome
	LDR R0, =Label1
	BL printf
	BL cr
	LDR R0, =Label2
	BL printf
	BL cr

Start:
	LDR R0, =PromptEntry // Ask user for number of entries
	BL printf
	BL cr
	BL getstring // Get the number of entries
	MOV R4, R0 // Store number of entries in R4
	BL value // Prints decimal inputted

	CMP R4,#3 // Check if it's within the range 3-10
	BLT InvalidNumEntries1
	CMP R4,#10
	BGT InvalidNumEntries2

	STR R4,[SP,#28] // Push the number of entries to stack

AskLimits:
	BL cr
	LDR R0, =LowerPrompt
	BL printf
	BL cr
	BL getstring
	MOV R5,R0 // Store lower limit in R5
	BL value

	BL cr
	LDR R0, =UpperPrompt
	BL printf
	BL cr
	BL getstring
	MOV R6,R0 // Store upper limit in R6
	BL value

	CMP R5,R6 // Check if lower limit < upper limit
	BLT AskNumbers // If valid, move to number input
	Bl cr
	LDR R0, =InvalidLim
	BL printf
	BAL AskLimits // If invalid, re-enter only limits

AskNumbers:
	MOV R8,R4 // Copy number of entries to R8 for loop counter

NumberInputLoop:
	BL cr
	CMP R8,#1 // Check if this is the last number to enter
	BEQ LastNumberPrompt // If it's the last number, show a special message

	LDR R0, =EnterNum
	BL printf
	Bl cr
	BL getstring // Get user input
	MOV R9, R0 // Store input number in R9
	BL value

	CMP R9, R5 // Check if number >= lower limit
	BLT InvalidNumber
	CMP R9, R6 // Check if number <= upper limit
	BGT InvalidNumber

	STR R9,[R7],#4 // Store number in memory, move address forward
	SUB R8,#1 // Decrement loop counter

	CMP R8,#0 // Check if all numbers entered
	BNE NumberInputLoop // Repeat until all numbers are entered
	B Done // Jump to the end if no more numbers to input

LastNumberPrompt:
	LDR R0, =LastNum
	BL printf // Display message for the last number
	BL cr
	BL getstring // Get user input for the last number
	MOV R9,R0 // Store input number in R9
	BL value
	BL cr

	CMP R9,R5 // Check if number >= lower limit
	BLT InvalidNumber
	CMP R9,R6 // Check if number <= upper limit
	BGT InvalidNumber

	STR R9,[R7],#4 // Store number in memory, move address forward
	SUB R8,#1 // Decrement loop counter
	B Done

InvalidNumEntries1: // Error message for entries < 3
	BL cr
	LDR R0, =InvalidEntry1
	BL printf
	BL cr
	BAL Start // Restart the subroutine if entries are invalid

InvalidNumEntries2: // Error message for entries > 10
	BL cr
	LDR R0, =InvalidEntry2
	BL printf
	BL cr
	BAL Start // Restart the subroutine if entries are invalid

InvalidNumber:
	BL cr
	LDR R0, =InvalidRange
	BL printf
	BAL NumberInputLoop // Re-enter only the current number

Done:
	POP {R4}
	POP {R5}
	POP {R6}
	POP {R7}
	POP {R8}
	POP {R9}
	POP {PC} // Restore return address and used registers
/*-------Code ends here ---------------------*/

/*-----------------Add your strings here in the data section--------*/
.data
Label1:
.string "ECE212 Lab3"
Label2:
.string "Welcome to ECE212 Bubble Sorting Program"
PromptEntry:
.string "Please enter the number(3min-10max) of enteries followed by 'enter'"
InvalidEntry1:
.string "Invalid entry, Please enter more than 2 entry"
InvalidEntry2:
.string "Invalid entry, Please enter less than 11 entry"
LowerPrompt:
.string "Please enter the lower limit"
UpperPrompt:
.string "Please enter the upper limit"
InvalidLim:
.string "Error. Please enter the lower and upper limit again"
EnterNum:
.string "Please enter a number followed by 'enter'"
InvalidRange:
.string "Invalid!!! Number entered is not within the range"
LastNum:
.string "Please enter the last number followed by 'enter'"
