insert into DimProducts
    (ProductID, ProductName, ProductCategory, ProductStdPrice, ProductIsDiscontinued)
Select
    ProductID = ProductId
     , ProductName = Cast( ProductName as nVarchar(100) )
     , ProductCategory = Cast( CategoryName as nVarchar(100) )
     , ProductStdPrice =  Cast( UnitPrice as Decimal(18,4) )
     , ProductIsDiscontinued = Cast( (Case When Discontinued  = 1 Then 'T' Else 'F' End ) as nChar(1))
From Northwind.dbo.Products as P
         Join Northwind.dbo.Categories as C
              On P.CategoryId  = C.CategoryId