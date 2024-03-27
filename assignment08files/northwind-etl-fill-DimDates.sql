-- Create variables to hold the start and end date
Declare @StartDate datetime = '01/01/1995'
Declare @EndDate datetime = '01/01/2000'

-- Use a while loop to add dates to the table
Declare @DateInProcess datetime
Set @DateInProcess = @StartDate

While @DateInProcess <= @EndDate
    Begin
        -- Add a row into the date dimension table for this date
        Insert Into DimDates
        ( [Date], [DateName], [Month], [MonthName], [Quarter], [QuarterName], [Year], [YearName] )
        Values (
                 @DateInProcess -- [Date]
               , DateName( weekday, @DateInProcess ) + ', ' + Cast(@DateInProcess as nVarchar(20)) -- [DateName]
               , Month( @DateInProcess ) -- [Month]
               , DateName( month, @DateInProcess ) -- [MonthName]
               , DateName( quarter, @DateInProcess ) -- [Quarter]
               , 'Q' + DateName( quarter, @DateInProcess ) + ' - ' + Cast( Year(@DateInProcess) as nVarchar(50) ) -- [QuarterName]
               , Year( @DateInProcess ) -- [Year]
               , Cast( Year(@DateInProcess ) as nVarchar(50) ) -- [YearName]
               )
        -- Add a day and loop again
        Set @DateInProcess = DateAdd(d, 1, @DateInProcess)
    End

-- 2e) Add additional lookup values to DimDates
-- Used with Execute SQL Task "Add Null Date Lookup Values"
Set Identity_Insert [DWNorthwindOrders].[dbo].[DimDates] On
Insert Into [DWNorthwindOrders].[dbo].[DimDates]
( [DateKey]
, [Date]
, [DateName]
, [Month]
, [MonthName]
, [Quarter]
, [QuarterName]
, [Year], [YearName] )
Select
    [DateKey] = -1
     , [Date] =  Cast('01/01/1900' as nVarchar(50) )
     , [DateName] = Cast('Unknown Day' as nVarchar(50) )
     , [Month] = -1
     , [MonthName] = Cast('Unknown Month' as nVarchar(50) )
     , [Quarter] =  -1
     , [QuarterName] = Cast('Unknown Quarter' as nVarchar(50) )
     , [Year] = -1
     , [YearName] = Cast('Unknown Year' as nVarchar(50) )
Union
Select
    [DateKey] = -2
     , [Date] = Cast('01/02/1900' as nVarchar(50) )
     , [DateName] = Cast('Corrupt Day' as nVarchar(50) )
     , [Month] = -2
     , [MonthName] = Cast('Corrupt Month' as nVarchar(50) )
     , [Quarter] =  -2
     , [QuarterName] = Cast('Corrupt Quarter' as nVarchar(50) )
     , [Year] = -2
     , [YearName] = Cast('Corrupt Year' as nVarchar(50) )
Set Identity_Insert [DWNorthwindOrders].[dbo].[DimDates] Off
