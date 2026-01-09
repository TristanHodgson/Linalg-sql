DROP FUNCTION IF EXISTS mat_mul(text, text, text);

CREATE OR REPLACE FUNCTION mat_mul(A text, B text, C text)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    i int;
    j int;
    val double precision;
BEGIN
    EXECUTE format('DROP TABLE IF EXISTS %s', C);
    EXECUTE format('CREATE INDEX IF NOT EXISTS %s ON %s (j);', A || '_j_idx', A);
    EXECUTE format('
        CREATE TABLE %s AS
        SELECT A.i, B.j, SUM(A.value * B.value) AS value
        FROM %s as A JOIN %s as B ON A.j = B.i
        WHERE A.value != 0 and B.value != 0
        GROUP BY A.i, B.j;',
    C, A, B);
    EXECUTE format('ALTER TABLE %s ADD PRIMARY KEY (i, j);', C);
END;
$$;
