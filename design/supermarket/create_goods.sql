create table goods(
    goods_id BIGINT identity(1, 1) NOT NULL, --商品id 自增
    goods_name CHAR(20) NOT NULL, --商品名称
    goods_price INT NOT NULL, --商品单价
    goods_product_date DATE NOT NULL, --生产日期
    goods_quality_guarantee_period_date INT NOT NULL,--保质期
    goods_weight BIGINT NOT NULL, --商品重量
    goods_norms CHAR(20) NOT NULL , --商品类型
    goods_num BIGINT NOT NULL,
    status CHAR(20) NOT NULL DEFAULT '0',           --状态: 0正常, 1删除;
    source CHAR(20),      --商品来源
    extra TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOt NULL DEFAULT CURRENT_TIMESTAMP UPDATE CURRENT_TIMESTAMP,
)

