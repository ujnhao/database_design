create table T(
                TID Char(8)primary key,
                Tname Char(14)NOT NULL,
                TPrice Int NOT NULL,
                Tpdate date NOT NULL,       --生产日期
                TKdate int NOT NULL,        --保质期
                TWeight Char(8)NOT NULL,    --产品重量
TNorms Char(12),            --类型
)
create table S(
                SCodename Char(8)primary key,  --供应商账号
                SName Char(12)NOT NULL,        --供应商姓名
SAddress Char(30)NOT NULL,     --公司地址
SFax Char(11)NOT NULL,         --传真
STele Char(11)NOT NULL,        --电话
)
create table Y(
                YID Char(6)primary key,
                Yname Char(6)NOT NULL,
                YSex Char(2)NOT NULL,
                YAge Char(2)NOT NULL,
                YZhichen Char(20)NOT NULL,
)
create table K(
                KNO char(2)primary key,
                KNum Char(4)NOT NULL,
                KHnum Char(112)NOT NULL,
                KDnum Char(12)NOT NULL,
                KPerson Char(8)NOT NULL,
)
create table TY(
                 YID char(8)NOT NULL,
                 TID Char(8)NOT NULL,
                 SQTY char(6)NOT NULL,         --收银员销售的产品数量
)
create table ST(
                 SCodename Char(8)NOT NULL,    --供应商账号
                 TID Char(8)NOT NULL,
  )
create table KT(
                 KNO char(2)NOT NULL,
                 TID Char(8)NOT NULL,
                 QTY int NOT NULL,            --库存中产品数量
)
Create table G(
                GName char(12)NOT NULL ,
                GSex char(2)NOT NULL,
                GNums char(12)NOT NULL,        --会员号
                GNum char(5)NOT NULL,          --积分
)
Create table D(               --顾客订单表
  Dnum char(12)NOT NULL,
  TID char(8)NOT NULL,
  DNums char(8)NOT NULL,
  Ddate date,
  TPrice Int
    foreign key(TID) references T(TID),
  )
Create table Z(              --从供应商进货订单表
  Zno char(12)primary key ,
  TID char(8)NOT NULL,
  ZNums char(8)NOT NULL,
  SCodename Char(8)NOT NULL,
  Zdate date,
  Zprice int,
  )
Create table P(            --将过期售量不好的产品退给供应商
  Pno char(12)primary key ,
  TID char(8)NOT NULL,
  PNums char(8)NOT NULL,
  Pdate date,
  SCodename Char(8)NOT NULL,
  PPrice int,
  )
