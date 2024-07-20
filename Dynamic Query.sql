/**Dynamic SQL allows you to construct and execute SQL statements dynamically at runtime. This can be particularly useful when you need to build SQL queries based on variable inputs or conditions. However, it's important to be aware of the security risks, such as SQL injection, and take appropriate precautions.

Use Case : Suppose we have a table Employees, and we want to build a query that can filter results based on optional parameters for Department and Salary.

Security Considerations
Parameterization: Always use parameterized queries (sp_executesql) to prevent SQL injection.
Validation: Validate and sanitize input parameters before using them in the query.

**/
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary) VALUES
(1, 'John', 'Doe', 'Sales', 50000.00),
(2, 'Jane', 'Smith', 'HR', 60000.00),
(3, 'Mike', 'Brown', 'IT', 70000.00),
(4, 'Anna', 'Taylor', 'Sales', 55000.00);

CREATE PROCEDURE GetEmployees
    @Department NVARCHAR(50) = NULL,
    @MinSalary DECIMAL(10, 2) = NULL
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX);
    
    -- Base query
    SET @SQL = 'SELECT EmployeeID, FirstName, LastName, Department, Salary FROM Employees WHERE 1=1';
    
    -- Append conditions based on parameters
    IF @Department IS NOT NULL
    BEGIN
        SET @SQL = @SQL + ' AND Department = @Dept';
    END
    
    IF @MinSalary IS NOT NULL
    BEGIN
        SET @SQL = @SQL + ' AND Salary >= @MinSal';
    END
    
    -- Print the SQL statement for debugging (optional)
    PRINT @SQL;
    
    -- Execute the dynamic SQL
    EXEC sp_executesql @SQL, N'@Dept NVARCHAR(50), @MinSal DECIMAL(10, 2)', @Dept = @Department, @MinSal = @MinSalary;
END;