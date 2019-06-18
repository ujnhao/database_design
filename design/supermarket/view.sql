CREATE VIEW 商品 --创建商品信息视图
AS
SELECT TID,Tname,TPrice,TWeight,Tpdate,Tkdate,TNorms
FROM T


CREATE VIEW 商品与供货商 --商品供应商信息视图
AS
SELECT T.TID,Tname,TPrice,TWeight,Tpdate,Tkdate,TNorms,Sname,ST.SCodename,SAddress,Stele,SFax
FROM T,S,ST
where T.TID=ST.TID and ST.SCodename=S.SCodename

CREATE VIEW 供应商信息 --供应商信息视图
AS
SELECT SCodename ,SName,SAddress ,Stele,Sfax
FROM S


CREATE VIEW 仓库信息 --仓库信息视图
AS
SELECT KNO,KNum,KHnum,KDnum,kperson
FROM K



CREATE VIEW 员工信息 --员工信息视图
AS
SELECT YID,Yname,YSEX,Yage,Yzhichen
FROM Y



CREATE view 会员信息 --查询会员信息视图
AS
SELECT GName,GSex,GNums,GNum
FROM G



create view 各订单总额(Dnum, PPrice) --订单总价视图
as
select top(100)percent Dnum=D.Dnum,
                       PPrice=SUM(Dnums*TPrice)
from D
group by D.Dnum



select * into SumP from 各订单总额 --将视图中的内容存下




create view 总订单信息 --创建订单视图
as
select SumP.Dnum,D.TID,Tname,Dnums,D.TPrice,SumP.PPrice,Ddate
from D,T,SumP
where D.TID=T.TID and SumP.Dnum=D.Dnum



create view everyday(Ddate,PPrice)
as
select top(100)percent Ddate=D.Ddate,
                       SUMPrice=SUM(Dnums*TPrice)
from D
group by D.Ddate


create view 盘点
as
select D.Ddate, D.TID, T.Tname, D.DNums, D.TPrice, everyday.PPrice
from D, T, everyday
where D.TID=T.TID and D.Ddate = everyday.Ddate



create view 各库存信息(KNO,KNUM) --各库库存总量
as
select top(100)percent KNO=KT.KNO,
                       KNUM=sum(KT.QTY)
from KT
group by KT.KNO



CREATE VIEW 退货单与供货商
AS
SELECT PNO,P.TID,T.Tname,Pnums,PPrice,TNorms,Pdate,Sname,ST.SCodename,SAddress,Stele,SFax
FROM T,S,ST,P
where T.TID=ST.TID and ST.SCodename=S.SCodename and T.TID=P.TID


CREATE VIEW 进货单与供货商
AS
SELECT ZNO,Z.TID,T.Tname,Znums,ZPrice,TNorms,Zdate,Tpdate,Tkdate,Sname,ST.SCodename,SAddress,Stele,SFax
FROM T,S,ST,Z
where T.TID=ST.TID and ST.SCodename=S.SCodename and T.TID=Z.TID



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


select * from everyday
