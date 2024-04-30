.thumb
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

@Hook 0802C080	@{J}
@Hook 0802C138	@{U}

push {r0}

ldr r3, LimitWeaponLevel
cmp r6, r3
blt AddWeaponLevel

@ldr r3, =0x0202BCEC	@ChapterInfo @{J}
ldr r3, =0x0202BCF0	@ChapterInfo @{U}
ldrb r3, [r3, #0xF] @phase
cmp r3, #0x00
bne FalseExit

AddWeaponLevel:
pop {r0}
@blh 0x08017540   @GetItemWExp	@{J}
blh 0x08017798   @GetItemWExp	@{U}
mov r1 ,r7
add r1, #0x7b

@ldr r3, =0x0802C088|1	@{J}
ldr r3, =0x0802C140|1	@{U}
bx  r3

FalseExit:
pop {r0}
@ldr r3, =0x0802C092|1	@{J}
ldr r3, =0x0802C14A|1	@{J}
bx  r3

.ltorg
LimitWeaponLevel:
