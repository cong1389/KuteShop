use SmartStoreV303
go

use KuteShop
GO

select Id,ParentId,MenuName, * from MenuLink where Position=5

select Status,* from PostGallery
select * from Post

update PostGallery
set Status=1

--truncate table ShoppingCartItem

--delete from Customer where userName is null

----------------
--DBCC CHECKIDENT ('[Order]', RESEED, 0);
