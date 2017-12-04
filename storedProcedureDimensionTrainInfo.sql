
use db
go
create procedure dbo.storedProcedureDimensionTrainInfo
as
begin
insert into dimensionTrainInfo (trainNo,trainName,noOfStoppage,totalDistanceCoveredByTrain)
select distinct CONVERT(int,trainschedule.trainNo),trainList.trainName,
count(trainschedule.sNo)as noOfStoppage,max(convert(int,distance)) as totalDistanceCoveredByTrain 
from trainList inner join 
trainschedule
on trainschedule.trainNo=trainList.trainNo where not exists(select * from dbo.dimensionTrainInfo as dti where 
dti.trainNo=trainschedule.trainNo and dti.trainName=trainList.trainName
)
 group by trainschedule.trainNo, trainName 
end

exec storedProcedureDimensionTrainInfo
--delete from dimensionTrainInfo
select * from dimensionTrainInfo
--drop procedure storedProcedureDimensionTrainInfo