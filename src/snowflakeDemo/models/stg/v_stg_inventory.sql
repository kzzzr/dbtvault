{{ config(materilaized='view', schema='STG', tags='static', enabled=true) }}

select
  MD5_BINARY(UPPER(TRIM(CAST(a.PARTKEY AS VARCHAR)))) AS PART_PK
, MD5_BINARY(UPPER(TRIM(CAST(a.SUPPLIERKEY AS VARCHAR)))) AS SUPPLIER_PK
, MD5_BINARY(UPPER(TRIM(CAST(a.SUPPLIER_NATION_KEY AS VARCHAR)))) AS SUPPLIER_NATION_KEY_PK
, MD5_BINARY(UPPER(TRIM(CAST(a.SUPPLIER_REGION_KEY AS VARCHAR)))) AS SUPPLIER_REGION_KEY_PK
, MD5_BINARY(CONCAT(
    IFNULL(UPPER(TRIM(CAST(a.PARTKEY AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.SUPPLIERKEY AS VARCHAR))), '^^'))) AS INVENTORY_PK
, MD5_BINARY(CONCAT(
    IFNULL(UPPER(TRIM(CAST(a.AVAILQTY AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.PART_SUPPLY_COMMENT AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.SUPPLYCOST AS VARCHAR))), '^^'))) AS INVENTORY_HASHDIFF
, MD5_BINARY(CONCAT(
    IFNULL(UPPER(TRIM(CAST(a.PART_BRAND AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.PART_COMMENT AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.PART_CONTAINER AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.PART_MFGR AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.PART_NAME AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.PART_RETAILPRICE AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.PART_SIZE AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.PART_TYPE AS VARCHAR))), '^^'))) AS PART_HASHDIFF
, MD5_BINARY(CONCAT(
    IFNULL(UPPER(TRIM(CAST(a.SUPPLIER_ACCTBAL AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.SUPPLIER_ADDRESS AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.SUPPLIER_COMMENT AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.SUPPLIER_NAME AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.SUPPLIER_PHONE AS VARCHAR))), '^^'))) AS SUPPLIER_HASHDIFF
, MD5_BINARY(CONCAT(
    IFNULL(UPPER(TRIM(CAST(a.SUPPLIER_NATION_COMMENT AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.SUPPLIER_NATION_NAME AS VARCHAR))), '^^'))) AS SUPPLIER_NATION_HASHDIFF
, MD5_BINARY(CONCAT(
    IFNULL(UPPER(TRIM(CAST(a.SUPPLIER_REGION_COMMENT AS VARCHAR))), '^^'), '||',
    IFNULL(UPPER(TRIM(CAST(a.SUPPLIER_REGION_NAME AS VARCHAR))), '^^'))) AS SUPPLIER_REGION_HASHDIFF
, a.*
, {{var("date")}} AS LOADDATE
,	{{var("date")}} AS EFFECTIVE_FROM
,	'TPCH' AS SOURCE
from {{ref('v_src_inventory')}} as a
