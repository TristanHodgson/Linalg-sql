CREATE OR REPLACE FUNCTION mat_pow(A text, B text, n int)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    i int;
BEGIN
    IF n < 1 THEN
        RAISE EXCEPTION 'n must be >= 1';
    END IF;

    EXECUTE format('DROP TABLE IF EXISTS %s;', B);
    EXECUTE format('CREATE TABLE %s AS TABLE %s;', B, A);

    FOR i in 2..n LOOP
        EXECUTE format('SELECT mat_mul(''%1$s'',''%2$s'',''rubbish'');', A, B);
        EXECUTE format('DROP TABLE IF EXISTS %s;', B);
        EXECUTE format('ALTER TABLE rubbish RENAME TO %s;', B);
    END LOOP;

    EXECUTE format('DROP TABLE IF EXISTS rubbish;');

END;
$$;


-- Note this power function is inefficient, only handles n>=1 case and is generally terrible