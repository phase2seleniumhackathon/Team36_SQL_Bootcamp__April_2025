-- Day-2 Assignment

-- 1.Alter Table:
-- Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
-- Change the linkedin_profile column data type from VARCHAR to TEXT.
-- Add unique, not null constraint to linkedin_profile
-- Drop column linkedin_profile

Alter table employees
Add column linkedin_profile varchar(100);

Alter table employees
Alter column linkedin_profile type TEXT;

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL,
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);

Alter table employees
drop column linkedin_profile;
