1. 
CREATE TABLE lab9-10.supplier (
  Supp_id INT NOT NULL,
  supp_name VARCHAR(45) NULL,
  supp_city VARCHAR(45) NULL,
  supp_phone VARCHAR(45) NULL,
  PRIMARY KEY (Supp_id));

CREATE TABLE lab9-10.customer (
  cus_id INT NOT NULL,
  cus_name VARCHAR(45) NULL,
  cus_phone VARCHAR(45) NULL,
  cus_city VARCHAR(45) NULL,
  cus_gender VARCHAR(45) NULL,
  PRIMARY KEY (cus_id));

CREATE TABLE lab9-10.category (
  cat_id INT NOT NULL,
  cat_name VARCHAR(45) NULL,
  PRIMARY KEY (cat_id));

CREATE TABLE lab9-10.product (
  pro_id INT NOT NULL,
  pro_name VARCHAR(45) NULL,
  pro_desc VARCHAR(45) NULL,
  cat_id INT NULL,
  PRIMARY KEY (pro_id));

CREATE TABLE lab9-10.productdetails (
  PROD_ID INT NOT NULL,
  PRO_ID INT NULL,
  supp_id INT NULL,
  price INT NULL,
  PRIMARY KEY (PROD_ID));
CREATE TABLE lab9-10.order (
  ord_id INT NOT NULL,
  ord_amount INT NULL,
  ord_date DATE NULL,
  cus_id INT NULL,
  prod_id INT NULL,
  PRIMARY KEY (ord_id));
CREATE TABLE lab9-10.rating (
  rat_id INT NOT NULL,
  cus_id INT NULL,
  supp_id INT NULL,
  rat_ratstars INT NULL,
  PRIMARY KEY (rat_id));

2.
insert into lab9-10.supplier values(1,'Rajesh Retails','Delhi','1234567890');
insert into lab9-10.supplier values(2,'Appario Ltd.','Mumbai','2589631470');
insert into lab9-10.supplier values(3,'Knome products','Bangalore','9785462315');
insert into lab9-10.supplier values(4,'Bansal Retails','Kochi','8975463285');
insert into lab9-10.supplier values(5,'Mittal Ltd.','Lucknow','7898456532');

insert into lab9-10.customer values (1,'AAKASH',9999999999,'DELHI','M');
insert into lab9-10.customer values (2,'AMAN',9785463215,'NOIDA','M');
insert into lab9-10.customer values (3,'NEHA',9999999999,'MUMBAI','F');
insert into lab9-10.customer values (4,'MEGHA',9994562399,'KOLKATA','F');
insert into lab9-10.customer values (5,'PULKIT',7895999999,'LUCKNOW','M');

insert into lab9-10.category values (1,'BOOKS');
insert into lab9-10.category values (2,'GAMES');
insert into lab9-10.category values (3,'GROCERIES');
insert into lab9-10.category values (4,'ELECTRONICS');
insert into lab9-10.category values (5,'CLOTHES');

insert into lab9-10.product values (1,'GTA V', 'DFJDJFDJFDJFDJFJF',2);
insert into lab9-10.product values (2,'TSHIRT', 'DFDFJDFJDKFD',5);
insert into lab9-10.product values (3,'ROG LAPTOP', 'DFNTTNTNTERND',4);
insert into lab9-10.product values (4,'OATS', 'REURENTBTOTH',3);
insert into lab9-10.product values (5,'HARRY POTTER', 'NBEMCTHTJTH',1);

insert into lab9-10.productdetails values (1,1,2,1500);
insert into lab9-10.productdetails values (2,3,5,30000);
insert into lab9-10.productdetails values (3,5,1,3000);
insert into lab9-10.productdetails values (4,2,3,2500);
insert into lab9-10.productdetails values (5,4,1,1000);

insert into lab9-10.order values (20,1500,date'2021-10-12',3,5);
insert into lab9-10.order values (25,30500,date'2021-09-16',5,2);
insert into lab9-10.order values (26,2000,date'2021-10-05',1,1);
insert into lab9-10.order values (30,3500,date'2021-08-16',4,3);
insert into lab9-10.order values (50,2000,date'2021-10-06',2,1);

insert into lab9-10.rating values (1,2,2,4);
insert into lab9-10.rating values (2,3,4,3);
insert into lab9-10.rating values (3,5,1,5);
insert into lab9-10.rating values (4,1,3,2);
insert into lab9-10.rating values (5,4,5,4);

3. 
select cus.cus_gender, count(*) from `lab9-10`.customer cus
inner join `lab9-10`.order ord 
on cus.cus_id = ord.cus_id
where ord_amount >=3000
group by cus.cus_gender;

4. 
select ord.*, product.pro_name from `lab9-10`.customer cus
inner join `lab9-10`.order ord 
on cus.cus_id = ord.cus_id
inner join 
( select pro.pro_name, prod.prod_id from `lab9-10`.product pro
 inner join `lab9-10`.productdetails prod
on prod.pro_id = pro.pro_id) product
on product.prod_id = ord.prod_id
where cus.cus_id = 2
;
5.
select * from `lab9-10`.supplier where supplier.supp_id in 
(select supp.supp_id from `lab9-10`.supplier supp
inner join `lab9-10`.productdetails prod
on prod.supp_id = supp.supp_id
inner join `lab9-10`.product pro
on pro.pro_id = prod.pro_id
group by supp.supp_id having count(*) > 1);

6.
select cat.cat_name from `lab9-10`.order ord 
inner join `lab9-10`.productdetails prod
on ord.prod_id = prod.prod_id
inner join `lab9-10`.product pro
on pro.pro_id = prod.pro_id
inner join `lab9-10`.category cat
on cat.cat_id = pro.cat_id
inner join (select ord_id,min(ord_amount) from `lab9-10`.order ) inner_order
on inner_order.ord_id = ord.ord_id
;

7.
select pro.pro_id, pro.pro_name from `lab9-10`.product pro
inner join `lab9-10`.productdetails prod
on pro.pro_id = prod.pro_id
inner join `lab9-10`.order ord
on ord.prod_id = prod.prod_id
where ord.ord_date >= '2021-10-05';

8.
select cus.cus_name, cus.cus_gender from `lab9-10`.customer cus
where cus_name like 'A%';

9.
DELIMITER //
create procedure getSupplierRating()
BEGIN
	select supp.supp_name,
		case when rat.rat_ratstars > 4
			then 'Genuine Supplier'
		when rat.rat_ratstars > 2
			then 'Average Supplier'
			else 'Supplier should not be considered' 
		end as supplier_rating
 from `lab9-10`.rating rat
inner join `lab9-10`.supplier supp
on rat.supp_id = supp.supp_id;
END //
 


