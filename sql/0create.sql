SET work_mem = '2GB';
SET maintenance_work_mem = '2GB';


DROP TABLE IF EXISTS A;

CREATE TABLE A (
    i INT NOT NULL,
    j INT NOT NULL,
    value DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (i, j)
);

INSERT INTO A (i, j, value) VALUES
    (1, 1, 1.0),
    (1, 2, 2),
    (1, 3, 0.0),
    (2, 1, 1),
    (2, 2, 1.0),
    (2, 3, 4),
    (3, 1, 0.0),
    (3, 2, 7),
    (3, 3, 1.0);

SELECT *
FROM A;