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
