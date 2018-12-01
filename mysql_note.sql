触发器
DROP TABLE
IF EXISTS goods;

CREATE TABLE
IF NOT EXISTS goods (
	id INT(10) UNSIGNED auto_increment ,
	NAME VARCHAR(255) DEFAULT '',
	count INT(6) UNSIGNED default 20,
	PRIMARY KEY (id)
)ENGINE = INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8; 

CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT '',
  `good_id` int(10) NOT NULL,
  `num` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `good_id` (`good_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


当 操作的(update insert,delete) 表中不存在数据时不会报错

DROP trigger if exists `goods_count`;
DELIMITER ;;
CREATE TRIGGER `goods_count` AFTER insert on `order` for each row 
BEGIN
update goods set count = count - new.num where id = new.good_id;
end 
;;

https://www.cnblogs.com/phpper/p/7587031.html (参考)

auto increment 不论插入数据是否成功主键都会增加1
auto increment 在建表的时候只能放在最后
https://www.cnblogs.com/moss_tan_jun/p/6909565.html (auto increment坑)
http://www.itpub.net/thread-1204834-1-1.html (短索引)

alter table test add index `a`(`a`(3));

drop table if exists `user`;
CREATE table if not exists `user`(
Id int(10)  UNSIGNED AUTO_INCREMENT,
`Name` VARCHAR(255) default '',
CreateDate TIMESTAMP,
PRIMARY key Id(`Id`)
)ENGINE = INNODB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;


drop table if exists `user_log`;
CREATE table if not exists `user_log`(
Id int(10)  UNSIGNED AUTO_INCREMENT,
user_id int(10) not null,
log varchar(255) default '',
PRIMARY key Id (`Id`),
key user_id(user_id)
)ENGINE = INNODB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;


创建trigger 不能用判断是否存在的语法
DROP TRIGGER if EXISTS `user_log`;
DELIMITER ;;
CREATE trigger `user_log` after insert on `user` for EACH ROW
BEGIN
DECLARE str char(50)character set utf8;
DECLARE time char(50)character set utf8;
set str = 'Is Created On ';
set time = new.CreateDate;
 insert into user_log (user_id,log) values(new.id,CONCAT_WS(' : ',str,time));
END ;;
DELIMITER ;









Mysql插入语句的5种写法。

    insert into tablename (id,name) value ('', 'xxx');
    insert into tablename (id,name) values ('', 'xxxxx');
    insert into tablename (id, name) value ('','xxx'),('','xxxxxxx');
    insert into tablename (id, name) values ('','xxx'),('','xxxxxxx');
    insert into tablename set id='id', name='xxxxx';

一般推荐第四种写法，这是SQL标准
在Oracle等其它数据库类型中通用性好
其它几种在Mysql App开发时，有特定的方便之处


mysql 建表时怎么制定不为空和唯一性索引
constraint 

drop table if exists `test_insert`;
CREATE table if not exists `test_insert`(
Id int(10)  UNSIGNED AUTO_INCREMENT,
Type_id int(10) ,
id_card int(10),
`Name` VARCHAR(255) ,
CreateDate TIMESTAMP,
constraint primary key (Id),
constraint UNIQUE (id_card)
UNIQUE key()
)ENGINE = INNODB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;

-- 撤销上一问的unique约束
alter table `test_insert` drop index sid;

-- 给category加 default约束
alter table `test_insert` alter `Name` set default '';

-- 不为空直接在字段后面指定
-- 添加PRIMARY KEY（主键索引） 
ALTER TABLE `table_name` ADD PRIMARY KEY ( `column` ) 
-- 添加UNIQUE(唯一索引) 
ALTER TABLE `table_name` ADD UNIQUE ( `column` ) 
-- 添加INDEX(普通索引) 
ALTER TABLE `table_name` ADD INDEX index_name ( `column` ) 
-- 添加FULLTEXT(全文索引) 
ALTER TABLE `table_name` ADD FULLTEXT ( `column`) 
-- 添加多列索引 联合索引
ALTER TABLE `table_name` ADD INDEX index_name ( `column1`, `column2`, `column3` )








-- mysql 存储引擎的区别：
innodb 不能生成myi myd文件  只能生成ibd文件
（https://zhidao.baidu.com/question/2265554046268817668.html）
(https://blog.csdn.net/hi__study/article/details/53489672)
MySQL 从 .ibd 文件恢复数据
(https://blog.csdn.net/airujingye/article/details/70526943)




千万级别的测试数据 查询其中2百万条
SELECT count(1) from test_insert where id < 2000000;			0.573
SELECT count(1) from test_insert_part where id < 2000000;		0.451

未分区
drop table if exists `test_insert`;
CREATE table if not exists `test_insert`(
Id int(10)  UNSIGNED AUTO_INCREMENT,
`Name` VARCHAR(255) ,
CreateDate TIMESTAMP,
constraint primary key (Id)
)ENGINE = MYISAM AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8;
alter table test_insert alter `Name` set default '';


分区
drop table if exists `test_insert_part`;
CREATE table if not exists `test_insert_part`(
Id int(10)  UNSIGNED AUTO_INCREMENT,
`Name` VARCHAR(255) ,
CreateDate TIMESTAMP,
constraint primary key (Id)
)ENGINE = MYISAM AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8
PARTITION BY RANGE (Id) (
PARTITION p0 VALUES LESS THAN (2000000),  
PARTITION p1 VALUES LESS THAN (4000000) , 
PARTITION p2 VALUES LESS THAN (6000000) ,  
PARTITION p3 VALUES LESS THAN (8000000) ,   
PARTITION p4 VALUES LESS THAN MAXVALUE ); 
alter table test_insert_part alter `Name` set default '';


drop table if exists `test_insert_hash`;
CREATE table if not exists `test_insert_hash`(
Id int(10)  UNSIGNED AUTO_INCREMENT,
`Name` VARCHAR(255) ,
CreateDate TIMESTAMP,
constraint primary key (Id)
)ENGINE = MYISAM AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8
PARTITION BY HASH(Id)
PARTITIONS 4;
-- 分成4个分区， 主键每次自增 叠加4  依次类推



drop table if exists `test_insert_hash_1`;
CREATE table if not exists `test_insert_hash_1`(
Id int(10)  UNSIGNED AUTO_INCREMENT,
`Name` VARCHAR(255) ,
CreateDate TIMESTAMP,
constraint primary key (Id)
)ENGINE = MYISAM AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8
PARTITION BY RANGE (Id) (
PARTITION t0 VALUES LESS THAN (1000),  
PARTITION t1 VALUES LESS THAN (2000),   
PARTITION t2 VALUES LESS THAN MAXVALUE );
alter table test_insert_hash_1 alter `Name` set default '';
-- myisam 删除分区物理文件 不会印象记录条数


【分区详解】（https://blog.csdn.net/youzhouliu/article/details/52796819）
[分区种类](http://blog.51yip.com/mysql/1013.html)
1. range 分区 区间连续 less than
2. list 分区 指定条件  in 
3. HASH分区  有规律

ALERT TABLE users DROP PARTITION p0; 
ALTER table test_insert_hash DROP PARTITION p3;
[Err] 1512 - DROP PARTITION can only be used on RANGE/LIST partitions




-- 存储过程插入数据：
drop procedure if exists `insert_test_data`;
delimiter;;
create procedure  `insert_test_data`()
	begin
	DECLARE rounds int default 20;
	DECLARE i int default 0;
	DECLARE j int default 0;
	DECLARE str varchar(255) default '';

	WHILE i < rounds
	DO
		set str = MD5(CONCAT("'",i,j,'test',"'"));
		insert into test_insert (`name`) values (str);
		set i = i+1;
	END WHILE;
 
	end
;;
delimiter;
CALL insert_test_data();



procedure，function

-- 函数参数不能和字段名是一样的

-- 函数参数不能指定 in out 参数类型
drop function if exists `Test_Function`;
DELIMITER ;;  
CREATE FUNCTION Test_Function(uid INT)   RETURNS VARCHAR(300)  
BEGIN  
    RETURN(SELECT CONCAT('name:',name,'---','date: ',CREATEdate) FROM `user` WHERE uid=id);  
END;;  
DELIMITER ;  



mysql 批量操作(https://blog.csdn.net/xiakepan/article/details/52703189)
mysql 存储过程中用变量做表名(http://wb8206656.iteye.com/blog/2225162)
存储过程中 表名 字段名 函数名 trigger 名 变量格式set @sqlStr
DROP PROCEDURE if EXISTS use_dynamic_tablename;
delimiter ;;
CREATE PROCEDURE use_dynamic_tablename (in d_name VARCHAR (255))
BEGIN

-- SET @SqlCmd = 'SELECT * FROM ? '; -- 必须用concat拼接sql
-- PREPARE stmt FROM @SqlCmd;  
-- SET @a = d_name;    
-- EXECUTE stmt USING @a;   

set @temp1=d_name;
set @sqlStr=CONCAT('select * from ',@temp1);
PREPARE stmt from @sqlStr;
EXECUTE stmt; 
DEALLOCATE PREPARE stmt; 
   
END;
;;
delimiter ;
CALL use_dynamic_tablename ("biaoa");




Mysql Prepare：
(https://www.cnblogs.com/zhchoutai/p/7172115.html)
PREPARE statement_name FROM sql_text /*定义*/   
EXECUTE statement_name [USING variable [,variable...]] /*运行预处理语句*/   
DEALLOCATE PREPARE statement_name /*删除定义*/  


-- mysql 双循环 巨坑（http://blog.sina.com.cn/s/blog_8bffcb9401013usb.html）
 -- 内循环的下标 必须在外循环初始化

 -- -- 存储过程批量插入数据 测试代码
 DROP PROCEDURE if EXISTS insert_batch_data;

delimiter ;;

CREATE PROCEDURE insert_batch_data ()
BEGIN

DECLARE rounds int DEFAULT 5;
DECLARE records int DEFAULT 3;
DECLARE i int DEFAULT 1;
DECLARE j int DEFAULT 1;

WHILE (i <= rounds) DO

	WHILE (j <= records) DO
	insert into test_insert (`name`) VALUES (CONCAT(i,j,'test'));
	SET j = j+1;
-- select j;
	END WHILE;
    SET j = 1;
	set i = i +1;
-- select i；
END WHILE;

END;

;;
delimiter ;

CALL insert_batch_data ();
 -- end

 -- repeat 双循环插入 （有坑） （需要初始化内循环的值）
DROP PROCEDURE if EXISTS insert_batch_data;
delimiter ;;

CREATE PROCEDURE insert_batch_data ()
BEGIN

DECLARE rounds int DEFAULT 5;
DECLARE records int DEFAULT 3;
DECLARE i int DEFAULT 1;
DECLARE j int DEFAULT 1;

repeat 
		WHILE (j <= records) DO
		insert into test_insert (`name`) VALUES (CONCAT(i,j,'test'));
		SET j = j+1;
		END WHILE;

    set i = i + 1;
	set j = 1;
	until i >= rounds
end repeat;

END;

;;
delimiter ;


CALL insert_batch_data ();
-- loop 双循环插入 (有坑)
DROP PROCEDURE IF EXISTS insert_batch_data;
delimiter ;;

CREATE PROCEDURE insert_batch_data ()
BEGIN

DECLARE rounds INT DEFAULT 5 ;
DECLARE records INT DEFAULT 3 ;
DECLARE i INT DEFAULT 1 ;
DECLARE j INT DEFAULT 1 ; 

lp1 : LOOP
	SET i = i + 1 ; 

	lp2 : LOOP
		insert into test_insert (`name`) VALUES (CONCAT(i,j,'test'));
		SET j = j + 1 ;
		IF j > records THEN
			LEAVE lp2 ;
		END IF;
	END LOOP;

IF i > rounds THEN
	LEAVE lp1 ;
END IF ;
END LOOP ;

END ;
;;
delimiter ;


CALL insert_batch_data ();



 
 
 -- 与php 代码效率对比
 （INNODB）
 -- php 代码 插入 普通表1000w 条数据  耗时 817.1185 s
 -- 存储过程 1116.004s
 
 (MYISAM)
 -- php 代码 插入 普通表1000w 条数据  耗时 51.5498  s
 -- 存储过程 581.946s
 
 
 -- 存储过程 调用 函数 预处理批量插入数据
 
 --  第一步 创建函数 拼接value sql
DROP FUNCTION if EXISTS concat_batch_value;
delimiter ;;
CREATE FUNCTION concat_batch_value ( sum int,  param VARCHAR(255)) RETURNS text  
BEGIN
DECLARE j int DEFAULT 0;
DECLARE insert_val VARCHAR(255);
DECLARE insert_total_val text DEFAULT '';

	WHILE (j < sum) DO
	set insert_val = CONCAT("('",md5(CONCAT(param,j)),"'),");
	set insert_total_val = CONCAT(insert_total_val,insert_val);
	
	set insert_val = '';
	SET j = j+1;
	
	END WHILE;
RETURN insert_total_val;
END;
;;
delimiter ;

 -- 第二步 创建 单循环存储过程
DROP PROCEDURE if EXISTS insert_batch_data;
delimiter ;;
CREATE PROCEDURE insert_batch_data (IN tableName VARCHAR (255),in rounds int,in records int)
BEGIN

DECLARE tbname varchar(50) DEFAULT  '';
DECLARE exec_stmt_sql text DEFAULT '';
DECLARE insert_total_val text DEFAULT '';

DECLARE i int DEFAULT 0;

SET @handle_table = tableName;
WHILE (i < rounds) DO
	set insert_total_val = concat_batch_value(records,i);
	set @exec_sql = left(insert_total_val,length(insert_total_val)-1);
	SET exec_stmt_sql = CONCAT("insert into ", @handle_table, "(`name`) values ", @exec_sql);
	SET @fromSql = exec_stmt_sql;

	PREPARE stmt FROM @fromSql; 
	EXECUTE stmt ;
	DEALLOCATE PREPARE stmt;

	set insert_total_val = "";
	SET exec_stmt_sql = "";
	
	set i = i +1;   
                
END WHILE;

END;

;;
delimiter ;
CALL insert_batch_data ('test_insert',20000,500);





 -- 存储过程预处理查询
DROP PROCEDURE IF EXISTS `test_prepare`;

delimiter ;;

CREATE PROCEDURE `test_prepare` (IN tableName VARCHAR (255),IN p_id INT)
BEGIN
DECLARE tbname varchar(50) DEFAULT  '';
DECLARE exec_sql text DEFAULT '';

SET @handle_table = tableName;
SET @handle_table_id = p_id;

SET exec_sql = CONCAT('select * from  ',@handle_table,' where id = ' ,@handle_table_id);
SET @fromSql = exec_sql;

PREPARE stmt FROM @fromSql; -- 只能from 一个变量或者带有问号的预处理语句 不能是declare 的变量 
-- PREPARE stmt FROM  "select * from test_insert where id = ?";   -- table name  不能使用问号预处理
EXECUTE stmt;
-- EXECUTE stmt USING @handle_table_id; 只能using @变量
DEALLOCATE PREPARE stmt;

SELECT exec_sql;
END;

;;

delimiter ;

CALL test_prepare ('test_insert', 1);



-- 存储过程预处理插入数据
DROP PROCEDURE if EXISTS insert_test_data;

delimiter ;;

CREATE PROCEDURE insert_test_data (IN tableName VARCHAR (255))
BEGIN
DECLARE tbname varchar(50) DEFAULT  '';
DECLARE exec_sql text DEFAULT '';

SET @handle_table = tableName;
SET @str  = "('aaaaaatets')";

-- SET @str2  = "uduududududu"; -- 用问号做参数的时候不需要用括号

SET exec_sql = CONCAT("insert into ", @handle_table, "(`name`) values ", @str);

-- SET exec_sql = CONCAT("insert into ", @handle_table, "(`name`) values (?)");
SET @fromSql = exec_sql;

PREPARE stmt FROM @fromSql; 
-- PREPARE stmt FROM  "select * from ? where id = ?";
EXECUTE stmt ;

-- EXECUTE stmt using @str2;
DEALLOCATE PREPARE stmt;
END;

;;
delimiter ;
CALL insert_test_data ('test_insert');



-- 存储过程预处理 批量插入  数据
 -- prepare 巨坑 双循环 插入数据 次数变多
DROP PROCEDURE if EXISTS insert_batch_data;

delimiter ;;

CREATE PROCEDURE insert_batch_data (IN tableName VARCHAR (255))
BEGIN
DECLARE tbname varchar(50) DEFAULT  '';

DECLARE exec_stmt_sql text DEFAULT '';

DECLARE insert_val VARCHAR(255);
DECLARE insert_total_val text DEFAULT '';

DECLARE rounds int DEFAULT 5;
DECLARE records int DEFAULT 3;
DECLARE i int DEFAULT 0;
DECLARE j int DEFAULT 0;

SET @handle_table = tableName;

WHILE (i < rounds) DO

	WHILE (j < records) DO
	set insert_val = CONCAT("('",CONCAT(i,j,'test'),"'),");
	set insert_total_val = CONCAT(insert_total_val,insert_val);
	
	set insert_val = '';
	SET j = j+1;
	
	END WHILE;

	set @exec_sql = left(insert_total_val,length(insert_total_val)-1);
	SET exec_stmt_sql = CONCAT("insert into ", @handle_table, "(`name`) values ", @exec_sql);
	SET @fromSql = exec_stmt_sql;

	PREPARE stmt FROM @fromSql; 
	EXECUTE stmt ;
	DEALLOCATE PREPARE stmt;
	
	set i = i +1;
	set j=0;     
                
	 -- set insert_total_val = '';
	 -- set exec_stmt_sql = '';
END WHILE;

END;

;;
delimiter ;

CALL insert_batch_data ('test_insert');



 

分为 in out inout 三种类型的参数

-- IN参数的值必须在调用存储过程时指定，在存储过程中修改该参数的值不能被返回，为默认值
-- OUT:该值可在存储过程内部被改变，并可返回
-- NOUT:调用时指定，并且可被改变和返回

drop PROCEDURE if EXISTS inout_param;
DELIMITER //
  CREATE PROCEDURE inout_param(INOUT p_inout int)
    BEGIN
      SELECT p_inout;
      SET p_inout=2;
      SELECT p_inout;
    END;
    //
DELIMITER ;
#调用
SET @p_inout=44;
CALL inout_param(@p_inout) ;
SELECT @p_inout;
-- 44  2    2

存储过程 简介 (https://www.cnblogs.com/mark-chan/p/5384139.html)



drop procedure if exists `insert_test_data`;
delimiter;;
create procedure  `insert_test_data`(in tableName VARCHAR(50))
	begin
	end
;;
delimiter;


 


拼接sql 的做法效率高的主要原因是合并后日志量
（MySQL的binlog和innodb的事务让日志）减少了
降低日志刷盘的数据量和频率，从而提高效率
通过合并SQL语句，同时也能减少SQL语句解析的次数，减少网络传输的IO







mysql global 变量

max_allowed_packet 设置sql 语句长度

1406 - Data too long for column 'Name' at row 1
char(4) 只接受长度小于4的字符串

 

mysql replace
[详解]（https://www.cnblogs.com/wajika/p/6680911.html）


mysql 索引



mysql explain 用法
详解 （https://www.cnblogs.com/yycc/p/7338894.html）
EXPLAIN PARTITIONS
SELECT count(1) from test_insert_part_1 where id < 2000000;

SHOW CREATE TABLE test_insert_part_1 （查看建表语句）

explian 各项含义

select_type
    SIMPLE:简单SELECT(不使用UNION或子查询)
    PRIMARY:最外面的SELECT
    UNION:UNION中的第二个或后面的SELECT语句
    DEPENDENT UNION:UNION中的第二个或后面的SELECT语句,取决于外面的查询
    UNION RESULT:UNION 的结果
    SUBQUERY:子查询中的第一个SELECT
    DEPENDENT SUBQUERY:子查询中的第一个SELECT,取决于外面的查询
    DERIVED:导出表的SELECT(FROM子句的子查询)

table 	
	输出的行所引用的表
	
type 
    system:表仅有一行(=系统表)。这是const联接类型的一个特例。
		   （查子查询返回的仅仅一条数据）
    const:表最多有一个匹配行,它将在查询开始时被读取。
		  因为仅有一行,在这行的列值可被优化器剩余部分认为是常数。const表很快,因为它们只读取一次!
		  （where id = 2;）
    eq_ref:对于每个来自于前面的表的行组合,
		   从该表中读取一行。这可能是最好的联接类型,除了const类型。
		   
    ref:对于每个来自于前面的表的行组合,所有有匹配索引值的行将从这张表中读取。
    ref_or_null:该联接类型如同ref,但是添加了MySQL可以专门搜索包含NULL值的行。
    index_merge:该联接类型表示使用了索引合并优化方法。
    unique_subquery:该类型替换了下面形式的IN子查询的ref: value IN (SELECT primary_key FROM single_table WHERE some_expr) unique_subquery是一个索引查找函数,可以完全替换子查询,效率更高。
    index_subquery:该联接类型类似于unique_subquery。可以替换IN子查询,但只适合下列形式的子查询中的非唯一索引: value IN (SELECT key_column FROM single_table WHERE some_expr)
    range:只检索给定范围的行,使用一个索引来选择行。
    index:该联接类型与ALL相同,除了只有索引树被扫描。这通常比ALL快,因为索引文件通常比数据文件小。
    ALL:对于每个来自于先前的表的行组合,进行完整的表扫描。
	
possible_keys 	
	指出MySQL能使用哪个索引在该表中找到行
	
key 	
	显示MySQL实际决定使用的键(索引)。如果没有选择索引,键是NULL。
	
key_len 	
	显示MySQL决定使用的键长度。如果键是NULL,则长度为NULL。
	
ref 	
	显示使用哪个列或常数与key一起从表中选择行。
	
rows 	
	显示MySQL认为它执行查询时必须检查的行数。多行之间的数据相乘可以估算要处理的行数。
	
filtered 	
	显示了通过条件过滤出的行数的百分比估计值。
	
Extra
    Distinct:MySQL发现第1个匹配行后,停止为当前的行组合搜索更多的行。
    Not exists:MySQL能够对查询进行LEFT JOIN优化
		,发现1个匹配LEFT JOIN标准的行后,不再为前面的的行组合在该表内检查更多的行。
    range checked for each record (index map: #):
		MySQL没有发现好的可以使用的索引,但发现如果来自前面的表的列值已知,可能部分索引可以使用。
    Using filesort:MySQL需要额外的一次传递,以找出如何按排序顺序检索行。
    Using index:从只使用索引树中的信息而不需要进一步搜索读取实际的行来检索表中的列信息。 读取的列就是索引列
    Using temporary:为了解决查询,MySQL需要创建一个临时表来容纳结果。
    Using where:WHERE 子句用于限制哪一个行匹配下一个表或发送到客户。
    Using sort_union(...), Using union(...), Using intersect(...):
		这些函数说明如何为index_merge联接类型合并索引扫描。
    Using index for group-by:类似于访问表的Using index方式,Using index for group-by表示
		MySQL发现了一个索引,可以用来查 询GROUP BY或DISTINCT查询的所有列,而不要额外搜索硬盘访问实际的表。

	



mysql> show index from tblname;
mysql> show keys from tblname;


mysql DBA 面试题
（https://blog.csdn.net/mchdba/article/details/13505701）

win 7下面搭建了一个免安装版5.7.6版本。
要用mysqld --initialize-insecure --user=mysql命令生成data文件夹 


subl2="‪D:\Program Files\Sublime Text 3\sublime_text.exe" $1 -new_console:s75H




SHOW VARIABLES 参数



	
MySQL中optimize优化表
https://blog.csdn.net/hsd2012/article/details/51485250

index

索引是表的目录，在查找内容之前可以先在目录中查找索引位置，以此快速定位查询数据。对于索引，会保存在额外的文件中。

索引，是数据库中专门用于帮助用户快速查询数据的一种数据结构。类似于字典中的目录，查找字典内容时可以根据目录查找到数据的存放位置，然后直接获取即可。

索引由数据库中一列或多列组合而成，其作用是提高对表中数据的查询速度
索引的优点是可以提高检索数据的速度
索引的缺点是创建和维护索引需要耗费时间
索引可以提高查询速度，会减慢写入速度

1.普通索引
2.唯一索引
3.全文索引
4.单列索引
5.多列索引
6.空间索引
7.主键索引
8.组合索引

普通索引：仅加速查询
唯一索引：加速查询 + 列值唯一（可以有null）
主键索引：加速查询 + 列值唯一 +　表中只有一个（不可以有null）
组合索引：多列值组成一个索引，专门用于组合搜索，其效率大于索引合并
exzample:
        CREATE TABLE mytable( ID INT NOT NULL, username VARCHAR(16) NOT NULL, city VARCHAR(50) NOT NULL, age INT NOT NULL );
        为了进一步榨取MySQL的效率，就要考虑建立组合索引。就是将 name, city, age建到一个索引里：
        ALTER TABLE mytable ADD INDEX name_city_age (name(10),city,age);
        建表时，usernname长度为 16，这里用 10。这是因为一般情况下名字的长度不会超过10，这样会加速索引查询速度，还会减少索引文件的大小，提高INSERT的更新速度。
        如果分别在 usernname，city，age上建立单列索引，让该表有3个单列索引，查询时和上述的组合索引效率也会大不一样，远远低于我们的组合索引。
        虽然此时有了三个索引，但MySQL只能用到其中的那个它认为似乎是最有效率的单列索引。
        建立这样的组合索引，其实是相当于分别建立了下面三组组合索引：
 　　   usernname,city,age      usernname,city      usernname
        为什么没有 city，age这样的组合索引呢?这是因为MySQL组合索引“最左前缀”的结果。简单的理解就是只从最左面的开始组合。
        并不是只要包含这三列的查询都会用到该组合索引，下面的几个SQL就会用到这个组合索引：
  　　  SELECT * FROM mytable WHREE username="admin" AND city="郑州" 　　SELECT * FROM mytable WHREE username="admin"
        而下面几个则不会用到：
  　　  SELECT * FROM mytable WHREE age=20 AND city="郑州" 　　SELECT * FROM mytable WHREE city="郑州"
  
  
        referto (https://www.cnblogs.com/farmer-cabbage/p/5793589.html)

全文索引：对文本的内容进行分词，进行搜索
        CREATE TABLE `article` (
          `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
          `title` varchar(200) DEFAULT NULL,
          `content` text,
          PRIMARY KEY (`id`),
          FULLTEXT KEY `title` (`title`,`content`)
        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
        ALTER TABLE article ADD FULLTEXT INDEX fulltext_article(title,content);

        SELECT * FROM article WHERE MATCH(title,content) AGAINST ('str');
        referto (https://www.cnblogs.com/zhouguowei/p/5216316.html)
        

索引合并，使用多个单列索引组合搜索
覆盖索引，select的数据列只用从索引中就能够取得，不必读取数据行，换句话说查询列要被所建的索引覆盖

强制使用索引
     如果在 where子句中使用参数，也会导致全表扫描。因为SQL只有在运行时才会解析局部变量
     但优化程序不能将访问计划的选择推迟到运行时；它必须在编译时进行选择。
     然而，如果在编译时建立访问计划，变量的值还是未知的，因而无法作为索引选择的输入项。如下面语句将进行全表扫描：
     select id from t where num=@num
     可以改为强制查询使用索引：
     select id from t with(index(索引名)) where num=@num
     
用 exists代替 in是一个好的选择：
     select num from a where num in(select num from b)
     用下面的语句替换：
     select num from a where exists(select 1 from b where num=a.num)

https://blog.csdn.net/liaodehong/article/details/52190223 详细

https://blog.csdn.net/ren_273086429/article/details/52582612 百万数据 索引优化






https://blog.csdn.net/qq_17045385/article/details/79054961 explain 用法

EXPLAIN


select_type ：
    1.SIMPLE：最简单的SELECT查询，没有使用UNION或子查询
    2.PRIMARY：在嵌套的查询中是最外层的SELECT语句，在UNION查询中是最前面的SELECT语句
        explain select zipcode from (select * from people a) b;
        explain select * from people where zipcode = 100000 union select * from people where zipcode = 200000;
    3.UNION：UNION中第二个以及后面的SELECT语句
    4.DERIVED：派生表SELECT语句中FROM子句中的SELECT语句
        explain select zipcode from (select * from people a) b;
    5.UNION RESULT：一个UNION查询的结果
    6.DEPENDENT UNION：顾名思义，首先需要满足UNION的条件，及UNION中第二个以及后面的SELECT语句，同时该语句依赖外部的查询。
        explain select * from people where id in  (select id from people where zipcode = 100000 union select id from people where zipcode = 200000 );
    7.SUBQUERY：子查询中第一个SELECT语句。
        explain select * from people  where id =  (select id from people where zipcode = 100000);
      
      
table ：
    显示的这一行信息是关于哪一张表的。有时候并不是真正的表名。
    explain select * from (select * from (select * from people a) b ) c;
    可以看到如果指定了别名就显示的别名。
    <derivedN>N就是id值，指该id值对应的那一步操作的结果。
    还有<unionM,N>这种类型，出现在UNION语句中。
    MySQL对待这些表和普通表一样，但是这些“临时表”是没有任何索引的。
    
    
type
    type列是用来说明表与表之间是如何进行关联操作的，有没有使用索引。MySQL中“关联”一词比一般意义上的要宽泛，
    MySQL认为任何一次查询都是一次“关联”，并不仅仅是一个查询需要两张表才叫关联，所以也可以理解MySQL是如何访问表的。
    
    1. const：当确定最多只会有一行匹配的时候，MySQL优化器会在查询前读取它而且只读取一次，因此非常快。const只会用在将常量和主键或唯一索引进行比较时，而且是比较所有的索引字段
        EXPLAIN  SELECT id from system_a where id = 1
    2. system 这是const连接类型的一种特例，表仅有一行满足条件。
        EXPLAIN  SELECT * from (SELECT id from system_a where id = 1) a
    3. eq_ref 唯一性索引扫描，对于每个索引键，表中只有一条记录与之匹配。 常见于主键或唯一索引扫描。eq_ref类型是除了const外最好的连接类型。 
        explain SELECT * from definesymbol a,systemsetting b where a.tablename = b.DefineSymbol
    4. ref 非唯一性索引扫描，返回匹配某个单独值的所有行。常见于使用非唯一索引即唯一索引的非唯一前缀进行的查找。
        这个类型跟eq_ref不同的是，它用在关联操作只使用了索引的最左前缀，或者索引不是UNIQUE和PRIMARY KEY。ref可以用于使用=或<=>操作符的带索引的列。    
        explain SELECT * from contract a  where a.ContractNumber ='1'
        EXPLAIN SELECT * from contract where   ContractNumber = 'aa' and CustomerID = 33  ;
    5. fulltext
        链接是使用全文索引进行的。一般我们用到的索引都是B树，这里就不举例说明了。
        EXPLAIN SELECT * FROM article WHERE MATCH(title,content) AGAINST ('test');
    6. ref_or_null
        该类型和ref类似。但是MySQL会做一个额外的搜索包含NULL列的操作。在解决子查询中经常使用该联接类型的优化。
        explain SELECT * from contract a  where a.ContractNumber ='1' or a.ContractNumber is null
    7. range
        只检索给定范围的行，使用一个索引来选择行。key列显示使用了哪个索引。key_len包含所使用索引的最长关键元素。
        在该类型中ref列为NULL。当使用=、<>、>、>=、<、<=、IS NULL、<=>、BETWEEN或者IN操作符，用常量比较关键字列时，可以使用range。
        explain select * from contract where id=1 or id=2;
        explain select * from contract where id>1;
        explain select * from contract where id in (1,2);
        explain select * from contract where StartDate between '2004-10-18' and '2004-10-28';
        explain select * from contract where MonthlyValue = 593 or MonthlyValue = 5935;(如果查询字段不包含索引type = ALL)
    8. index_merge：表示查询使用了两个以上的索引，最后取交集或者并集，常见and ，or的条件使用了不同的索引
        官方排序这个在ref_or_null之后，但是实际上由于要读取所个索引，性能可能大部分时间都不如range  
        EXPLAIN SELECT * from contract where ContractNumber = 'aa' or CustomerID = 11792512  ;        
    9. index
        该联接类型与ALL相同，除了只有索引树被扫描。这通常比ALL快，因为索引文件通常比数据文件小。这个类型通常的作用是告诉我们查询是否使用索引进行排序操作。
        按索引扫描表，虽然还是全表扫描，但优点是索引是有序的。index与ALL区别为index类型只遍历索引树。
    10. ALL
        最慢的一种方式，即全表扫描。

   
EXPLAIN 
SELECT * from contract where ContractNumber like '%aa';     all
EXPLAIN 
SELECT * from contract where ContractNumber like '%aa%';    all
EXPLAIN 
SELECT * from contract where ContractNumber like 'aa%';     range

-- 字符串与数字比较不使用索引;
CREATE TABLE `a` (`a` char(10));
EXPLAIN SELECT * FROM `a` WHERE `a`="1" -- 走索引
EXPLAIN SELECT * FROM `a` WHERE `a`=1 -- 不走索引

   
EXPLAIN 对比
SELECT count(1) from oli2ss12detail_p where versionno = 'CN20160831_P';
1	SIMPLE	oli2ss12detail_p	ref VersionNO	VersionNO	152	const	118976	Using where; Using index

EXPLAIN
SELECT count(if(versionno = 'CN20160831_P',1,null)) from oli2ss12detail_p;
1	SIMPLE	oli2ss12detail_p	index   null	VersionNO	152 null	1849409	Using index


   
mysql 查看所有表的建表语句

select table_name 
from information_schema.tables 
where table_schema='mydb'

mysql information schema
(https://blog.csdn.net/jimmy_zrone/article/details/50922356) 



性能优化：
mysql中OPTIMIZE TABLE的作用及使用
(https://www.cnblogs.com/jimmy-muyuan/p/5874410.html)








