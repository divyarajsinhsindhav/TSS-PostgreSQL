

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    category_code VARCHAR(20) UNIQUE NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO category (category_name, category_code, description)
VALUES
('Electronics', 'ELEC001', 'Devices and gadgets like phones, laptops, and TVs'),
('Clothing', 'CLOT002', 'Men, women, and kids fashion items'),
('Groceries', 'GROC003', 'Everyday grocery and food items'),
('Furniture', 'FURN004', 'Home and office furniture products'),
('Books', 'BOOK005', 'Educational and fictional books'),
('Sports', 'SPRT006', 'Sports gear and fitness accessories'),
('Toys', 'TOYS007', 'Toys and games for all age groups'),
('Beauty', 'BEAU008', 'Cosmetics, skincare, and beauty products'),
('Automobile', 'AUTO009', 'Car accessories, bike parts, and tools'),
('Stationery', 'STAT010', 'Office and school stationery supplies');


select * from category;


CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price NUMERIC(10,2) CHECK (price >= 0),
    quantity INTEGER DEFAULT 5,
    manufacture_date DATE,
    expiry_date DATE,
    category_id INT REFERENCES category(category_id),
    product_code CHAR(8) UNIQUE,
    product_details JSONB,
    CHECK (expiry_date > manufacture_date)
);

INSERT INTO product 
(product_name, price, quantity, manufacture_date, expiry_date, category_id, product_code, product_details)
VALUES
('Samsung Galaxy S22', 74999.99, 10, '2024-03-10', '2027-03-10', 1, 'PROD0001', '{"brand": "Samsung", "color": "Phantom Black", "warranty": "2 years"}'),
('Nike Air Max 270', 11999.50, 25, '2024-02-01', '2026-02-01', 2, 'PROD0002', '{"brand": "Nike", "size": "9", "type": "Running Shoes"}'),
('Organic Basmati Rice 5kg', 850.00, 50, '2025-01-15', '2026-01-15', 3, 'PROD0003', '{"brand": "India Gate", "organic": true, "weight": "5kg"}'),
('Wooden Study Table', 5499.00, 15, '2024-05-10', '2030-05-10', 4, 'PROD0004', '{"material": "Sheesham Wood", "color": "Brown", "dimensions": "120x60x75 cm"}'),
('Rich Dad Poor Dad', 399.00, 100, '2023-10-01', '2033-10-01', 5, 'PROD0005', '{"author": "Robert Kiyosaki", "genre": "Finance"}'),
('Cricket Bat MRF Genius', 2499.00, 20, '2024-01-05', '2029-01-05', 6, 'PROD0006', '{"brand": "MRF", "material": "English Willow"}'),
('Lego City Building Set', 1999.00, 30, '2024-06-15', '2029-06-15', 7, 'PROD0007', '{"brand": "Lego", "age_group": "8-14", "pieces": 350}'),
('Maybelline Lipstick', 499.00, 60, '2024-04-20', '2027-04-20', 8, 'PROD0008', '{"brand": "Maybelline", "shade": "Red Crush", "type": "Matte"}'),
('Car Seat Cover Deluxe', 2999.00, 40, '2024-08-01', '2030-08-01', 9, 'PROD0009', '{"brand": "AutoCraft", "material": "Leather", "color": "Beige"}'),
('A4 Paper Ream 500 Sheets', 350.00, 80, '2024-02-10', '2029-02-10', 10, 'PROD0010', '{"brand": "JK Copier", "gsm": 75, "size": "A4"}');

select * from product;


SELECT category_id ,product_name, product_details->>'brand' AS brand
FROM product
WHERE category_id = 1;



CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    city VARCHAR(50),
    country VARCHAR(50) DEFAULT 'India',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO customer (first_name, last_name, email, phone, address, city, country)
VALUES
('Aarav', 'Sharma', 'aarav.sharma@email.com', '9876543210', '45 MG Road', 'Mumbai', 'India'),
('Priya', 'Patel', 'priya.patel@email.com', '9988776655', '22 Nehru Street', 'Ahmedabad', 'India'),
('Rohan', 'Mehta', 'rohan.mehta@email.com', '9123456789', '12 Lake View', 'Delhi', 'India'),
('Sneha', 'Reddy', 'sneha.reddy@email.com', '9090909090', '88 Jubilee Hills', 'Hyderabad', 'India'),
('Vikram', 'Singh', 'vikram.singh@email.com', '9012345678', '101 Civil Lines', 'Lucknow', 'India'),
('Ananya', 'Iyer', 'ananya.iyer@email.com', '9345678901', '54 Anna Nagar', 'Chennai', 'India'),
('Rahul', 'Jain', 'rahul.jain@email.com', '9786543210', '67 Park Street', 'Kolkata', 'India'),
('Meera', 'Joshi', 'meera.joshi@email.com', '9765432189', '23 Residency Road', 'Bangalore', 'India'),
('Aditya', 'Kumar', 'aditya.kumar@email.com', '9900123456', '8 Connaught Place', 'Delhi', 'India'),
('Isha', 'Desai', 'isha.desai@email.com', '9998765432', '77 Marine Drive', 'Mumbai', 'India');

select * from customer;

--> order table

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id) ON DELETE CASCADE,
    order_date DATE NOT NULL,
    total_amount NUMERIC(12,2) CHECK (total_amount >= 0),
    status VARCHAR(20) CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO orders (customer_id, order_date, total_amount, status)
VALUES
(1, '2026-02-01', 2999.99, 'Pending'),
(2, '2026-02-02', 1599.50, 'Shipped'),
(3, '2026-02-03', 499.00, 'Delivered'),
(4, '2026-02-04', 8999.00, 'Pending'),
(5, '2026-02-05', 2499.75, 'Cancelled'),
(6, '2026-02-06', 12999.00, 'Delivered'),
(7, '2026-02-07', 349.99, 'Shipped'),
(8, '2026-02-08', 799.00, 'Delivered'),
(9, '2026-02-09', 2199.49, 'Pending'),
(10, '2026-02-10', 999.99, 'Shipped');

select * from orders;


CREATE TABLE invoice (
    invoice_id SERIAL PRIMARY KEY,
    amount NUMERIC(10,2),
    tax NUMERIC(10,2),
    total_amount NUMERIC(10,2) GENERATED ALWAYS AS (amount + tax) STORED
);


INSERT INTO invoice (amount, tax)
VALUES
(1000.00, 50.00),
(2500.00, 125.00),
(3999.99, 200.00),
(850.00, 42.50),
(15000.00, 750.00),
(500.00, 25.00),
(7800.00, 390.00),
(1299.99, 64.99),
(999.00, 49.95),
(20000.00, 1000.00);

select * from invoice;