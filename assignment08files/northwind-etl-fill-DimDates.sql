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
