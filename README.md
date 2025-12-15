# Matrix Tools in PostgreSQL

This project shows how to store, validate, and display matrices inside PostgreSQL using SQL and PL/pgSQL.

## Why?

The alternative to this kind of analysis would be to use SQL purely to pull the data out into another language (e.g. Python) where we could do the matrix operations. In many situations this will be the best approach as other languages are better set up for matrix operations, however there are definitely cases where this would not be ideal. 
* Slow connection speed between the Postgres server and the device
* Very large matrices, for example if using a Markov chain based Page Rank algorithm it may be too slow to pull the data about all internet links into Python (and we likely don't have enough RAM)


---

## Project Files

| File | Description |
|------|-------------|
| **0create.sql** | Creates table `A` and inserts a sample matrix |
| **1check.sql** | Defines `mat_check(text)` to verify matrix completeness and index correctness |
| **2visualise.sql** | Defines `mat_vis(text)` to print each matrix row as a text string |
| **3multiply.sql** | Defines `mat_mul(text, text, text)` and `elm_mul(...)` for matrix multiplication |
| **4pow.sql** | Defines `mat_pow(text, text, int)` to compute matrix powers |
| **5fib.sql** | Defines `fib(int)` using fast matrix exponentiation |

---

## Setup

Run the scripts in order:

```bash
createdb linalg
psql -U postgres -d linalg -f ./0create.sql
psql -U postgres -d linalg -f ./1check.sql
psql -U postgres -d linalg -f ./2visualise.sql
psql -U postgres -d linalg -f ./3multiply.sql
psql -U postgres -d linalg -f ./4pow.sql
psql -U postgres -d linalg -f ./5fib.sql
```

---

## Usage

## Create the matrix

We represent matrices as tables of the form $(i, j, A_{ij})$ so each row is an entry of a table.

### Validate the matrix

```sql
SELECT mat_check('a');
```

Checks that:

- Indices start at 1  
- All entries exist  
- No NULL values  
- Matrix is rectangular  

### Visualise the matrix

```sql
SELECT * FROM mat_vis('a');
```

Example output:

```
1 | 1 0 0
2 | 0 1 0
3 | 0 0 1
```

### Multiplication

```sql
SELECT mat_mul('a','b','c');
```

Computes $C=AB$.

### Matrix Power

```sql
SELECT mat_pow('a','a_pow_5', 5);
```

Computes $A^5$ using repeated multiplication (yes this is a bad way of doing it).

### Fibonacci via Matrix Exponentiation

```sql
SELECT fib(10);
```

This uses the matrix identity:

$$\begin{pmatrix}1 & 1 \\ 1 & 0\end{pmatrix}^{n-1} \begin{pmatrix}1 \\ 1\end{pmatrix}=\begin{pmatrix}F_n \\ F_{n-1}\end{pmatrix}$$


