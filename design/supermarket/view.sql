CREATE VIEW GOODS --创建商品目录视图
AS
SELECT TID, TName, TPrice, TWeight, Tpdate, Tkdate, TNorms
FROM T


CREATE VIEW GOODS_SUPPLIER --商品供应商信息视图
AS
SELECT ST.SID, Sname, SAddress, Stele, SFax, T.TID, Tname, TPrice, TWeight, Tpdate, Tkdate, TNorms
FROM T, S, ST
where T.TID = ST.TID and ST.SID = S.SID



CREATE VIEW SUPPLIER --供应商信息视图
AS
SELECT SID, SName, SAddress, Stele, Sfax
FROM S


CREATE VIEW STOREHOUSE --仓库信息视图
AS
SELECT KID, KNum, KHnum, KDnum, KPersonName, KPersonTele
FROM K


CREATE VIEW STAFF --员工信息视图
AS
SELECT YID,Yname,YSEX,Yage,YZhiCheng
FROM Y
WHERE YStatus = '0'


CREATE view MEMBER --查询会员信息视图
AS
SELECT GID, GName, GSex, GAge, GNum, GPhone
FROM G
WHERE G.GStatus = '0'



create view  MEMBER_BOOK       --用户订单视图
as
select GT.GID, GT.TID, T.TPrice, GT.GTQY, GT.GTQDate
from GT, T
WHERE GT.TID = T.TID


create view MEMBER_TOTALPRICE(GID, TotalPrice)  --创建客户订单总价视图
AS
select TID=MEMBER_BOOK.GID, TotalPrice = SUM(MEMBER_BOOK.GTQY*MEMBER_BOOK.TPrice)
from MEMBER_BOOK
GROUP BY MEMBER_BOOK.GID


create view KT_INFO(KID,KNum) --各库库存总量
as
select KID=KT.KID, KNum=sum(KT.QTY)
from KT
group by KT.KID

select * from ST

CREATE VIEW 退货单与供货商
AS
SELECT PT.PTID, PT.TID, T.Tname, PNum, PPrice, TNorms, Pdate, Sname, ST.SID, SAddress, Stele, SFax
FROM T, S, ST, PT
where T.TID=ST.TID and ST.SID=S.SID and T.TID=PT.TID


CREATE VIEW 进货单与供货商
AS
SELECT ZT.ZTID,ZT.TID,T.Tname,ZNum, ZPrice, TNorms, Zdate, Tpdate, Tkdate, Sname, ST.SID, SAddress, Stele, SFax
FROM T,S,ST,ZT
where T.TID=ST.TID and ST.SID=S.SID and T.TID=Z.TID



CREATE VIEW 每单利润(Dnum,lirun)
as
select top(100)percent Dnum=D.Dnum,
                       lirun=SUM(Dnums*(D.TPrice-T.TPrice))
from D,T
where D.TPrice=T.TPrice
group by D.Dnum



CREATE VIEW 每种商品利润(TID,lirun)
as
select top(100)percent TID=D.TID,
                       lirun=SUM(Dnums*(D.TPrice-T.TPrice))
from D,T
where D.TPrice=T.TPrice
group by D.TID
