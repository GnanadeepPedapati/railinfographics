use db
go
create procedure dbo.storedProcedureDimTime
as
begin
insert into dimTime (date)
select distinct dt from delayTable where not exists
(select date from dimTime as t where t.date=delayTable.dt) 
order by dt
end

exec dbo.storedProcedureDimTime
