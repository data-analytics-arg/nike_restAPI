select t4.*, t5.FULL_NAME as PROVEEDOR
from
(select cast(YEAR (GETDATE())as int) as YEAR_DATE,  cast(RIGHT(YEARWEEK_DATE , 2)as int) as WEEK_DATE,
cast(YEAR (GETDATE()) as varchar) + cast(RIGHT(YEARWEEK_DATE , 2) as varchar) as PERIODO , t2.YEARMONTH_DATE ,
t2.branchid as BRANCHID,t2.ubicacion AS UBICACION,t2.banner AS BANNER, t2.CCODIGO_CI , t2.art_name as ART_NAME , 
t2.art_matriz as ART_MATRIZ,t2.descripcion AS DESCRIPCION,t2.codigoProveedor AS CODIGOPROVEEDOR ,
t2.talle as TALLE,  marca AS MARCA, t2.clase AS CLASE , t2.Categoria AS CATEGORIA, t2.Sub_Categoria AS SUB_CATEGORIA , 
t2.Coleccion AS COLECCION , t2.Matriz AS MATRIZ , t2.Genero AS GENERO, t2.Familia AS FAMILIA , t2.Calidad AS CALIDAD , 
t2.Precio_Costo_SIN_DESCUENTO AS PRECIO_COSTO_SIN_DESCUENTO,
t2.PRECIO_COSTO_CON_DESCUENTO , t2.PDV_Dexter AS PDV_DEXTER , t2.PDV_StockCenter AS PDV_STOCKCENTER,t2.PDV_Moov AS PDV_MOOV ,
t2.PDV_NikeShops AS PDV_NIKESHOPS ,t2.PDV_eDexter AS PDV_EDEXTER , t2.PDV_eMeli AS PDV_EMELI , t2.PDV_eMoov AS PDV_EMOOV , 
t2.PDV_ESTOCK_CENTER AS PDV_ESTOCK_CENTER, sum(t2.unidades_vendidas) AS UNIDADES_VENDIDAS, sum(t2.Venta_Neta) AS VENTA_NETA, 
sum(t2.STOCK) AS STOCK, t2.REPORTE
from
(select t1.* 
from
(select YEARWEEK_DATE , art_name, YEARMONTH_DATE,
branchid as BRANCHID, ubicacion as UBICACION,banner  as BANNER, CCODIGO_CI , descripcion ,art_matriz , Talle ,
codigoProveedor , marca ,clase , Categoria , Sub_Categoria , Coleccion , Matriz , Genero , Familia , 
Calidad , Precio_Costo_SIN_DESCUENTO , PRECIO_COSTO_CON_DESCUENTO , PDV_Dexter , PDV_StockCenter ,PDV_Moov ,
PDV_NikeShops ,PDV_eDexter , PDV_eMeli , PDV_eMoov , PDV_ESTOCK_CENTER , cantidad as unidades_vendidas, 
Venta_Neta as Venta_Neta , 0 AS STOCK, 'MTD' as REPORTE
from dabra.dbo.bi_tbl_tablero_ventas
where YEARMONTH_DATE 
like (select concat(CAST(year(GETDATE()) AS Varchar), right('0' + convert(varchar,datepart(mm,getdate())),2)))
and clase in ('ACCESORIOS', 'CALZADO', 'INDUMENTARIA')
and branchid not in ('872', '401')
and art_name is not NULL 
union all
select YEARWEEK_DATE ,art_name, YEARMONTH_DATE,
branchid as BRANCHID, ubicacion as UBICACION,banner  as BANNER, CCODIGO_CI , descripcion ,art_matriz , Talle ,
codigoProveedor , marca , clase , Categoria , Sub_Categoria , Coleccion , Matriz , Genero , Familia , 
Calidad , Precio_Costo_SIN_DESCUENTO , PRECIO_COSTO_CON_DESCUENTO , PDV_Dexter , PDV_StockCenter ,PDV_Moov ,
PDV_NikeShops ,PDV_eDexter , PDV_eMeli , PDV_eMoov , PDV_ESTOCK_CENTER ,0 AS unidades_vendidas, 
 0 AS Venta_Neta ,cantidad_stock as STOCK , 'MTD' as REPORTE
from dabra.dbo.bi_tbl_tablero_stock btts 
where YEARMONTH_DATE 
like (select concat(CAST(year(GETDATE()) AS Varchar), right('0' + convert(varchar,datepart(mm,getdate())),2)))
and clase in ('ACCESORIOS', 'CALZADO', 'INDUMENTARIA')
and branchid not in ('872', '401')
and art_name is not NULL )t1)t2
group by art_matriz, talle,  
ubicacion ,branchid,banner , CCODIGO_CI ,descripcion ,codigoProveedor  , marca , 
clase  , Categoria , Sub_Categoria  , Coleccion  , Matriz  , Genero , Familia  , Calidad  , Precio_Costo_SIN_DESCUENTO ,
PRECIO_COSTO_CON_DESCUENTO , PDV_Dexter , PDV_StockCenter ,PDV_Moov ,PDV_NikeShops  ,PDV_eDexter  , 
PDV_eMeli  , PDV_eMoov  , PDV_ESTOCK_CENTER , REPORTE, YEARMONTH_DATE,t2.YEARWEEK_DATE,art_name)t4
left join tbl_dim_Netsuite_Entity t5
on t4.codigoProveedor = t5.ENTITY_ID  










