use SmartStoreV303
go

use KuteShop
GO

select Id,ParentId,MenuName, * from MenuLink where Position=5

select * from [Order]


truncate table [OrderItem]

delete from [OrderItem]

--------------
DBCC CHECKIDENT ('[Order]', RESEED, 0);
