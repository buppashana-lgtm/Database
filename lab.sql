create database BankDB;
Use BankDB;
Create table accounts(
accounts_id int primary key,
account_holder varchar(100),
balance decimal(10,2)
);
insert into accounts values
(1,'Ram',50000),
(2,'Shyam',30000),
(3,'Sita',20000);
select * from accounts;
start transaction;
update accounts set balance = balance - 5000
where accounts_id=1;
update accounts set balance = balance + 5000
where accounts_id=2;
commit;

start transaction;
update accounts set balance = balance - 10000
where accounts_id=2;
update accounts set balance = balance + 1000
where accounts_id=3;
rollback;

start transaction;
update accounts set balance=balance-2000
where accounts_id = 1;
savepoint sp1;
update accounts set balance = balance + 2000
where accounts_id = 2;
rollback to sp1;
commit;

create table employees(
emp_id int primary key,
name varchar(100),
salary decimal(10,2)
);

create table salary_log(
log_id int auto_increment primary key,
emp_id int,
old_salary decimal(10,2),
new_salary decimal(10,2),
updated_at timestamp default current_timestamp
);

Delimiter $$
create trigger check_salary
before insert on employees
for each row 
begin
if new.salary < 10000 then
signal sqlstate '45000'
set message_text='salary must be atleast 10000';
end if;
end $$
Delimiter ;

Delimiter $$
create trigger log_salary_update
after update on employees
for each row 
begin
insert into salary_log(emp_id,old_salary, new_salary)
values(old.emp_id,old.salary,new.salary);
end
$$
Delimiter ;

Delimiter $$
create procedure getEmployees()
Begin
select* from employees;
end
$$
Delimiter ;
call getEmployees();

Delimiter $$
create procedure addEmployee(
in p_id int, in p_name varchar(100),
in p_salary decimal(10,2))
begin
insert into employees values(
p_id,p_name,p_salary);
end $$
Delimiter ;
drop procedure addEmployee;
call addEmployee(5,'Hari',20000);
select * from employees;

Delimiter $$
create procedure updateSalary(
in p_id int, in new_salary decimal(10,2))
begin
update employees
set salary = new_salary
where emp_id = p_id;
end $$
Delimiter ;
call updateSalary(1,30000);

DELIMITER $$
CREATE PROCEDURE transferMoney(
    IN from_acc INT,
    IN to_acc INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE current_balance DECIMAL(10,2);

    START TRANSACTION;

    -- Get balance of sender
    SELECT balance INTO current_balance
    FROM accounts
    WHERE accounts_id = from_acc;

    -- Check sufficient balance
    IF current_balance < amount THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient balance';
    ELSE
        -- Deduct from sender
        UPDATE accounts
        SET balance = balance - amount
        WHERE accounts_id = from_acc;

        -- Add to receiver
        UPDATE accounts
        SET balance = balance + amount
        WHERE accounts_id = to_acc;
        COMMIT;
    END IF;
END $$
DELIMITER ;
CALL transferMoney(1, 2, 5000);
select * from employees;







