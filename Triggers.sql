/**
A trigger in SQL is a database object that is automatically executed or fired when certain events occur in the database. Triggers can be used to enforce business rules, maintain audit trails, and ensure data integrity.

CONS: 
1. It can be performance overhead 
2. Complex debugging scenarios.
3. Documentation need (Tough to identify for new developer to identify what happening in background)

TYPES OF TRIGGERS :

1. DML Triggers: Fired when DML events performed such as INSERT, UPDATE, and DELETE.
		AFTER Triggers: Fired after the DML event.
		INSTEAD OF Triggers: Fired in place of the DML event.

2. DDL Triggers: These are fired by Data Definition Language (DDL) events such as CREATE, ALTER, and DROP.
3. Logon Triggers: These are fired in response to LOGON events, typically used for auditing and controlling logon activities.

MAGIC TABLES : "MAGIC TABLES" refer to the special tables named inserted and deleted that are used within the context of DML triggers.
These tables provide a way to access the rows affected by INSERT, UPDATE, and DELETE operations within the trigger.

INSERTED TABLE: This table holds the new rows that are being inserted during an INSERT operation or the new values of the rows being updated during an UPDATE operation.
DELETED TABLE: This table holds the old values of the rows being deleted during a DELETE operation or the old values of the rows being updated during an UPDATE operation.

Note : Magic tables only accessible inside trigger (no where else)

**/
--Examples : DML Trigger (AFTER Trigger)

--Creating an AFTER INSERT trigger on the Employees table to automatically log insert operations into an EmployeeAudit table.

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10, 2)
);

CREATE TABLE EmployeeAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    Operation NVARCHAR(50),
    OperationDate DATETIME
);

CREATE TRIGGER trg_AfterInsert
ON Employees
AFTER INSERT
AS
BEGIN
    INSERT INTO EmployeeAudit (EmployeeID, Operation, OperationDate)
    SELECT EmployeeID, 'INSERT', GETDATE()
    FROM inserted;
END;

--DML Trigger (INSTEAD OF Trigger) : Creating an INSTEAD OF DELETE trigger on the Employees table to prevent deletions and log an attempt into the EmployeeAudit table.

CREATE TRIGGER trg_InsteadOfDelete
ON Employees
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO EmployeeAudit (EmployeeID, Operation, OperationDate)
    SELECT EmployeeID, 'DELETE ATTEMPT', GETDATE()
    FROM deleted;
END;

--DDL Trigger : Let's create a DDL trigger that logs any CREATE TABLE operations in the database.

CREATE TABLE DDL_Audit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EventType NVARCHAR(100),
    ObjectName NVARCHAR(100),
    EventDate DATETIME
);

CREATE TRIGGER trg_DDL_Audit
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    DECLARE @EventData XML
    SET @EventData = EVENTDATA()

    INSERT INTO DDL_Audit (EventType, ObjectName, EventDate)
    VALUES (
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'),
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(100)'),
        GETDATE()
    );
END;

--Logon Trigger : Let's create a logon trigger that restricts logon attempts outside of business hours (8 AM to 6 PM).

CREATE TRIGGER trg_Logon
ON ALL SERVER
FOR LOGON
AS
BEGIN
    DECLARE @LogonTime TIME
    SET @LogonTime = CONVERT(TIME, GETDATE())

    IF @LogonTime NOT BETWEEN '08:00:00' AND '18:00:00'
    BEGIN
        ROLLBACK;
    END
END;
