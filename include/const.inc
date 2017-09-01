

;--------------------------------

%ifdef __FILE__
	%define EOF 						0
%endif

;--------------------------------

%ifdef __MEMORY__

	%define __PAGE__  					0x1000
	%define __MAX_MEMORY__  			0x1000000
	%define __HIGH_MEMORY_USER__ 		0x1000000
	%define __LOW_MEMORY_USER__ 		0x800000
	%define __HIGH_MEMORY_kERNEL__ 		__LOW_MEMORY_USER__
	%define __LOW_MEMORY_KERNEL__ 		0
	%define __LOW_MEMORY_FIX___ 		0
	%define __HIGH_MEMORY_FIX___ 		0x400000
	%define __BUFFER__	 				0
	%define __MAX_PAGE__ 				(__MAX_MEMORY__/__PAGE__)

%endif

;--------------------------------

%ifdef __PROCESS__
	%define EOF 0
	%define EOF 0
	%define EOF 0
%endif

