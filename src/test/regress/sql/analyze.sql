/*
Testing NULL counts 
*/

-- 1. empty table should have NO stats
create table t (c int) distributed by (c);
analyze t;
select stanullfrac from pg_statistic where starelid = 't'::regclass::oid;

-- 2. table with ALL null values, expect to see 100% null values
insert into t values (null);
analyze t;
select stanullfrac from pg_statistic where starelid = 't'::regclass::oid;

-- 3. table with 1 null and 1 not-null values, expect to see 50% null values
insert into t values (1);
analyze t;
select stanullfrac from pg_statistic where starelid = 't'::regclass::oid;

-- 4. table with ALL not-null values, expect to see 0% null values
delete from t where c is null;
analyze t;
select stanullfrac from pg_statistic where starelid = 't'::regclass::oid;
