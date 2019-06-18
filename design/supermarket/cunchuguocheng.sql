--商品信息查询的存储过程:
create procedure T_T
  @T_ID char(15),
  @T_name char(30),
  @T_Pro char(18)
as
select*
from T
where TID=@T_ID


--员工信息查询的存储过程:
create procedure Y_Y
  @Y_ID Char(16),
  @Y_name Char(16),
  @Y_Sex Char(1),
  @Y_Age Char(12),
  @Y_Zhichen Char(6)
as
select *
from Y
where YID=@Y_ID

--供应商信息查询存储过程:
create procedure S_S
  @S_Codename Char(8),
  @S_Name Char(12),
  @S_Address Char(16),
  @S_Fax Char(11),
  @S_Tele Char(11)
as
select *
from S
where SCodename=@S_Codename

--库存信息查询的存储过程:
create procedure K_K
  @K_NO char(2),
  @K_Num Char(4),
  @K_Pnum Int,
  @K_Person Char(8)
as
  select*
  from K
  where KNO=@K_NO
