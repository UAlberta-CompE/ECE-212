/*Author - Lab Tech. Last edited on Jan 14, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global Welcomeprompt
.global printf
.global cr
.extern value
.extern getstring
.extern getchar
.extern putchar
.syntax unified

.text
Welcomeprompt:
/*--------------------------------------*/

/*-------Students write their code here ------------*/
    // Preserve registers
    PUSH {R4, LR}

WelcomeLoop:
    // Print welcome message
    LDR R0, =Welcome
    BL printf
    BL cr

    // Ask user for a valid keystroke
    LDR R0, =Prompt
    BL printf
    BL cr

    // Get user keystroke
    BL getchar         // Result in R0 (ASCII code)
    MOV R4, R0         // Save in R4 for later

    // Check if it’s a number (0x30 - 0x39)
    CMP R0, #'0'       // Compare with ASCII '0'
    BLT CheckAlpha     // If less, check for uppercase letters
    CMP R0, #'9'
    BLE ValidInput     // If between '0' and '9', it’s valid

CheckAlpha:
    CMP R0, #'A'       // Check for A-Z
    BLT Invalid
    CMP R0, #'Z'
    BGT Invalid

ValidInput:
    // Valid entry – push ASCII code onto the stack
    MOV R0, R4
    STR R0, [SP]       // Store ASCII code on top of stack
    B DonePrompt

Invalid:
    // Show error and loop again
    LDR R0, =InvalidEntry
    BL printf
    BL cr
    B WelcomeLoop

DonePrompt:
    // Restore registers and return
    POP {R4, LR}
    BX LR
/*-----------------DO NOT MODIFY--------*/

.data
/*--------------------------------------*/
Welcome:
.string "Welcome to Wing’s LED Display"
Prompt:
.string "Please enter an UpperCase letter or Number from the keyboard"
InvalidEntry:
.string "Invalid entry, please enter proper keystroke from keyboard"