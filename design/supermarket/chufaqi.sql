--订单增加、更新时自动导入价格，计算单件商品总价
create trigger money on D
for insert ,update
as
update D
set D.TPrice=T.TPrice,PPrice=Dnums*T.TPrice
from T
where T.TID=D.TID

--增加更新会员时积分与账单自动更新
create trigger Cjifen1 on G
for insert,update
as
update G
set G.GNum=G.GNum+jifen.GNum
from D,jifen
where G.Dnum=jifen.Dnum and G.Dnum='11878787'

--进货单自动更新产品对应的供货商
create trigger jinhuo on Z
for insert,update
as
update Z
set Scodename=ST.SCodename,
    Zdate=GETDATE(),
    Zprice=T.TPPrice
from ST,T
where Z.TID=ST.TID and Z.TID=T.TID



--进货时KT（各产品剩余数）更新
create trigger 入库量 on Z
for insert,update
as
update KT
set KT.QTY=KT.QTY+Z.ZNums
from Z
where Z.TID=KT.TID

--仓库更新
create trigger 入库 on KT
for insert,update
as
update K
set KNum=各库存信息.KNUM
from 各库存信息
where K.KNO=各库存信息.KNO


--退货单更新
create trigger tuihuo on P
for insert,update
as
update P
set Scodename=ST.SCodename,
    Pdate=DATEADD(DAY,(T.Tkdate-7),T.Tpdate),
    PPrice=T.TPPrice*0.5,
    PNums=Z.ZNums
from ST,T,Z
where P.TID=ST.TID and P.TID=T.TID and P.TID=Z.TID


--退货时KT（各产品剩余数）更新
create trigger tuihuoK on P
for insert,update
as
update KT
set KT.QTY=KT.QTY-P.PNums
from P
where P.TID=KT.TID and GETDATE()=P.Pdate

--建索引
Create unique index IX_TID on T(TID)
Create unique index IX_SCodename on S(SCodename)
Create unique index IX_YID on Y(YID)
Create unique index IX_KNO on K(KNO)
