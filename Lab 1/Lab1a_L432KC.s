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

 LDR R0, =0x20001000
 LDR R1, =0x20002000

loop:
    LDR R2, [R0]
    CMP R2, #0x0D
    BEQ exit

    CMP R2, #'0'
    BLT invalid_char
    CMP R2, #'9'
    BLE convert_digit

    CMP R2, #'A'
    BLT invalid_char
    CMP R2, #'F'
    BLE convert_uppercase

    CMP R2, #'a'
    BLT invalid_char
    CMP R2, #'f'
    BLE convert_lowercase

invalid_char:
    MOV R3, #-1
    STR R3, [R1]
    B next_char

convert_digit:
    SUB R3, R2, #'0'
    B store_result

convert_uppercase:
    SUB R3, R2, #55
    B store_result

convert_lowercase:
    SUB R3, R2, #87

store_result:
    STR R3, [R1]

next_char:
    ADD R0, R0, #4
    ADD R1, R1, #4
    B loop

exit:


/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
POP {PC}

.data
/*--------------------------------------*/
