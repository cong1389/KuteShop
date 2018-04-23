use SmartStoreV303
go

use KuteShop
GO

select Id,ParentId,MenuName, * from MenuLink where Position=5

select Status,* from SlideShow
select * from [Order]

update PostGallery
set Status=1

--truncate table ShoppingCartItem

--delete from Customer where userName is null

----------------
--DBCC CHECKIDENT ('[Order]', RESEED, 0);
