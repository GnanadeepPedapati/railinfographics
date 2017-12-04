use db 
create table dimensionTime(dateID int not null identity(1,1) primary key,
	[date] datetime NULL,
	[year] datetime NULL,
	[month] datetime NULL,
	[week] datetime NULL,
	[dayOfWeek] int NULL,
	[weekDay] nvarchar NULL);

	create table dimTime
	(dateID int not null identity(1,1) primary key,
	[date] datetime NULL)

create table dimensionTrainInfo(
	[trainNo]  int not null  primary key,
	[trainName] nvarchar(250) NULL,
	[noOfStoppage] int NULL,
	[totalDistanceCoveredByTrain] int NULL );


create table dimensionStation([stationID] int not null identity(1,1) primary key,
	[stationName] nvarchar(250));

create table factTrainStation(
	[trainId] int,
	[stationID] int,
	[schDay] int NULL,
	[schArrival] nvarchar(250) NULL,
	[schDeparture] nvarchar(250) NULL,
	[distance] int);

create table factDelay(
	[dateID] int,
	[trainID] int,
	[stationID] int,
	[ETA] nvarchar(200) NULL,
	[delayArrival] int NULL,
	[ETD] nvarchar(200) NULL,
	[delayDeparture] int NULL);
	
	use db

alter table dbo.factTrainStation add  foreign key (trainId) references dbo.dimensionTrainInfo(trainNo),
foreign key (stationID) references dbo.dimensionStation(stationID);

alter table factDelay add
foreign key(dateID) references  dimTime(dateID),
foreign key (trainID) references dbo.dimensionTrainInfo(trainNo),
foreign key (stationID) references dbo.dimensionStation(stationID);
select * from delayTable
