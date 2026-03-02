create database day9;
use day9;
CREATE TABLE Products (product_id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(100),price DECIMAL(10, 2),stock_quantity INT,status VARCHAR(20) DEFAULT 'Available');
CREATE TABLE Inventory_Audit (audit_id INT PRIMARY KEY AUTO_INCREMENT,product_id INT,action_type VARCHAR(50),old_value VARCHAR(100),new_value VARCHAR(100),changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
INSERT INTO Products (name, price, stock_quantity)VALUES ('Laptop', 55000.00, 10),('Mouse', 500.00, 25);
INSERT INTO Inventory_Audit (product_id, action_type, old_value, new_value)VALUES(1, 'INSERT', NULL, 'Stock: 10'),(2, 'INSERT', NULL, 'Stock: 25');

SELECT * FROM Products;
SELECT * FROM Inventory_Audit;

-- 1. Prevent Negative Stock : Create a trigger to prevent the stock_quantity from being updated to a value less than 0.

DELIMITER //
CREATE TRIGGER prevent_negative_stock
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.stock_quantity < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock quantity cannot be negative';
    END IF;
END //
DELIMITER ;

UPDATE Products
SET stock_quantity = -10
WHERE product_id = 1;

--  Audit Price Changes: Log whenever a product price is updated into the Inventory_Audit table.

DELIMITER //
CREATE TRIGGER audit_price_change
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO Inventory_Audit (product_id, action_type, old_value, new_value)
        VALUES (
            OLD.product_id,
            'PRICE UPDATE',
            CONCAT('Old Price: ', OLD.price),
            CONCAT('New Price: ', NEW.price)
        );
    END IF;
END //
DELIMITER ;

UPDATE Products
SET price = 60000
WHERE product_id = 1;

SELECT * FROM Inventory_Audit;

--  Auto-Update Status to 'Out of Stock': If stock reaches 0, automatically change the status to 'Out of Stock'.


DELIMITER //
CREATE TRIGGER auto_update_status
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.stock_quantity = 0 THEN
        SET NEW.status = 'Out of Stock';
    ELSE
        SET NEW.status = 'Available';
    END IF;
END //
DELIMITER ;

UPDATE Products
SET stock_quantity = 0
WHERE product_id = 2;

--  Enforce Uppercase Product Names: Ensure all product names are stored in uppercase upon insertion.
DELIMITER //
CREATE TRIGGER uppercase_product_name
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    SET NEW.name = UPPER(NEW.name);
END //
DELIMITER ;

INSERT INTO Products (name, price, stock_quantity)
VALUES ('keyboard', 1500, 15);

SELECT * FROM Products;

-- Log New Product Additions: Record a log entry whenever a new product is added to the system.

DELIMITER //
CREATE TRIGGER log_new_product
AFTER INSERT ON Products
FOR EACH ROW
BEGIN
    INSERT INTO Inventory_Audit (product_id, action_type, old_value, new_value)
    VALUES (
        NEW.product_id,
        'NEW PRODUCT',
        NULL,
        CONCAT('Added Product: ', NEW.name, ', Price: ', NEW.price)
    );
END //
DELIMITER ;


INSERT INTO Products (name, price, stock_quantity)
VALUES ('Monitor', 12000, 8);

--  Prevent Deletion of Active Products: Stop users from deleting a product if the stock_quantity is greater than 0.
DELIMITER //
CREATE TRIGGER prevent_delete_active_product
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
    IF OLD.stock_quantity > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete product with available stock';
    END IF;
END //
DELIMITER ;

DELETE FROM Products
WHERE product_id = 1;
