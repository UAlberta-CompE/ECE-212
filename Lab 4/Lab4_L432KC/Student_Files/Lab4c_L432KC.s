/*Author - Lab Tech. Last edited on Jan 14, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global Display
.global printf
.global cr
.extern value
.extern getstring
.extern offled()
.extern onled()
.extern column()
.extern row()
.syntax unified

.text
Display:
/*--------------------------------------*/

/*-------Students write their code here ------------*/
    PUSH {R4-R7, LR}         // Save working registers

    MOV R0, #0               // Initialize loop counter
    MOV R1, #100             // Repeat 100 times (you can change this to 50 if desired)

RepeatLoop:
    LDR R4, [SP, #20]        // Load pattern address from stack into R4
                             // (accounting for 4 pushed regs + LR)

    MOV R5, #0               // R5 = row index

RowLoop:
    LDRB R6, [R4, R5]        // R6 = row data (1 byte)

    MOV R0, R5               // Set row
    BL row

    MOV R7, #0               // R7 = column index

ColumnLoop:
    MOV R0, R6
    LSR R0, R0, R7
    AND R0, R0, #1           // Isolate bit

    CMP R0, #1
    BNE Skip

    MOV R0, R7
    BL column

    BL onled
    MOV R0, #5               // Delay to simulate persistence
    BL HAL_Delay
    BL offled

Skip:
    ADD R7, R7, #1
    CMP R7, #8
    BLT ColumnLoop

    ADD R5, R5, #1
    CMP R5, #8
    BLT RowLoop

    ADD R0, R0, #1           // Increment loop counter
    CMP R0, R1
    BLT RepeatLoop           // Repeat if not done

    POP {R4-R7, LR}
    BX LR
/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
.data
/*--------------------------------------*/
