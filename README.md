# SQL-Merge-Cursor-Trigger-Dynamic-Query
SQL Merge Cursor Trigger &amp;  Dynamic Query


The MERGE statement in SQL allows you to perform insert, update, or delete operations in a single statement.

This is particularly useful for synchronizing tables. 

TargetTable: This is the table we want to update.

SourceTable: This is the table containing the new data we want to merge into TargetTable.

So Now We have TargetTable with the current data of employees, and SourceTable with updated data of employees. 

We want to:

Update existing employee records in TargetTable if they exist in SourceTable.
Insert new employee records into TargetTable if they do not exist.
Optionally, we can delete records from TargetTable if they are no longer present in SourceTable.

MERGE INTO TargetTable AS T
USING SourceTable AS S
ON T.EmployeeID = S.EmployeeID
WHEN MATCHED THEN
    UPDATE SET T.FirstName = S.FirstName,
               T.LastName = S.LastName,
               T.Department = S.Department
WHEN NOT MATCHED BY TARGET THEN
    INSERT (EmployeeID, FirstName, LastName, Department)
    VALUES (S.EmployeeID, S.FirstName, S.LastName, S.Department)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
	
/**
CREATE TABLE [dbo].[SourceTable](
	[EmployeeID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Department] [nvarchar](50) NULL,
)

CREATE TABLE [dbo].[TargetTable](
	[EmployeeID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Department] [nvarchar](50) NULL,
)
INSERT [dbo].[SourceTable] ([EmployeeID], [FirstName], [LastName], [Department]) VALUES (1, N'John', N'Doe', N'Marketing')
INSERT [dbo].[SourceTable] ([EmployeeID], [FirstName], [LastName], [Department]) VALUES (2, N'Jane', N'Smith', N'HR')
INSERT [dbo].[SourceTable] ([EmployeeID], [FirstName], [LastName], [Department]) VALUES (4, N'Anna', N'Taylor', N'IT')
GO
INSERT [dbo].[TargetTable] ([EmployeeID], [FirstName], [LastName], [Department]) VALUES (1, N'John', N'Doe', N'Marketing')
INSERT [dbo].[TargetTable] ([EmployeeID], [FirstName], [LastName], [Department]) VALUES (2, N'Jane', N'Smith', N'HR')
INSERT [dbo].[TargetTable] ([EmployeeID], [FirstName], [LastName], [Department]) VALUES (4, N'Anna', N'Taylor', N'IT')
**/
