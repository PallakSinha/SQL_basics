USE customerdb131;
CREATE TABLE Orders_UNF (
    OrderID INT,
    CustomerName VARCHAR(50),
    CustomerPhone VARCHAR(15),
    Products VARCHAR(200),
    ProductPrices VARCHAR(200),
    OrderDate DATE
);

INSERT INTO Orders_UNF VALUES
(1, 'Amit', '9876543210', 'Laptop,Mouse', '60000,500', '2024-01-10'),
(2, 'Amit', '9876543210', 'Keyboard', '1200', '2024-01-15'),
(3, 'Neha', '9123456780', 'Laptop,Printer', '60000,8000', '2024-02-01');

CREATE TABLE Orders_1NF (
    OrderID INT,
    CustomerName VARCHAR(50),
    CustomerPhone VARCHAR(15),
    ProductName VARCHAR(50),
    ProductPrice INT,
    OrderDate DATE
);

INSERT INTO Orders_1NF VALUES
(1, 'Amit', '9876543210', 'Laptop', 60000, '2024-01-10'),
(1, 'Amit', '9876543210', 'Mouse', 500, '2024-01-10'),
(2, 'Amit', '9876543210', 'Keyboard', 1200, '2024-01-15'),
(3, 'Neha', '9123456780', 'Laptop', 60000, '2024-02-01'),
(3, 'Neha', '9123456780', 'Printer', 8000, '2024-02-01');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    CustomerPhone VARCHAR(15),
    OrderDate DATE
);

CREATE TABLE Order_Items (
    OrderID INT,
    ProductName VARCHAR(50),
    ProductPrice INT,
    PRIMARY KEY (OrderID, ProductName)
);

INSERT INTO Orders VALUES
(1, 'Amit', '9876543210', '2024-01-10'),
(2, 'Amit', '9876543210', '2024-01-15'),
(3, 'Neha', '9123456780', '2024-02-01');

select * FROM Orders;

INSERT INTO Order_Items VALUES
(1, 'Laptop', 60000),
(1, 'Mouse', 500),
(2, 'Keyboard', 1200),
(3, 'Laptop', 60000),
(3, 'Printer', 8000);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    CustomerPhone VARCHAR(15)
);

INSERT INTO Customers VALUES
(1, 'Amit', '9876543210'),
(2, 'Neha', '9123456780');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price INT
);

INSERT INTO Products VALUES
(101, 'Laptop', 60000),
(102, 'Mouse', 500),
(103, 'Keyboard', 1200),
(104, 'Printer', 8000);

CREATE TABLE Orders_3NF (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders_3NF(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders_3NF (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2024-01-10'),
(2, 1, '2024-01-15'),
(3, 2, '2024-02-01');

INSERT INTO OrderDetails (OrderID, ProductID) VALUES
(1, 101), -- Order 1: Laptop
(1, 102), -- Order 1: Mouse
(2, 103), -- Order 2: Keyboard
(3, 101), -- Order 3: Laptop
(3, 104); -- Order 3: Printer

SELECT 
    o.OrderID, 
    c.CustomerName, 
    p.ProductName, 
    p.Price, 
    o.OrderDate
FROM Orders_3NF o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;