select * from 盘点 where [Ddate]='2018-06-26'

select * from 总订单信息 where [Dnum]='11223344'

select * from 会员信息 where [GNums]='20161222038'

select * from 员工信息 where [YID]='P001'

select * from 供应商信息 where [SCodename]='112589'

select * from 仓库信息 where [KNO]='01'

select * from 商品 where [TNorms]='日用品'

select * from 各天销售总额 where[Ddate]='2018-02-06'

select * from 各库存信息 where[KNO]='01'

select * from 各订单总额 where[Dnum]='11778899'

select * from jifen where[Dnum]='11778899'

select * from 商品与供货商 where[TID]='T00011'

select * from 退货单与供货商 where[PNo]='221111111'

select * from 进货单与供货商 where[ZNo]='111111112'

select * from 每单利润 where[Dnum]='11778899'

select * from 每日利润 where[Ddate]='2018-06-26'

select * from 每种商品利润 where[TID]='T00011'

delete from G where GNums='20161222114';
insert into G values('王凯','男','20161222114','11878787',0);

insert into D values('11878787','T00001','2','2018-06-27',0,0);
insert into D values('11878787','T00011','6','2018-06-27',0,0);
insert into D values('11878787','T00014','2','2018-06-27',0,0);

update KT
set QTY=300
where TID='T00002'

update K
set KNum=300
where KNO='01'

delete from Z where Zno='111111139';
insert into Z values('111111139','T00002','200','0','2000-01-01',0);

delete from P where Pno='221111139';
insert into P values('221111139','T00002','200','2000-01-01','0',0);

create trigger 入库量 on Z
  for insert,update
  as
  declare @TID char(8),@ZNums char(8)
select @TID=TID,@ZNums=ZNums
from inserted
update KT
set QTY=QTY+@ZNums
where TID=@TID

create trigger Cjifen on jifen
  for insert,update
  as
  declare @GNum int,@Dnum char(8)
select @GNum=GNum,@Dnum=Dnum
from inserted
update G
set GNum=GNum+@GNum
where @Dnum=Dnum


create trigger tuihuoK on P
  for insert,update
  as
  update KT
  set KT.QTY=KT.QTY-P.PNums
  from P
  where P.TID=KT.TID and GETDATE()=P.Pdate


create trigger 入库1 on K
  for insert,update
  as
  update K
  set KNum=各库存信息.KNUM
  from 各库存信息
  where K.KNO=各库存信息.KNO


create trigger Cjifen on G
  for insert,update
  as
  declare @GNum int,@Dnum char(8)
select @GNum=GNum,@Dnum=Dnum
from jifen inserted
update G
set GNum=GNum+@GNum
where @Dnum=Dnum

create trigger Cjifen1 on G
  for insert,update
  as
  update G
  set G.GNum=G.GNum+jifen.GNum
  from D,jifen
  where G.Dnum=jifen.Dnum and G.Dnum='11878787'

CREATE VIEW 每单利润(Dnum,lirun)
as
select top(100)percent Dnum=D.Dnum,
                       lirun=SUM(Dnums*(D.TPrice-TPPrice))
from D,T
where D.TPrice=T.TPrice
group by D.Dnum

CREATE VIEW 每日利润(Ddate,lirun)
as
select top(100)percent Ddate=D.Ddate,
                       lirun=SUM(Dnums*(D.TPrice-TPPrice))
from D,T
where D.TPrice=T.TPrice
group by D.Ddate


CREATE VIEW 每种商品利润(TID,lirun)
as
select top(100)percent TID=D.TID,
                       lirun=SUM(Dnums*(D.TPrice-TPPrice))
from D,T
where D.TPrice=T.TPrice
group by D.TID


CREATE VIEW 商品与供货商
AS
SELECT T.TID,Tname,TPrice,TWeight,Tpdate,Tkdate,TNorms,Sname,ST.SCodename,SAddress,Stele,SFax
FROM T,S,ST
where T.TID=ST.TID and ST.SCodename=S.SCodename

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

create view everyday(Ddate,PPrice)
as
select top(100)percent Ddate=D.Ddate,
                       SUMPrice=SUM(Dnums*TPrice)
from D
group by D.Ddate

create trigger 入库K on K
  for insert,update
  as
  update K
  set KNum=各库存信息.KNUM
  from 各库存信息
  where K.KNO=各库存信息.KNO
