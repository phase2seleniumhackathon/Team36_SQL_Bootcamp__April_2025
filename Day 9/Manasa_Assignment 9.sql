--1. Create AFTER UPDATE trigger to track product price changes
-- first create a table
 CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);
--define trigger function
CREATE OR REPLACE FUNCTION log_new_product()
RETURNS TRIGGER 
LANGUAGE plpgsql 
AS $$
BEGIN
 -- Insert into audit table 
    INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    ) VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );

-- Return the new row
    RETURN NEW;
END;
$$;

-- create the trigger function
CREATE trigger after_product_insert
AFTER INSERT ON products
FOR EACH ROW
execute  function log_new_product();

-- Test the trigger
INSERT INTO products (product_id, product_name, supplier_id, category_id, unit_price, discontinued)
VALUES (97, 'Manasa', 2, 1, 23.00, 0);

SELECT * FROM product_price_audit;

--2. Create stored procedure  using IN and INOUT parameters to assign tasks to employees

CREATE OR REPLACE FUNCTION assign_task(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
) 
RETURNS VOID 
LANGUAGE plpgsql 
AS $$
BEGIN
    -- Employee_tasks table exists
    CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );

    -- Insert the new task and employee_id
    INSERT INTO employee_tasks(employee_id, task_name)
    VALUES (p_employee_id, p_task_name);

    -- Count total tasks for  employee
    SELECT COUNT(*) INTO p_task_count FROM employee_tasks WHERE employee_id = p_employee_id;

    -- Raise a NOTICE message
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %', 
        p_task_name, p_employee_id, p_task_count;
END;
$$;

-- After creating stored procedure test by calling  it:
CALL assign_task(1, 'Review Reports', 0);

SELECT * FROM employee_tasks WHERE employee_id = 1;
