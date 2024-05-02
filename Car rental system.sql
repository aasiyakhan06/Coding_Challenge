use Coding_Challenge;
 

create table Vehicle (VehicleID int PRIMARY KEY, make varchar(20), model varchar (20), year year, dailyRate float(10), status int(20), 
passengerCapacity int (25), engineCapacity int(20));

insert into Vehicle values(1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450); 
insert into Vehicle values(2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500); 
insert into Vehicle values(3, 'Ford', 'Focus', 2022, 48.00, 0, 4, 1400); 
insert into Vehicle values(4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200); 
insert into Vehicle values(5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800);
insert into Vehicle values(6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400);  
insert into Vehicle values(7, 'BMW', '3 Series', 2023, 60.00, 1, 7, 2499);
insert into Vehicle values(8, 'Mercedes', 'C- Class', 2022, 58.00, 1, 8, 2599);  
insert into Vehicle values(9, 'Audi', 'A4', 2022, 55.00, 0, 4, 2500); 
insert into Vehicle values(10, 'Lexus', 'ES', 2023, 54.00, 1, 4, 2500); 


create table Customer( CustomerID int PRIMARY KEY, firstName varchar(15), lastName varchar(15), email varchar(20), phoneNumber int (15));

insert into Customer values(1, 'John', 'Doe', 'john@example.com', 555-555-5555);
insert into Customer values(2, 'Jane', 'Smith', 'jane@example.com', 555-123-4567);
insert into Customer values(3, 'Robert', 'Johnson', 'robert@example.com', 555-789-1234);
insert into Customer values(4, 'Sarah', 'Brown', 'sarah@example.com', 555-456-7890);
insert into Customer values(5, 'David', 'Lee', 'david@example.com', 555-987-6543);
insert into Customer values(6, 'Laura', 'Hall', 'laura@example.com', 555-234-5678);
insert into Customer values(7, 'Michael', 'Davis', 'michael@example.com', 555-876-5432);
insert into Customer values(8, 'Emma', 'Wilson', 'emma@example.com', 555-432-1098);
insert into Customer values(9, 'William', 'Taylor', 'william@example.com', 555-321-6547);
insert into Customer values(10, 'Olivia', 'Adams', 'olivia@example.com', 555-765-4321);


create table Lease( leaseID int PRIMARY KEY, VehicleID int, Foreign key(VehicleID) references Vehicle(VehicleID) , CustomerID int,
 foreign key(CustomerID) references Customer(CustomerID), statrtDate date, endDate date, leaseType varchar(10));
 
 insert into Lease values(1, 1, 1, '2023-01-01', '2023-01-05', 'Daily');
  insert into Lease values(2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly');
   insert into Lease values(3, 3, 3, '2023-03-10', '2023-03-15', 'Daily');
   insert into Lease values(4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly');
   insert into Lease values(5, 5, 5, '2023-05-05', '2023-05-10', 'Daily');
   insert into Lease values(6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly');
   insert into Lease values(7, 7, 7, '2023-07-01', '2023-07-10', 'Daily');
   insert into Lease values(8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly');
   insert into Lease values(9, 3, 3, '2023-09-07', '2023-09-10', 'Daily');
    insert into Lease values(10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');
    

create table Payment(paymentID int PRIMARY KEY, leaseID int,  paymentDate date, amount float(10));

insert into Payment values( 1, 1, '2023-01-03' ,  200.00);
insert into Payment values( 2, 2, '2023-02-20' ,  1000.00);
insert into Payment values( 3, 3, '2023-03-12' ,  75.00);
insert into Payment values( 4, 4, '2023-04-25' ,  900.00);
insert into Payment values( 5, 5, '2023-05-07' ,  60.00);
insert into Payment values( 6, 6, '2023-06-18' ,  1200.00);
insert into Payment values( 7, 7, '2023-07-03' ,  40.00);
insert into Payment values( 8, 8, '2023-08-14' ,  1100.00);
insert into Payment values( 9, 9, '2023-09-09' ,  80.00);
insert into Payment values( 10, 10, '2023-10-25' ,  1500.00);
    
     
     
   -- 1. UPDATE A DAILY RATE FOR MERCEDES CAR TO 68.
UPDATE Vehicle SET dailyRate = 68 where make = 'Mercedes';

-- 2. DELETE A SPECIFIC CUSTOMER AND ALL ASSOCIATED LEASES AND PAYMENTS
delete from Payment where leaseID in(select leaseID from Lease where customerID = 9);
delete from Lease where customerID = 9;
delete from Customer where customerID = 9;


-- 3. RENAME THE "PAYMENTDATE" COLUMN IN THE PAYMENT TABLE TO "TRANSACTION DATE.
alter table Payment
change column paymentDate
 transactionDate DATE; 
 
 -- 4. FIND A SPECIFIC CUSTOMER BY EMAIL.
 select firstName, lastName from Customer where email = 'john@example.com';
 
 
 -- 5. GET ACTIVE LEASES FOR A SPECIFIC CUSTOMER.
 select * from Lease where customerID <9 and enddate >= current_date;
 
 -- 6. FIND ALL THE PAYMENTS MADE BY A CUSTOMER WITH A SPECIFIC PHONE NUMBER.
 select Payment.* from Payment
join Lease on Payment.leaseID = Lease.leaseID
join Customer on Lease.customerID = Customer.customerID
where Customer.phoneNumber = '555-555-5555';
 
 -- 7. CALCULATE THE AVERAGE DAILY RATE OF ALL AVAILABLE CARS.
 select avg(dailyRate) AS 'Average dailyRate' from Vehicle;
 
 -- 8. FIND THE CAR WITH THE HIGHEST DAILY RATE.
 select max(dailyRate) from Vehicle;
 
 -- 9. RETRIEVE ALL CARS LEASED BY A SPECIFIC CUSTOMER
 select * from vehicle where vehicleID in ( select vehicleID from Lease where customerID = 1);
 
 -- 10. FIND THE DETAILS OF THE MOST RECENT LEASE.
 select * from  Lease where endDate = (select max(enddate) from Lease);
 
 -- 11. LIST ALL THE PAYMENTS MADE IN YEAR 2023. 
 Select * from Payment where YEAR(transactionDate) = 2023;
 
 -- 12. RETRIEVE CUSTOMERS WHO HAVE NOT MADE ANY PAYMENT.
  select * from Customer where CustomerID not in(Select distinct CustomerID from Payment);
  
  -- 13. RETRIEVE CAR DETAILS AND THEIR TOTAL PAYMENTS.
  
  
  -- 14. CALCULATE TOTAL PAYMENT FOR EACH CUSTOMER
  
  
  -- 15. LIST CAR DETAILS FOR EACH LEASE
  
  
  -- 16. RETRIEVE DETAILS OF ACTIVE LEASES WITH CUSTOMER AND CAR INFORMATION.
  
  
  -- 17. FIND THE CUSTOMER WHO HAS SPENT THE MOST ON LEASES.
  
  
  -- 18. LIST ALL THE CARS WITH THEIR CURRENT LEASE INFORMATION.
  
 