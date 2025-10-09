use AdventureWorksDW2019
-- DLL Trigerid serveris
-- Süntaks loomaks DDL trigereid
create trigger [Trigger_Name]
ON [Scope(Server|Database)]
FOR [EventType1,EventType2,EventType3, ...],
as 
begin
end

CREATE TRigger trMyfirstTrigger
on Database
for CREATE_TABLE
AS
BEGIN 
	print 'New table created'
end	

--kuidas ära hoida kasutajatel loomaks, muutmaks või kustatamiseks tabelit. 
ALTER TRIGGER trMyfirstTrigger
ON database 
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
rollback
print 'You cannot create, aöter or drop a table'
end

--Kui lubada triggerit:
disable trigger trMyfirstTrigger on database


drop trigger trMyfirstTrigger

---- Järgnev trigger käivitub, kui peaksid kasutama sp_rename käsklust süsteemi stored procedurite muutmisel.

create trigger trRenameTable
on database
for RENAME
as
begin
print'you just renamed something'
end

-- Järgnev kood muudab TestTable nime NewTestTable nimeks
sp_rename 'TestTable', 'NewTestTable' 
-- Järgnev kood muudab Id veergu NewTestTabel tabelis NewId peale
sp_rename 'NewTestTable.Id' , 'NewId', 'column'

--test
--test