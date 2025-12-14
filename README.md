# Matrix Tools in PostgreSQL

This project shows how to store, validate, and display matrices inside PostgreSQL using SQL and PL/pgSQL. It includes:

- A script to create and populate a matrix table  
- A function to check whether a matrix is valid  
- A function to visualise matrix rows as text

---

## Project Files

| File | Description |
|------|-------------|
| **0create.sql** | Creates table `A` and inserts a sample matrix |
| **1check.sql** | Defines `mat_check(text)` to verify matrix completeness and index correctness. |
| **2visualise.sql** | Defines `mat_vis(text)` to print each matrix row as a text string. |
| **3multiply.sql** | Defines `mat_mul(text, text, text)` to multiply two matrices and put their product in a new table |

---

## Setup

Run the scripts in order:

```bash
createdb linalg
psql -U postgres -d linalg -f .\0create.sql
psql -U postgres -d linalg -f .\1check.sql
psql -U postgres -d linalg -f .\2visualise.sql
psql -U postgres -d linalg -f .\3multiply.sql

```

---

## Usage

## Create the matrix

We represent matrices as tables of the form $(i, j, A_{ij})$ so each row is an entry of a table. We therefore expect $n\times m$ entries $\forall A \in \mathbb R^{n\times m}$.

### Validate the matrix

```sql
SELECT mat_check('a');
```

This checks that:

- Indices start at 1  
- All entries exist  
- No NULL values appear  
- The matrix is rectangular  

### Visualise the matrix

```sql
SELECT * FROM mat_vis('a');
```

You will get output such as:

```
1 | 1 0 0
2 | 0 1 0
3 | 0 0 1
```

### Multiplication

```sql
SELECT mat_mul('a','b','c');
```

$$C=AB$$