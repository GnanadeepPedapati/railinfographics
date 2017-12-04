use db
GO
CREATE PROCEDURE [dbo].[storedProcDimensionStation]
AS
BEGIN
insert into dbo.dimensionStation ([stationName]) select distinct station from dbo.trainschedule
where not exists(select * from dbo.dimensionStation as ds where ds.stationName=dbo.trainschedule.station);
select * from dbo.dimensionStation
END
GO
exec storedProcDimensionStation
--drop procedure storedProcDimensionStation

