-- Step 2b-1: Import data and get Surrogate Key values
INSERT INTO DimEmployees
(EmployeeID, EmployeeName, ManagerKey, ManagerID)
SELECT
    [EmployeeID]
     ,[EmployeeName] = Cast([FirstName] + ' ' + [LastName] as nVarchar(100))
     ,[ManagerKey] = IsNull([ReportsTo], [EmployeeID])
     ,[ManagerID] = IsNull([ReportsTo], [EmployeeID])
FROM [Northwind].[dbo].[Employees]

-- Step 2b-2: Get Surrogate values for the ManagerKeys
Select Mgr.* , Emp.EmployeeKey as NewMgrKey
Into #EmpTemp
FROM dbo.DimEmployees as Emp
         JOIN  dbo.DimEmployees as Mgr
               On Emp.EmployeeId = Mgr.ManagerKey

-- Step 2b-3: Update the table with Surrogate Key values
UPDATE DimEmployees
Set DimEmployees.[ManagerKey] =  #EmpTemp.NewMgrKey
FROM DimEmployees
         JOIN #EmpTemp
              On  DimEmployees.[ManagerKey] = #EmpTemp.[ManagerKey]
-- Step 2b-4: Drop the Temp Table
Drop Table #EmpTemp
