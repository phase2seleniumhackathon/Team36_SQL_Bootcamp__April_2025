-- 1.Create AFTER UPDATE trigger to track product price changes
 
-- ·Create product_price_audit table with below columns:
-- 	audit_id SERIAL PRIMARY KEY,
--     product_id INT,
--     product_name VARCHAR(40),
--     old_price DECIMAL(10,2),
--     new_price DECIMAL(10,2),
--     change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     user_name VARCHAR(50) DEFAULT CURRENT_USER
 
-- · Create a trigger function with the below logic:
 
--   INSERT INTO product_price_audit (
--         product_id,
--         product_name,
--         old_price,
--         new_price
--     )
--     VALUES (
--         OLD.product_id,
--         OLD.product_name,
--         OLD.unit_price,
--         NEW.unit_price
--     );
-- ·       Create a row level trigger for below event:
--           	AFTER UPDATE OF unit_price ON products
 
-- ·        Test the trigger by updating the product price by 10% to any one product_id.


Create table product_price_audit (
	audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER);
 
 select * from product_price_audit

create or replace function price_changes()
returns trigger as $$
begin
    insert into  product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create trigger  after_product_price_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
EXECUTE FUNCTION price_changes();

-- test trigger works

UPDATE products 
SET unit_price = unit_price * 1.1 
WHERE product_id = 101;

select * from products

 
-- 2.Create stored procedure  using IN and INOUT parameters to assign tasks to employees 
-- · Parameters:
-- IN p_employee_id INT,
-- IN p_task_name VARCHAR(50),
--  INOUT p_task_count INT DEFAULT 
-- ·Inside Logic: Create table employee_tasks:
--  CREATE TABLE IF NOT EXISTS employee_tasks (
--         task_id SERIAL PRIMARY KEY,
--         employee_id INT,
--         task_name VARCHAR(50),
--         assigned_date DATE DEFAULT CURRENT_DATE
--     );
 
-- ·       Insert employee_id, task_name  into employee_tasks
-- ·       Count total tasks for employee and put the total count into p_task_count .
-- ·       Raise NOTICE message:
--  RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
--         p_task_name, p_employee_id, p_task_count;
 
 
-- After creating stored procedure test by calling  it:
--  CALL assign_task(1, 'Review Reports');
 
-- You should see the entry in employee_tasks table.

  CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );

create or replace procedure assign_task(
	IN p_employee_id INT,
	IN p_task_name VARCHAR(50),
 	INOUT p_task_count INT DEFAULT 0)
 	Language  plpgsql
	 as $$
	 begin
	  INSERT INTO employee_tasks (employee_id, task_name)
     VALUES (p_employee_id, p_task_name);
	 
   SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;
	
RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %', 
        p_task_name, p_employee_id, p_task_count;
END;
$$;

--test the procedure
DO $$ 
DECLARE 
    task_count INT DEFAULT 0; 
BEGIN
    CALL assign_task(1, 'Review Reports', task_count);
    RAISE NOTICE 'Updated task count: %', task_count;
END $$;
 
	  
 
