-- Question 1  Achieving 1NF
-- Transform the original ProductDetail table into First Normal Form (1NF)
-- Each row will now represent a single product for an order

-- Step 1: Create the normalized table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Step 2: Insert normalized rows (manually split from the original multi-valued column)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Now the table follows 1NF: atomic values in all columns.


-- Question 2  Achieving 2NF
-- Eliminate partial dependency of CustomerName on OrderID (composite key issue)

-- Step 1: Create a separate Customers table
CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create a new OrderItems table that only includes OrderID, Product, Quantity
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID)
);

-- Step 3: Insert unique OrderIDs and CustomerNames
INSERT INTO Customers (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 4: Insert order item details
INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Now the data is in 2NF: CustomerName is moved to a separate table
-- and each non-key column in OrderItems fully depends on the entire primary key (OrderID + Product).
