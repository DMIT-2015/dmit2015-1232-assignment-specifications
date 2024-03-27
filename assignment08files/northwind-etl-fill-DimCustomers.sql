insert into DimCustomers
    (CustomerID, CustomerName, CustomerCity, CustomerRegion, CustomerCountry)
select
    CustomerID = CustomerID
     , CustomerName = Cast( CompanyName as nVarchar(100) )
     , CustomerCity = Cast( City as nVarchar(50) )
     , CustomerRegion = Cast( IsNull(Region, Country) as nVarchar(50) )
     , CustomerCountry = Cast( Country as nVarchar(50) )
From Northwind.dbo.Customers
