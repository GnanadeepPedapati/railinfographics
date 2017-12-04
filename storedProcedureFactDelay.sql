

use db
go
create procedure dbo.storedProcedureFactDelay
as
begin
insert into factDelay (dateID,trainID,stationID,ETA,delayArrival,ETD,delayDeparture)
select dimTime.dateID,dimTrain.trainNo,dimS.stationID,dtb.ETA,dtb.delayArr,dtb.ETD,dtb.delayDep from delayTable as dtb
inner join  dimTime  on dimTime.date=dtb.dt
inner join dimensionStation as dimS on dimS.stationName=dtb.station
inner join dimensionTrainInfo as dimTrain on dimTrain.trainNo=dtb.trainNo
where not exists(select * from factDelay where dimTrain.trainNo=factDelay.trainID
and
dimS.stationID=factDelay.stationID
and
dimTime.date=factDelay.dateID
)
end
go
--drop procedure storedProcedureFactDelay
exec storedProcedureFactDelay
select * from factDelay
--delete from factDelay