/*Author - Lab Tech. Last edited on Jan 14, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global Convert
.global printf
.global cr
.extern value
.extern getstring
.extern convert1
.syntax unified

.text
Convert:
/*--------------------------------------*/

/*-------Students write their code here ------------*/
convert:
    // Convert takes ASCII on stack and replaces it with pattern address
    // Entry: ASCII code on stack
    // Exit : Pattern address on stack

    // Preserve LR
    PUSH {LR}

    // Load ASCII value from top of stack into R0
    LDR R0, [SP]

    // Call provided convert1 subroutine to get pattern address
    BL convert1

    // Store pattern address back on the stack (overwrite ASCII)
    STR R0, [SP]

    // Return
    POP {LR}
    BX LR
/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
.data
/*--------------------------------------*/
