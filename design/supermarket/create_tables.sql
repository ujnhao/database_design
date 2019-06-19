create table T(
                TID BIGINT primary key,
                Tname CHAR(20) NOT NULL,
                TPrice INT NOT NULL,        --商品进价
                Tpdate DATETINE NOT NULL,  --生产日期
                TKdate INT NOT NULL,        --保质期
                TWeight INT NOT NULL,       --产品重量
                TNorms CHAR(20),            --类型
                TProducename CHAR(20),      --生产厂家
                TSellPrice INT NOT NULL,    --商品售价
)

create table S(
                SID BIGINT primary key,         --供应商账号
                SName CHAR(20) NOT NULL,        --供应商姓名
                SAddress CHAR(20) NOT NULL,     --公司地址
                SFax CHAR(20) NOT NULL,         --传真
                STele CHAR(20) NOT NULL,        --电话
)

create table Y(
                YID BIGINT primary key,               --员工id
                YName CHAR(20) NOT NULL,              --员工名
                YSex CHAR(2) NOT NULL,                --员工性别
                YAge INT NOT NULL,                    --员工年龄
                YZhiCheng Char(20) NOT NULL,          --职称
                YStatus CHAR(1) NOT NULL DEFAULT '0', --在职状态
)

create table K(
                KID BIGINT primary key,               --仓库id
                KName CHAR(20),                       --仓库名
                KNum INT NOT NULL,                    --仓库当前存量
                KHnum INT NOT NULL,                   --库存上限
                KDnum INT NOT NULL,                   --库存下限
                KPersonName CHAR(20) NOT NULL,        --负责人名
                KPersonTele CHAR(20) NOT NULL,        --负责人电话
)

Create table G(
                GID BIGINT primary key,            --顾客ID
                GName CHAR(20) NOT NULL,           --顾客名
                GSex CHAR(2),                      --顾客性别
                GAge INT,                          --顾客年龄
                GNum BIGINT NOT NULL DEFAULT 0,    --顾客积分
                GPhone CHAR(20) NOT NULL,          --顾客电话
                GStatus CHAR(1) NOT NULL DEFAULT '0', --顾客状态
)

create table KT(                                         --仓库商品关系表
                 KTID BIGINT IDENTITY(1, 1) primary key, --库存账单id
                 KID BIGINT NOT NULL,                    --库存id
                 TID BIGINT NOT NULL,                    --商品id
                 QTY INT NOT NULL,                       --库存中商品数量
                 FOREIGN KEY (KID) REFERENCES K(KID) ,
                 FOREIGN KEY (TID) REFERENCES T(TID),
)

create table YT(
                 YTID BIGINT IDENTITY(1, 1) primary key,    --销售账单id
                 YID BIGINT NOT NULL,                       --员工id
                 TID BIGINT NOT NULL,                       --商品id
                 SQTY INT NOT NULL,                         --收银员销售的产品数量
                 SQTDate DATETIME DEFAULT CURRENT_TIMESTAMP,
                 FOREIGN KEY (YID) REFERENCES Y(YID) ,
                 FOREIGN KEY (TID) REFERENCES T(TID),
)

create table ST(
                 STID BIGINT IDENTITY(1, 1) primary key,
                 SID BIGINT NOT NULL,                       --供应商id
                 TID BIGINT NOT NULL,                       --商品id
                 GQTY INT NOT NULL,                         --供应商品数量
                 FOREIGN KEY (SID) REFERENCES S(SID) ,
                 FOREIGN KEY (TID) REFERENCES T(TID),
)


Create table GT (                                           --顾客订单表
                  GTID BIGINT IDENTITY(1, 1) primary key,   --顾客订单id
                  GID BIGINT NOT NULL,                      --顾客id
                  TID BIGINT NOT NULL,                      --商品ID
                  GTQY INT NOT NULL,                        --购买数量
                  GTQDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                  FOREIGN KEY (GID) REFERENCES G(GID),
                  FOREIGN KEY (TID) REFERENCES T(TID),
)

Create table PT(                                            --从供应商进货订单表
                 PTID BIGINT IDENTITY(1, 1) primary key,
                 SID BIGINT NOT NULL,
                 TID BIGINT NOT NULL,
                 PNum INT NOT NULL,
                 PDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                 PPrice INT NOT NULL,
                 FOREIGN KEY (SID) REFERENCES S(SID),
                 FOREIGN KEY (TID) REFERENCES T(TID),
)

Create table ZT(                                           --将过期售量不好的产品退给供应商
                 ZTID BIGINT IDENTITY(1, 1) primary key ,
                 SID BIGINT NOT NULL,
                 TID BIGINT NOT NULL,
                 ZNum INT NOT NULL,
                 ZDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                 ZPrice INT NOT NULL,
                 FOREIGN KEY (SID) REFERENCES S(SID),
                 FOREIGN KEY (TID) REFERENCES T(TID),
)
