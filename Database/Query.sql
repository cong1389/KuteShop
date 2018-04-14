use SmartStoreV303
go

use KuteShop
GO

select Id,ParentId,MenuName, * from MenuLink where Position=5

select * from [Order]


truncate table [Order]

delete from [Order]