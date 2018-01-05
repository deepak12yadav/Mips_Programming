# Mips_Programming
Assignments from our coursework on mips
Aim: Handling of local variables in subroutines by allocating space on stack. Handling (local) arrays
in MIPS.
Assignment statement: Finding the kth largest, 3 ≤ k ≤ 20, of n integers. Write a MIPS program
which:
(a) allocates space on stack for two local integer variables n and k; give comments indicating how
you would access in your program the memory locations corresponding to n, k and a[i]. [Hint:
Use the frame pointer f p – refer to pp A-23 –A-26 in Appendix A of Hennesey and Patterson
for identifying how local variables are allocated space on the stack dynamically on entry to
subroutines (recall that the main routine can be viewed as a subroutine for code generation)
and the allocation is undone before exit thereby maintaining the locality of the local variables,
in contrast to the global variables defined through the .rdata assembler commands.]
(b) reads the integer k with the prompt: ”Enter the value of k:”;
(c) allocates space for a[i], 0 ≤ i < k, on the stack;
(d) reads an integer with the prompt – ”Enter the count of elements to be read:”
(e) finds the kth largest among the n elements read one by one using proper prompt(s) and
(f) prints the same within the message – ”The %d-th largest number among [a comma separated
list of the n numbers read] is:” h the k-th largest number i