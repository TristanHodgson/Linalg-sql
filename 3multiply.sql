DROP FUNCTION IF EXISTS elm_mul(text, text, int, int);
DROP FUNCTION IF EXISTS mat_mul(text, text, text);


CREATE OR REPLACE FUNCTION elm_mul(A text, B text, i int, j int)
RETURNS double precision
LANGUAGE plpgsql
AS $$
DECLARE
  res double precision;
BEGIN
  EXECUTE format(
    'SELECT COALESCE(SUM(A.value * B.value), 0)
     FROM %s AS A
     JOIN %s AS B ON A.j = B.i
     WHERE A.i = $1 AND B.j = $2',
    A, B)
    INTO res
    USING i, j;

  RETURN res;
END;
$$;



CREATE OR REPLACE FUNCTION mat_mul(A text, B text, C text)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    n int;
    Am int;
    Bm int;
    p int;
    i int;
    j int;
    val double precision;
BEGIN

    EXECUTE format('SELECT MAX(i), MAX(j) FROM %s', A)
    INTO n, Am;
    EXECUTE format('SELECT MAX(i), MAX(j) FROM %s', B)
    INTO Bm, p;
    IF Am != Bm THEN
        RAISE EXCEPTION 'Incompatible dimensions';
    END IF;


    EXECUTE format('DROP TABLE IF EXISTS %s', C);
    EXECUTE format('
        CREATE TABLE %s (
            i INT NOT NULL,
            j INT NOT NULL,
            value DOUBLE PRECISION NOT NULL,
            PRIMARY KEY (i, j)
        )', C);


    FOR i IN 1..n LOOP
        FOR j IN 1..p LOOP
            val := elm_mul(A, B, i, j);
            EXECUTE format('INSERT INTO %s (i, j, value) VALUES ($1, $2, $3)', C)
            USING i, j, val;
        END LOOP;
    END LOOP;
END;
$$;


SELECT mat_mul('a','a','b');
SELECT matrix FROM mat_vis('a');
SELECT matrix FROM mat_vis('b');