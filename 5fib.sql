CREATE OR REPLACE FUNCTION fib(n int)
RETURNS double precision
LANGUAGE plpgsql
AS $$
DECLARE
  res double precision;
BEGIN
    DROP TABLE IF EXISTS fib_mat;
    DROP TABLE IF EXISTS fib_vec;
    CREATE TABLE fib_mat (
        i INT NOT NULL,
        j INT NOT NULL,
        value DOUBLE PRECISION NOT NULL,
        PRIMARY KEY (i, j)
    );
    INSERT INTO fib_mat (i, j, value) VALUES
        (1, 1, 1.0),
        (1, 2, 1.0),
        (2, 1, 1.0),
        (2, 2, 0.0);

    CREATE TABLE fib_vec (
        i INT NOT NULL,
        j INT NOT NULL,
        value DOUBLE PRECISION NOT NULL,
        PRIMARY KEY (i, j)
    );
    INSERT INTO fib_vec (i, j, value) VALUES
        (1, 1, 1.0),
        (2, 1, 1.0);

    IF n = 1 or n = 0 THEN
        RETURN 1;
    ELSE
        PERFORM mat_pow('fib_mat', 'fib_mat_final', n-1);
    END IF;

    PERFORM mat_mul('fib_mat_final', 'fib_vec', 'fib_vec_final');

    EXECUTE format(
      'SELECT A.value
       FROM fib_vec_final as A
       WHERE A.i=1 and A.j=1;')
    INTO res;

    RETURN res;
END;
$$;

SELECT fib(1);
SELECT fib(2);
SELECT fib(3);
SELECT fib(4);
SELECT fib(5);
SELECT fib(6);