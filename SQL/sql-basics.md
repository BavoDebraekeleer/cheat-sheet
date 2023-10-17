# SQL Basics

## Courses and Documentation

- [TutorialRepublic: SQL Tutorial (Datatypes and Commands)](https://www.tutorialrepublic.com/sql-tutorial)
- [C# Corner: Working with Date and Time in SQL Server by Rohatash Kumar](https://www.c-sharpcorner.com/UploadFile/rohatash/working-with-date-and-time-in-sql-server-and-C-Sharp/)
- [dofactory: SQL (Datatypes and example queries.)](https://www.dofactory.com/sql)


---

## Introduction



---

## Datatypes

### Text

|Data type|Description|
|---|---|
|`char(_n_)`|Stores fixed-length character string. Maximum length 8,000 characters.|
|`varchar(_n_)`|Stores variable-length character string. Maximum length 8,000 characters.|
|`varchar(max)`|Stores variable-length character string. Here, `max` indicates that the maximum storage size is 2 GB.|
|`text`|Stores variable-length character string. Maximum storage size is 2 GB.|
|`nchar`|Stores fixed-length Unicode string. Maximum length 4,000 characters.|
|`nvarchar`|Stores variable-length Unicode string. Maximum length 4,000 characters.|
|`nvarchar(max)`|Stores variable-length Unicode string. Here, `max` indicates that the maximum storage size is 2 GB.|
|`ntext`|Stores variable-length Unicode string. Maximum storage size is 2 GB.|
|`binary(_n_)`|Stores fixed-length binary data. Maximum storage size is 8,000 bytes.|
|`varbinary(_n_)`|Stores variable-length binary data. Maximum storage size is 8,000 bytes.|
|`varbinary(max)`|Stores variable-length binary data. Here, `max` indicates that the maximum storage size is 2 GB.|
|`image`|Stores variable-length binary data. Maximum storage size is 8,000 bytes.|

### Numbers

|Data type|Description|
|---|---|
|`bit`|Allows you to store a value 1, 0, or `[NULL](https://www.tutorialrepublic.com/sql-tutorial/sql-constraints.php#not-null)`.|
|`tinyint`|Stores integer values in the range from 0 to 255.|
|`smallint`|Stores integer values in the range from -32,768 to 32,767.|
|`int`|Stores integer values in the range from -2,147,483,648 to 2,147,483,647.|
|`bigint`|Stores integer values in the range from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807.|
|`decimal(_p_,_s_)`|Stores fixed precision and scale numbers. Valid values are from 10`^`38 +1 through 10`^`38 - 1. See below for [more details](https://www.tutorialrepublic.com/sql-reference/sql-server-data-types.php#precision-and-scale).|
|`numeric(_p_,_s_)`|The `numeric` datatype is functionally equivalent to `decimal`.|
|`smallmoney`|Allows you to store monetary or currency values accurately in the range from -214,748.3648 to 214,748.3647.|
|`money`|Allows you to store monetary or currency values accurately in the range from -922,337,203,685,477.5808 to 922,337,203,685,477.5807.|
|`float(n)`|Stores floating point numeric values. Valid values are from -1.79E+308 to -2.23E-308, 0 and 2.23E-308 to 1.79E+308.|
|`real`|Stores floating point numeric values. Valid values are from -3.40E + 38 to -1.18E - 38, 0 and 1.18E - 38 to 3.40E + 38.|

### Date and Time

| Type        | Default format          | Allowable values                               |
| ----------- | ----------------------- | ---------------------------------------------- |
| `DATE`      | `YYYY-MM-DD`            | `1000-01-01` to `9999-12-31`                   |
| `TIME`      | `HH:MM:SS or HHH:MM:SS` | `-838:59:59` to `838:59:59`                    |
| `DATETIME`  | `YYYY-MM-DD HH:MM:SS`   | `1000-01-01 00:00:00` to `9999-12-31 23:59:59` |
| `TIMESTAMP` | `YYYY-MM-DD HH:MM:SS`   | `1970-01-01 00:00:00` to `2037-12-31 23:59:59` |
| `YEAR`      | `YYYY`                  | `1901` to `2155`                               |

|Data type|Description|
|---|---|
|`date`|Stores a date value in the range from 0001-01-01 (January 1, 1) to  <br>9999-12-31 (December 31, 9999).|
|`time`|Stores time of a day with the accuracy of 100 nanoseconds. Valid values are from 00:00:00.0000000 to 23:59:59.9999999.|
|`datetime`|Stores a combined date and time value with an accuracy of 3.33 milliseconds. Valid date range for `datetime` is from 1753-01-01 (January 1, 1753) to 9999-12-31 (December 31, 9999).|
|`datetime2`|The `datetime2` is an extension of the `datetime` data type that has a larger date range. Valid date range for `datetime2` is from 0001-01-01 (January 1, 1) to 9999-12-31 (December 31, 9999).|
|`smalldatetime`|Stores a combined date and time value with an accuracy of 1 minute. Valid date range for `smalldatetime` is from 1900-01-01 (January 1, 1900) to  <br>2079-06-06 (June 6, 2079).|
|`datetimeoffset`|Same as `datetime2` with the addition of a time zone offset. Default format is `YYYY-MM-DD hh:mm:ss[.nnnnnnn] [{+\|-}hh:mm]`. Valid range for time zone offset is from -14:00 to +14:00.|
|`timestamp`|In SQL Server `timestamp` is the synonym for the `rowversion` data type which automatically generate, unique binary numbers within a database. The `rowversion` is generally used for version-stamping table rows.|

