
use db
go
create procedure dbo.storedProcedureFactTrainStation
as
begin
insert into factTrainStation (trainId,stationID,schDay,schArrival,schDeparture,distance)
select dimTr.trainNo,dimS.stationID,ts.schDay,ts.schArr,ts.schDep,ts.distance from trainschedule as ts 
inner join dimensionStation as dimS on dimS.stationName=ts.station
inner join dimensionTrainInfo as dimTr on convert(int,ts.trainNo)=dimTr.trainNo
where not exists
(select * from factTrainStation fts where fts.trainId=dimTr.trainNo and fts.stationID=dimS.stationID)
end
go
exec storedProcedureFactTrainStation

--drop procedure storedProcedureDimensionTrainInfo

select * from factTrainStation
--delete from factTrainStation
--select * from dimensionStation where stationID='3344'