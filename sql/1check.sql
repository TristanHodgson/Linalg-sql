-- Note this function assumes dense matrices or at least matrices without assumed 0s

DROP FUNCTION IF EXISTS mat_check(text);

CREATE OR REPLACE FUNCTION mat_check(tab text)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    n int;
    m int;
    error boolean;
BEGIN
    -- We are trying to show that A is an nxm matrix
    EXECUTE format('SELECT MAX(i), MAX(j) FROM %s', tab)
      INTO n, m;

    -- If n,m are null then give up
    IF n IS NULL OR m IS NULL THEN
        RAISE EXCEPTION 'Matrix % is empty', tab;
    END IF;

    EXECUTE format('
        SELECT EXISTS(
            -- Check we are indexing from 1 and indexes are integers
                SELECT 1
                FROM %1$s AS A
                WHERE A.i < 1 OR A.j < 1 OR A.i - floor(A.i) > 0 OR A.j - floor(A.j) > 0

            UNION

            -- Show that every value exists
                SELECT 1
                FROM generate_series(1, %2$s) AS k
                CROSS JOIN generate_series(1, %3$s) AS l
                LEFT JOIN %1$s AS A ON A.i = k AND A.j = l
                WHERE A.i IS NULL OR A.value IS NULL
        )', tab, n, m)
      INTO error;

    IF error THEN
        RAISE EXCEPTION 'Invalid matrix %: non-integer/invalid indices or missing/NULL entries', tab;
    END IF;

    RAISE NOTICE 'Matrix % is % x %', tab::text, n, m;
END;
$$;


SELECT mat_check('a');