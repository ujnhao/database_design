CREATE VIEW GOODS --创建商品目录视图
AS
SELECT TID, TName, TSellPrice, TWeight, Tpdate, Tkdate, TNorms
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
select GT.GID, GT.TID, T.TSellPrice, GT.GTQY, GT.GTQDate
from GT, T
WHERE GT.TID = T.TID


create view MEMBER_TOTALPRICE(GID, TotalPrice)  --创建客户订单总价视图
AS
select TID=MEMBER_BOOK.GID, TotalPrice = SUM(MEMBER_BOOK.GTQY*MEMBER_BOOK.TSellPrice)
from MEMBER_BOOK
GROUP BY MEMBER_BOOK.GID


create view KT_INFO(KID,KNum) --各库库存总量
as
select KID=KT.KID, KNum=sum(KT.QTY)
from KT
group by KT.KID

CREATE VIEW 进货单与供货商
AS
SELECT PT.PTID, PT.TID, T.Tname, T.TNorms, T.Tpdate, PT.PNum, PT.PPrice,
       S.SID, S.SName, S.SAddress, S.SFax, S.STele
FROM T, S, ST, PT
where T.TID=ST.TID and ST.SID=S.SID and T.TID=PT.TID


CREATE VIEW 退货单与供货商
AS
SELECT ZT.ZTID, ZT.TID, T.Tname, T.TNorms, ZT.ZDate, ZT.ZNum, ZT.ZPrice, S.Sname, S.SID, S.SAddress, S.Stele, S.SFax
FROM T, S, ST, ZT
where T.TID = ST.TID and ST.SID = S.SID and T.TID = ZT.TID


CREATE VIEW 每种商品利润(TID, LiRun)
as
select TID = GT.TID, LiRun=SUM(GT.GTQY*(T.TSellPrice-T.TPrice))
from GT,T
where GT.TID=T.TID
group by GT.TID
