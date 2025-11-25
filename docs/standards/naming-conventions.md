---
layout: standard
order: 16
title: naming conventions
date: 2025-11-20 
id: OFQ-00016 # Set unique ID for standard
# use `tags: []` for no tags
# Note: tags must use sentence case capitalisation
tags:
  - Digital
  - Data
  - Infrastructure

---
Naming conventions provide clear meaning and consistency throughout the Ofqual Azure environments, subscriptions and solutions.
They enable easy and quick identification of purpose and usage.

---

## Requirement(s)

- [Azure Resources](#azure-resources)
- [Service Principal Names](#service-principle-names)
- [SQL Database Objects](sql-database-objects)
- [Azure Data Factory Objects](#azure-data-factory-objects)

### Azure Resources
Below is the naming convention that MUST be observed when deploying resources to the Ofqual Azure subscriptions.
When naming an Azure resource, follow the format below:

 **{Organisation}{Owner}-{Environment}-{Solution}-{ResourceType}{Instance}**
<br>
| **Aspect**<br> | **Description**<br> | **Example(s)**<br> |
| --- | --- | --- |
| **Organisation**<br> | Organisation name<br> | **ofq**         (Ofqual)<br> |
| **Owner**<br> | Code of the team or group responsible for the product<br> | **ds**           (Data Service)<br> |
| **Environment**<br> | The purpose and name of each environment.<br> | **dev**        (Development environment)<br>**test**        (Test environment)<br>**prod**      (Production environment)<br> |
| **Solution/**<br>**Product**<br> | The code of the solution or product the resources are supporting.<br> | **md**         (AO Portal Master Data)<br>**dp**           (Data Portal)<br>**dw**          (Data Warehouse)<br>**di**            (Data Importer)<br> |
| **Resource Type**<br> | Code of the Azure resource type or service.<br> | **rg**            (Resource Group)<br>**sql**          (Azure SQL Database)<br>**s**              (Azure SQL Server)<br>**vm**          (Virtual Machine)<br>**kv**           (Key Vault)<br>**df**            (Data Factory)<br>**sa**            (Storage Account)<br>…<br> |
| **Instance**<br> | Instance number, should more than one instance be required. (zero padded)<br> | **01, 02, 03, …**<br> |

Examples:
| **ofqds-dev-md-sql01**<br> | An Azure SQL database (**sql01**) for the Master Data solution (**md**) in the Development environment (**dev**).<br> |
| --- | --- |
| **ofqds-prod-dp-s01**<br> | An Azure SQL server (hosting databases) (**s01**) for the Data Portal solution (**dp**) in the Production environment (**prod**).<br> |
| **ofqdsdevdlsa01**<br> | An Azure Storage Account (**sa01**) for the Data Lake solution (**dl**) in the Development environment (**dev**). _Note: storage accounts don’t allow hyphens, so they are omitted_.<br> |
| **ofqds-prod-dp-vm01**<br> | A Virtual Machine (**vm01**) for the Data Portal solution (**dp**) in the Production environment (**prod**).<br> |
| **ofqds-dev-dp-rg01**<br> | A Resource Group (**rg01**) for the Data Portal (**dp**) solution in the Development environment (**dev**).<br> |

### Service Principal Names:
Below is the naming convention that MUST be used when requesting a new Service Principal (an AAD account) for application level access to resources across the network.

**{Organisation}{Owner}-spn-{Solution}**

**e.g.**
**ofqds-spn-DataImporter**

| **Aspect**<br> | **Description**<br> | **Example(s)**<br> |
| --- | --- | --- |
| **Organisation**<br> | Organisation name<br> | **ofq**         (Ofqual)<br> |
| **Owner**<br> | Code of the team or group responsible for the product<br> | **ds**           (Data Service)<br> |
| **Solution/**<br>**Product**<br> | The name of the solution or product the resources are supporting.<br> | **DataPortal**<br>**DataImporter**<br>**DataMart**<br>**DataWarehouse**<br> |

### SQL Database Objects:
Below is the naming convention that MUST be used against all objects within a SQL database.

| **Object Type**<br> | **Example**<br> | **Description**<br> |
| --- | --- | --- |
| **Schema**<br> | MD_Staging (Master Database Staging)<br>MD_Config (Master Master Configuration)<br><br><br> | The schema the SQL object belongs to.<br> |
| **Grouping**<br> | Ref (Reference)<br>Cfg (Configuration)<br> | A meaningful abbreviation to group certain object within a schema.<br> |
| **Object Type**<br> | T (Table)<br>ST (Staging Table)<br>V (View)<br>TF (Table-Valued Function)<br>SP (Stored Procedure)<br> | An abbreviation of the type of object.<br> |
| **Object_Name**<br> | TransformColumnMapping<br> | The name of the table.  This should be as short but descriptive as possible.<br> |

When naming a database object follow the format shown below:

**{Schema}.{Grouping}_{Object Type}_{Object Name}**

E.g.MD_Staging.Ref_ST_AddressTypes

### Azure Data Factory Objects:
Below is a naming convention that MUST be used for all objects within an Azure Data Factory. 
For the **(type)** and **(subtype)**, see the second and third tables.

| **Object**<br> | **Prefix**<br> | **Example(s)**<br> |
| --- | --- | --- |
| **Linked Service**<br> | **LS_(type)_**<br> | **LS_SQLDB_name**<br> |
| **Integration Runtime**<br> | **IR_**<br> | <br><br> |
| **Shared Integration Runtime**<br> | **SIR_**<br> | <br><br> |
| **Pipeline**<br> | **PL_**<br> | <br><br> |
| **Dataset**<br> | **DS_(type)_(subtype)**<br> | **DS_ADLS_CSV_name**<br> |
| **Dataflow**<br> | **DF_**<br> | <br><br> |
| **Trigger**<br> | **TR_**<br> | <br><br> |

| **Type (for Linked Services and Datasets)**<br> | **Acronym**<br> | **Notes**<br> |
| --- | --- | --- |
| Azure Blob Storage<br> | **BLOB**<br> | <br><br> |
| Azure Data Lake Storage<br> | **ADLS**<br> | <br><br> |
| Azure Data Lake Storage (Gen2)<br> | **ADLSG2**<br> | <br><br> |
| Azure Cosmos DB<br> | **COS**<br> | <br><br> |
| Azure File Storage<br> | **AFILE**<br> | Is an SMB File Share<br> |
| Azure SQL Database<br> | **SQLDB**<br> | <br><br> |
| SQL Server<br> | **SQLVM**<br> | <br><br> |
| Azure SQL Database Managed Instance<br> | **SQLMI**<br> | <br><br> |
| FTP<br> | **FTP**<br> | <br><br> |
| File System<br> | **FILE**<br> | Is an SMB File Share<br> |
| HTTP<br> | **HTTP**<br> | <br><br> |
| REST<br> | **REST**<br> | <br><br> |
| SharePoint Online List<br> | **SHP**<br> | <br><br> |

| **SubType (for Datasets)**<br> | **Acronym**<br> |
| --- | --- |
| Avro<br> | **AVRO**<br> |
| Binary<br> | **BIN**<br> |
| Delimited Text<br> | **CSV, PSV, TSV, TXT**<br> |
| Excel<br> | **XLS**<br> |
| JSON<br> | **JSON**<br> |
| ORC<br> | **ORC**<br> |
| Parquet<br> | **PAR**<br> |
| XML<br> | **XML**<br> |

Activities within a Pipeline should observe the following naming convention:

| **Category**<br> | **Activity**<br> | **Prefix**<br> | **Example(s)**<br> |
| --- | --- | --- | --- |
| **Move & Transform**<br> | Copy Data<br> | **CP_**<br> | <br><br> |
| **Move & Transform**<br> | Data Flow<br> | **DF_**<br> | <br><br> |
| **Azure Function**<br> | Function<br> | **AZF_**<br> | <br><br> |
| **Batch Service**<br> | Custom<br> | **CST_**<br> | <br><br> |
| **Databricks**<br> | Notebook<br> | **DBRN_**<br> | <br><br> |
| **Databricks**<br> | JAR<br> | **DBRJ_**<br> | <br><br> |
| **Databricks**<br> | Python<br> | **DBRP_**<br> | <br><br> |
| **Data Lake Analytics**<br> | U-SQL<br> | **USQL_**<br> | <br><br> |
| **General**<br> | Append Variable<br> | **AVAR_**<br> | <br><br> |
| **General**<br> | Delete<br> | **DEL_**<br> | <br><br> |
| **General**<br> | Execute Pipeline<br> | **EXPL_**<br> | <br><br> |
| **General**<br> | Execute SSIS Package<br> | **EXSSIS_**<br> | <br><br> |
| **General**<br> | Get Metadata<br> | **GMD_**<br> | <br><br> |
| **General**<br> | Lookup<br> | **LK_**<br> | <br><br> |
| **General**<br> | Stored Procedure<br> | **SP_**<br> | <br><br> |
| **General**<br> | Set Variable<br> | **SVAR_**<br> | <br><br> |
| **General**<br> | Validation<br> | **VLD_**<br> | <br><br> |
| **General**<br> | Web<br> | **WEB_**<br> | <br><br> |
| **General**<br> | WebHook<br> | **WHK_**<br> | <br><br> |
| **General**<br> | Wait<br> | **WT_**<br> | <br><br> |
| **HDInsight**<br> | Hive<br> | **HDHV_**<br> | <br><br> |
| **HDInsight**<br> | MapReduce<br> | **HDMR_**<br> | <br><br> |
| **HDInsight**<br> | Pig<br> | **HDPG_**<br> | <br><br> |
| **HDInsight**<br> | Spark<br> | **HDSP_**<br> | <br><br> |
| **HDInsight**<br> | Streaming<br> | **HDST_**<br> | <br><br> |
| **Iteration & Conditionals**<br> | Filter<br> | **FLTR_**<br> | <br><br> |
| **Iteration & Conditionals**<br> | For Each<br> | **FE_**<br> | <br><br> |
| **Iteration & Conditionals**<br> | If Condition<br> | **IF_**<br> | <br><br> |
| **Iteration & Conditionals**<br> | Switch<br> | **SW_**<br> | <br><br> |
| **Iteration & Conditionals**<br> | Until<br> | **UN_**<br> | <br><br> |
| **Machine Learning**<br> | Batch Execution<br> | **MLBE_**<br> | <br><br> |
| **Machine Learning**<br> | Update Resource<br> | **MLUR_**<br> | <br><br> |
| **Machine Learning**<br> | Execute Pipeline<br> | **MLEP_**<br> | <br><br> |


### Azure Key Vault:
Naming convention that MUST be used when storing secrets within Key Vault (environment optional):
**scrt-{SecretType}-{SecretDescription}-{SecretSubType}-{Environment}**
Note: environment optional e.g.
**scrt-SQL-DWAdmin-UserName-Dev**
**scrt-spn-DataImporter-UserName**

---
