/*
select *
from FactResellerSales
order by SalesOrderNumber
*/

select * 
from FactResellerSales
where CarrierTrackingNumber = '4911-403c-98'

create nonclustered index idx_FactReseller_CTA
on FactResellerSales (CarrierTrackingNumber)

