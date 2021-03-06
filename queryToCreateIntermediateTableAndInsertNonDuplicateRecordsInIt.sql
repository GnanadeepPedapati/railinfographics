/****** Script for SelectTopNRows command from SSMS  ******/
use db
CREATE TABLE [dbo].[intermediate](
	[dateIn] [nvarchar](20) NULL,
	[trainNoIn] [nvarchar](50) NULL,
	[stationIn] [nvarchar](100) NULL,
	[ETAIn] [nvarchar](50) NULL,
	[delayArrIn] [int] NULL,
	[ETDIn] [nvarchar](50) NULL,
	[delayDepIn] [int] NULL
) ON [PRIMARY]
--query to insert into intermediate table so that no duplicate data is entered,but problem with this is very first time that it is run it will copyduplicates but not later ie after first run
insert into intermediate (dateIn,trainNoIn,stationIn,ETAIn,delayArrIn,ETDIn,delayDepIn)
select a.date,a.trainNo,a.station,a.ETA,a.delayArr,a.ETD,a.delayDep from temp as a where-- where not exists
--(select 1 from intermediate as b where b.dateIn=a.date and b.trainNoIn=a.trainNo and b.stationIn=a.station and 
--b.ETAIn=a.ETA and b.delayArrIn=a.delayArr and b.ETDIn=a.ETD and b.delayDepIn=a.delayDep) 
a.trainNo not in
(select b.trainNoIn from intermediate as b where b.trainNoIn=a.trainNo) and a.date not in
(select b.dateIn from intermediate as b where b.dateIn=a.date) and a.station not in
(select b.stationIn from intermediate as b where b.stationIn=a.station)

--other query that could be written to writenon-duplicate row in the internediate table
insert into intermediate
select distinct a.date,a.trainNo,a.station,a.ETA,a.delayArr,a.ETD,a.delayDep from temp as a 

-- query to select non-duplicates from the table 
select dateIn,trainNoIn,stationIn--,ETAIn,delayArrIn,ETDIn,delayDepIn
 from
(select dateIn,trainNoIn,stationIn,ROW_NUMBER()over (Partition by dateIn,trainNoIn,stationIn order by dateIn) as rowNum from intermediate) t where rowNum=1