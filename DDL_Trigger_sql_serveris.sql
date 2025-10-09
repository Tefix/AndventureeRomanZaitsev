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

-- Andmebaasi ulatuses olev DDL trigger
-- See trigger takistab tabelite loomist, muutmist ja kustutamist antud andmebaasis
CREATE TRIGGER tr_DatabaseScopeTrigger 
ON Database
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
PRINT 'You cannot create, modify, alter or drop a table in the current database'
END

-- Serveri ulatuses olev DDL trigger
-- See trigger takistab tabelite loomist, muutmist ja kustutamist kõigis serverites, kus trigger on loodud
CREATE TRIGGER tr_ServerScopeTrigger
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
PRINT 'You cannot create, modify, alter or drop a table in the current database'
END

-- Kuidas saab Serveri ulatuses olevat DDL triggerit desaktiveerida
DISABLE TRIGGER tr_ServerScopeTrigger ON ALL SERVER

-- Kuidas saab Serveri ulatuses olevat DDL triggerit aktiveerida
ENABLE TRIGGER tr_ServerScopeTrigger ON ALL SERVER

-- Kuidas kustutada Serveri ulatuses olev DDL trigger
DROP TRIGGER tr_ServerScopeTrigger ON ALL SERVER
