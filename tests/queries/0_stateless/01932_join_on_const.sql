DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1 (id Int) ENGINE = Memory;
CREATE TABLE t2 (id Int) ENGINE = Memory;

INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (2), (3);

SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 JOIN t2 ON 1 = 1;
SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 JOIN t2 ON 1;
SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 JOIN t2 ON 2 = 2 AND 3 = 3;
SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 INNER ANY JOIN t2 ON toNullable(1);
SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 INNER ANY JOIN t2 ON toLowCardinality(1);
SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 INNER ANY JOIN t2 ON toLowCardinality(toNullable(1));
SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 JOIN t2 ON 1 = 1 SETTINGS join_algorithm = 'partial_merge';

SELECT * FROM t1 INNER ANY JOIN t2 ON toNullable(toLowCardinality(1)); -- { serverError 403 }
SELECT * FROM t1 INNER ANY JOIN t2 ON toUInt16(1); -- { serverError 403 }
SELECT * FROM t1 INNER ANY JOIN t2 ON toInt8(1); -- { serverError 403 }
SELECT * FROM t1 INNER ANY JOIN t2 ON 256; -- { serverError 403 }
SELECT * FROM t1 INNER ANY JOIN t2 ON -1; -- { serverError 403 }
SELECT * FROM t1 INNER ANY JOIN t2 ON toString(1); -- { serverError 403 }

-- not implemented
SELECT * FROM t1 INNER ANY JOIN t2 ON NULL; -- { serverError 48 }
SELECT * FROM t1 INNER ANY JOIN t2 ON 0; -- { serverError 48 }
SELECT * FROM t1 INNER ANY JOIN t2 ON 1 = 2; -- { serverError 48 }

