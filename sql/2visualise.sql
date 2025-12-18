DROP FUNCTION IF EXISTS mat_vis(text);

CREATE OR REPLACE FUNCTION mat_vis(tab text)
RETURNS TABLE(i int, matrix text)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY EXECUTE format(
    'SELECT A.i, string_agg(A.value::text, '' '' ORDER BY A.j)
     FROM %s AS A
     GROUP BY A.i
     ORDER BY A.i',
    tab);
END;
$$;

SELECT matrix FROM mat_vis('a');