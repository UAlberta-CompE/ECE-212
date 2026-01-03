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
	 LDR R1, =0x20003000

	loop:
		LDR R2, [R0]
		CMP R2, #0x0D
		BEQ exit

		CMP R2, #'A'
		BLT invalid_char
		CMP R2, #'Z'
		BLE convert_uppercase

		CMP R2, #'a'
		BLT invalid_char
		CMP R2, #'z'
		BLE convert_lowercase

	invalid_char:
		MOV R3, #'*'
		STR R3, [R1]
		B next_char

	convert_uppercase:
		ADD R3, R2, #32
		B store_result

	convert_lowercase:
		SUB R3, R2, #32

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
