# Mips_Programming
Assignments from our coursework on mips

Assignment 1

Aim: Handling of local variables in subroutines by allocating space on stack. Handling (local) arrays
in MIPS.

Assignment statement: Finding the kth largest, 3 ≤ k ≤ 20, of n integers. Write a MIPS program
which:

(a) allocates space on stack for two local integer variables n and k; give comments indicating how
you would access in your program the memory locations corresponding to n, k and a[i].

(b) reads the integer k with the prompt: ”Enter the value of k:”;

(c) allocates space for a[i], 0 ≤ i < k, on the stack;

(d) reads an integer with the prompt – ”Enter the count of elements to be read:”

(e) finds the kth largest among the n elements read one by one using proper prompt(s) and

(f) prints the same within the message – ”The %d-th largest number among [a comma separated
list of the n numbers read] is:” h the k-th largest number i

Assignment 2

Aim : Writing a function subroutine in MIPS, allocating variables dynamically on the stack, passing
parameters to functions by value, passing (local) arrays to functions by their addresses.

Assignment statement:
(a) Write a function matPrint that is passed the following parameters: (positive) integers m and n
and the address of a two dimensional m × n integer array A storing the matrix in row major
form. It is to print the elements of A in a row major manner.

(b) Write a function matTrans that is passed the following parameters: (positive) integers m and
n and addresses of two integer arrays A and B. It is to compute the transpose matrix of the
matrix A in the n × m matrix B.

(c) Write a MIPS program which:
i. prompts the user for three positive integers m, n and s as ”Enter three positive integers m,
n and s: ”,

ii. allocates space for an m × n integer array A and an n × m integer array B on the stack,

iii. populates the array A with random numbers generated using the linear congruential scheme:
Xn+1 = (aXn + c) mod m, taking a=7 × 47+1, c=100 and m = 482-1.
Let X0 = s (the seed).

iv. prints the elements of A using matPrint,

v. Computes B ← At using matTrans,

vi. prints the elements of B using matPrint.

Assignment 3

Aim:
Writing a recursive function subprogram in MIPS

Dynamically allocating variables on the stack

Passing parameters to functions by value

Passing arrays to functions by their address

Assignment statement:

(a) Write a subroutine sqMatPrint that is passed the following parameters: A (positive) integer n
and the address of a two dimensional integer square matrix A storing the matrix in row major
form. It is to print the elements of A in a row major manner.

(b) Write a recursive subroutine findDet that is passed the following parameters: A (positive)
integer n and the address of a square integer matrix A.
It first prints the matrix A using the subroutine sqMatPrint with the preceding prompt ”The
matrix passed on this invocation is:”
It recursively computes the determinant of the matrix A. On exit it returns the determinant
value with the prompt ”The determinant value returned in this invocation is :”

(c) Write a MIPS program which:
i. prompts the user for a positive integer n as ”Enter the order of the square matrix whose
determinant is to be found”,

ii. allocates space for a square integer matrix A and an integer square matrix A of order n on
the stack,

iii. prompts the user for a positive integer s as ”Enter some positive integer for the value of the
seed s:”,

iv. populates the array A with random numbers generated using the linear congruential scheme:
Xn+1 = (aXn + c) mod m, taking a=7 × 47+1, c=100 and m = 482-1.
Let X0 = s (the seed).

v. prints the elements of A using matPrint,

vi. Computes the determinant |A| using findDet,

vii. prints the determinant with the prompt ”Finally the determinant is : %d”
