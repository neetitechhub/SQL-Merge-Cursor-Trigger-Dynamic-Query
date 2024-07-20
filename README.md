# SQL-Merge-Cursor-Trigger-Dynamic-Query-SQLInjection

**MERGE**

The MERGE statement in SQL allows you to perform insert, update, or delete operations in a single statement.
This is particularly useful for synchronizing tables. 

TargetTable: This is the table we want to update.
SourceTable: This is the table containing the new data we want to merge into TargetTable.

So Now We have TargetTable with the current data of employees, and SourceTable with updated data of employees. 

We want to:
Update existing employee records in TargetTable if they exist in SourceTable.
Insert new employee records into TargetTable if they do not exist.
Optionally, we can delete records from TargetTable if they are no longer present in SourceTable.


**CURSOR**

1. A cursor in SQL is a database object that allows you to retrieve and manipulate data row-by-row from a result set.
2. Cursors are useful when you need to perform operations on each row individually, rather than operating on the entire result set at once.

**CONS :**

1. Performance Overhead: Row-by-Row Processing: Cursors process each row individually, which can be significantly slower than set-based operations, especially with large result sets.
2. Resource Intensive: Cursors can consume more memory and resources on the database server, particularly if they remain open for long periods.
3. Complexity: Complex Code-> Cursors often require more complex and lengthy code compared to set-based operations, making the SQL scripts harder to read and maintain.
4. Error Handling: Handling errors and exceptions within cursors can be more complicated compared to set-based operations.
5. Concurrency Issues: Locking-> Cursors can hold locks on rows for extended periods, which may lead to blocking and deadlocking issues, affecting the performance and concurrency of the database.
6. Scalability: Not Scalable -> As the size of the data increases, cursor-based operations become less efficient and scalable. Set-based operations are generally more scalable for large datasets.
7. Maintenance: Difficult to Debug-> Debugging cursor-based operations can be more challenging compared to set-based operations due to the complexity of the code and the need to track the cursor state.

**DYNAMIC QUERY**

Dynamic SQL allows you to construct and execute SQL statements dynamically at runtime. This can be particularly useful when you need to build SQL queries based on variable inputs or conditions. However, it's important to be aware of the security risks, such as SQL injection, and take appropriate precautions.

Use Case : Suppose we have a table Employees, and we want to build a query that can filter results based on optional parameters for Department and Salary.

**Security Considerations**
Parameterization: Always use parameterized queries (sp_executesql) to prevent SQL injection.
Validation: Validate and sanitize input parameters before using them in the query.

**TRIGGER :**

A trigger in SQL is a database object that is automatically executed or fired when certain events occur in the database. Triggers can be used to enforce business rules, maintain audit trails, and ensure data integrity.

**CONS:**
1. It can be performance overhead 
2. Complex debugging scenarios.
3. Documentation need (Tough to identify for new developer to identify what happening in background)

**TYPES OF TRIGGERS :**

**1. DML Triggers:** Fired when DML events performed such as INSERT, UPDATE, and DELETE.
		AFTER Triggers: Fired after the DML event.
		INSTEAD OF Triggers: Fired in place of the DML event.

**2. DDL Triggers:** These are fired by Data Definition Language (DDL) events such as CREATE, ALTER, and DROP.
**3. Logon Triggers:** These are fired in response to LOGON events, typically used for auditing and controlling logon activities.

**MAGIC TABLES :** "MAGIC TABLES" refer to the special tables named inserted and deleted that are used within the context of DML triggers. These tables provide a way to access the rows affected by INSERT, UPDATE, and DELETE operations within the trigger.

**INSERTED TABLE:** This table holds the new rows that are being inserted during an INSERT operation or the new values of the rows being updated during an UPDATE operation.
**DELETED TABLE:** This table holds the old values of the rows being deleted during a DELETE operation or the old values of the rows being updated during an UPDATE operation.

**Note : Magic tables only accessible inside trigger (no where else)**

**SQL injection :**

SQL injection is one of the most common web hacking techniques that might destroy your database by placing malicious code in SQL statements, via web page input.

**How SQL Injection Works :**

**User Input:** An attacker provides malicious SQL input through a user input field.
**Injection Point:** The application uses this input to build an SQL query without properly sanitizing or validating the input.
**Execution:** The database executes the malicious SQL query, leading to unintended behavior.

SELECT UserId, Name, Password FROM Users WHERE UserId = 105 or 1=1;(always true and executed)

SELECT * FROM Users WHERE Name ="" or ""="" AND Pass ="" or ""=""; (always true and executed)

**Prevention Techniques :**
**1.** Use stored procedures with parameters to execute queries. This encapsulates SQL code within the database.

**2.** Validate and sanitize user input to ensure it conforms to expected formats and does not contain malicious characters. This can involve:
   
**Whitelisting:** Allowing only expected characters.

**Blacklisting:** Blocking known dangerous characters.

**Length checks:** Ensuring input does not exceed expected lengths.

**3.** Use parameterized queries to separate SQL code from data. This ensures that user input is treated as data, not executable code.
