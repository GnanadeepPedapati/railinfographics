
use db
--for dimensionStation
insert into dimensionStation ([stationName]) select distinct station from trainschedule;

select * from dimensionStation

--for table dimensionTraininfo
insert into dimensionTrainInfo (trainNo,trainName,noOfStoppage,totalDistanceCoveredByTrain)
select distinct CONVERT(int,trainschedule.trainNo),trainList.trainName,
count(trainschedule.sNo)as noOfStoppage,max(convert(int,distance)) as totalDistanceCoveredByTrain 
from trainList inner join 
trainschedule
on trainschedule.trainNo=trainList.trainNo
group by trainschedule.trainNo, trainName

select * from dimensionTrainInfo

--for table factTrainStation
insert into factTrainStation (trainId,stationID,schDay,schArrival,schDeparture,distance)
select dimTr.trainNo,dimS.stationID,ts.schDay,ts.schArr,ts.schDep,ts.distance from trainschedule as ts 
inner join dimensionStation as dimS on dimS.stationName=ts.station
inner join dimensionTrainInfo as dimTr on convert(int,ts.trainNo)=dimTr.trainNo

select * from factTrainStation

--for fact table factDelay
--in this the time needs to be converted to to standard format in fact table in order to apply inner join based on date
--also ETA and ETD need to be converted to standard format
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
--delete from factDelay

select * from delayTable
