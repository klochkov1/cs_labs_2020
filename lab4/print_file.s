.include "defs.h"	       /* defs of some linux syscalls AMD64 */

.section .bss		       /* section of global zero init vars */
fd:  .quad 0
len: .quad 0
ptr: .quad 0

.section .text  	       /* read-only section for code */ 

.global _start 		       /* default entry point */ 

_start:
	cmpq $2, (%rsp)        /* check if amount of args is 2 */
	movq $1, %rdi	       /* set exit code to 1*/
	jne  exit	     	   /* exit command if args is not specified */

	movq $SYS_OPEN, %rax   /* SYS_OPEN will be called by syscall */
	movq 16(%rsp), %rdi    /* arg1; must be file name; *filename */	
	movq $O_RDONLY, %rsi   /* flags */ 
	xor  %rdx, %rdx	       /* mode  */
	syscall		     	   /* call SYS_OPEN; returns fd to rax */
	movq %rax, fd	     

	movq $SYS_LSEEK, %rax  /* SYS_LSEEK will be called by syscall */
	movq fd, %rdi 	       /* fd for lseek */
	xor  %rsi, %rsi        /* off_t_offset = 0; from eof */
	movq $SEEK_END, %rdx   /* origin; set to SEEK_END - offset will be calculated
							   form the end of file  */
	syscall
	movq %rax, len	
	
	movq $SYS_MMAP, %rax   /* SYS_MMAP will be called by syscall */
	xor  %rdi, %rdi        /* addr; NULL - new mapping */
	movq len, %rsi 	       /* len */
	movq $PROT_READ, %rdx  /* prot */
	movq $MAP_SHARED, %r10 /* flags */
	movq fd, %r8           /* fd */
	xor  %r9, %r9          /* off */
	syscall
	movq %rax, ptr
	
	movq $SYS_WRITE, %rax  /* SYS_WRITE will be called by syscall */
	movq $STDOUT, %rdi     /* fd */
	movq ptr, %rsi         /* *buff */
	movq len, %rdx         /* count */
	syscall

	movq $SYS_MUNMAP, %rax /* SYS_MUNMAP will be called by syscall */  
	movq ptr, %rdi         /* addr */
	movq len, %rsi         /* len */
	syscall

	movq $SYS_CLOSE, %rax  /* SYS_MUNMAP will be called by syscall */  
	movq fd, %rdi          /* fd */
	syscall

    xor  %rdi, %rdi		   /* set exit code to 0 */

exit:
	movq $SYS_EXIT, %rax
	syscall
