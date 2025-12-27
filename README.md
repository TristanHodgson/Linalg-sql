# Matrix Multiplication in PostgreSQL

This project shows how to store, validate, display, and multiply matrices inside PostgreSQL using SQL and PL/pgSQL. We then benchmark our multiplication algorithm against NumPy and Python and find that, for sparse matrices, our approach is faster.

**Read the [write up](write-up/main.pdf).**


## Project Files

| File | Description |
|------|-------------|
| **[create.sql](sql/0create.sql)** | Creates table `A` and inserts a sample matrix |
| **[multiply.sql](sql/3multiply.sql)** | Defines `mat_mul(text, text, text)` for matrix multiplication |
| **[benchmark.ipynb](benchmark.ipynb)** | Benchmarks the SQL approach against the Python approach |
| **[main.pdf](write-up/main.pdf)** | The write up for the project |

## Setup

```sql
createdb linalg
```

```bash
psql -U postgres -d linalg -f ./sql/create.sql
psql -U postgres -d linalg -f ./sql/multiply.sql
```

```bash
pip install -r requirements.txt
```