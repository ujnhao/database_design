--增加顾客订单更新会员积分
CREATE TRIGGER Add_GNum
ON GT
AFTER INSERT
AS
  UPDATE G
  SET G.GNum = G.GNum + T.TSellPrice*(ins.GTQY)
  from G, T, inserted as ins
  WHERE G.GID = ins.GID AND T.TID = ins.TID

--进货单自动更新产品对应的供货商
create trigger Purchase on PT
  for insert,update
  as
  update PT
  set SID=ST.SID,
      PDate=GETDATE(),
      PPrice=T.TPrice
  from ST, T
  where PT.TID = ST.TID and PT.TID = T.TID


--进货时KT（各产品剩余数）更新
create trigger 入库量 on PT
  for insert,update
  as
  update KT
  set KT.QTY = KT.QTY + ins.PNum
  from inserted as ins
  where ins.TID = KT.TID

--仓库更新
create trigger 入库 on KT
  for insert,update
  as
  update K
  set K.KNum = K.KNum + ins.QTY
  from inserted as ins
  where K.KID = ins.KID


--退货时KT（各产品剩余数）更新
create trigger 退货 on ZT
  for insert,update
  as
  update KT
  set KT.QTY = KT.QTY - ins.ZNum
  from inserted as ins
  where ins.TID = KT.TID AND GETDATE() = ins.ZDate

--建索引
Create unique index IX_TID on T(TID)
Create unique index IX_SID on S(SID)
Create unique index IX_YID on Y(YID)
Create unique index IX_KID on K(KID)

