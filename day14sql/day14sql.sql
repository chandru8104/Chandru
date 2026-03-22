create database day14;
use day14;
CREATE TABLE Products (product_id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(100),price DECIMAL(10, 2), stock_quantity INT,status VARCHAR(20) DEFAULT 'Available'); CREATE TABLE Inventory_Audit (audit_id INT PRIMARY KEY AUTO_INCREMENT,product_id INT,action_type VARCHAR(50), old_value VARCHAR(100),new_value VARCHAR(100),changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

-- prevent
delimiter $$
create trigger prevent_negativestock
before update on products
for each row
begin
    if new.stock_quantity < 0 then
        signal sqlstate '45000'
        set message_text = 'stock cannot be negative';
    end if;
end$$
delimiter ;

-- price changes
delimiter $$
create trigger audit_pricechange
after update on products
for each row
begin
    if old.price <> new.price then
        insert into inventory_audit(product_id, action_type, old_value, new_value)
        values (old.product_id, 'price update', old.price, new.price);
    end if;
end$$
delimiter ;

-- auto update
delimiter $$
create trigger autoupdate
before update on products
for each row
begin
    if new.stock_quantity = 0 then
        set new.status = 'out of stock';
    end if;
end$$
delimiter ;

-- uppercase products
DELIMITER $$
CREATE TRIGGER uppercase_product
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    SET NEW.name = UPPER(NEW.name);
END$$
DELIMITER ;

-- new products
delimiter $$
create trigger new_product
after insert on products
for each row
begin
    insert into inventory_audit(product_id, action_type)
    values (new.product_id, 'new product added');
end$$
delimiter ;

-- prevent deletion
delimiter $$
create trigger prevent_deletion
before delete on products
for each row
begin
    if old.stock_quantity > 0 then
        signal sqlstate '45000'
        set message_text = 'cannot delete product with stock available';
    end if;
end$$
delimiter ;

-- track deleted products
delimiter $$
create trigger track_deleted_product
after delete on products
for each row
begin
    insert into inventory_audit(product_id, action_type, old_value)
    values (old.product_id, 'product deleted', old.name);
end$$
delimiter ;
