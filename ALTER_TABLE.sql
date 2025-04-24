/* ALTER TABLE*/
/*1.Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.*/

ALTER TABLE employees
ADD linkedin_profile  varchar(100);

/*2.Change the linkedin_profile column data type from VARCHAR to TEXT.*/

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT

/*3. Add unique, not null constraint to linkedin_profile*/

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;

select * from employees

/*Did not work for me*/
ALTER TABLE employees
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);

ALTER TABLE employees
DROP COLUMN linkedin_profile;

