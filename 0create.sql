DROP TABLE IF EXISTS A;

CREATE TABLE A (
    i INT NOT NULL,
    j INT NOT NULL,
    value DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (i, j)
);

INSERT INTO A (i, j, value) VALUES
    (1, 1, 1.0),
    (1, 2, 0.0),
    (1, 3, 0.0),
    (2, 1, 0.0),
    (2, 2, 1.0),
    (2, 3, 0.0),
    (3, 1, 0.0),
    (3, 2, 0.0),
    (3, 3, 1.0);

SELECT *
FROM A;