Alter Table [dbo].DimEmployees Drop Constraint FK_DimEmployees_DimEmployees
Alter Table [dbo].FactOrders Drop Constraint FK_FactOrders_DimCustomers
Alter Table [dbo].FactOrders Drop Constraint FK_FactOrders_DimEmployees
Alter Table [dbo].FactOrders Drop Constraint FK_FactOrders_DimProducts
Alter Table [dbo]. FactOrders Drop Constraint FK_FactOrders_DimDates_OrderDate
Alter Table [dbo].FactOrders Drop Constraint FK_FactOrders_DimDates_RequiredDate
Alter Table [dbo].FactOrders Drop Constraint FK_FactOrders_DimDates_ShippedDate
