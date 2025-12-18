# Matrix Multiplication in PostgreSQL

This project shows how to store, validate, display, and multiply matrices inside PostgreSQL using SQL and PL/pgSQL. We then benchmark our multiplication algorithm against NumPy and Python and find that, for sparse matrices, our approach is faster.

**Read the [write up](write-up/main.pdf).**


## Project Files

| File | Description |
|------|-------------|
| **[0create.sql](sql/0create.sql)** | Creates table `A` and inserts a sample matrix |
| **[1check.sql](sql/1check.sql)** | Defines `mat_check(text)` to verify matrix completeness and index correctness |
| **[2visualise.sql](sql/2visualise.sql)** | Defines `mat_vis(text)` to print each matrix row as a text string |
| **[3multiply.sql](sql/3multiply.sql)** | Defines `mat_mul(text, text, text)` for matrix multiplication |
| **[benchmark.ipynb](benchmark.ipynb)** | Benchmarks the SQL approach against the Python approach |
| **[main.pdf](write-up/main.pdf)** | The write up for the project |

## Setup

```sql
createdb linalg
```

```bash
psql -U postgres -d linalg -f ./sql/0create.sql
psql -U postgres -d linalg -f ./sql/1check.sql
psql -U postgres -d linalg -f ./sql/2visualise.sql
psql -U postgres -d linalg -f ./sql/3multiply.sql
```

```bash
pip install -r requirements.txt
```