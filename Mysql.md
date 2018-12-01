# Mysql >>

### 语法
- 在利用同表数据 update同表内容时 必须嵌套一层子查询
- 子查询可以在where clause 用外层查询的表数据 而不可以在on clause 使用
- [Err] 1345 - EXPLAIN/SHOW can not be issued; lacking privileges for underlying table 没有权限

### 优化：
	<?php
		// 查询缓存不开启  NOW() 和 RAND() 或是其它的诸如此类的SQL函数都不会开启查询缓存
		$r = mysql_query("SELECT username FROM user WHERE signup_date >= CURDATE()"); 
		 // 开启查询缓存 
		$today = date("Y-m-d"); 
		$r = mysql_query("SELECT username FROM user WHERE signup_date >= '$today'"); 
	?>	
	
- 在Join表的时候使用相当类型的例，并将其索引
- 如果你的应用程序有很多 JOIN 查询，你应该确认两个表中Join的字段是被建过索引的。这样，MySQL内部会启动为你优化Join的SQL语句的机制。而且，这些被用来Join的字段，应该是相同的类型的。
  例如：如果你要把 DECIMAL 字段和一个 INT 字段Join在一起，MySQL就无法使用它们的索引。对于那些STRING类型，还需要有相同的字符集才行。(两个表的字符集有可能不一样)
- 用create or replace代替alter view，速度快
- 如果视图的字段跟原表完全一样，可以用select *代替select那么多字段

### Tips
- `SELECT PASSWORD("aaaa");` `SELECT OLD_PASSWORD("aaaa");` mysql.ini old_passwords=1/0
- max_allowed_packet 
- 通过测试发现，count( 1)中，1只是一个固定值，没有什么具体的意义，更不是指第一个列，也可以看成一个虚值，count(*)和count(1)操作会统计表中列的行数，包括NULL列，count(col)操作会统计指定列的行数，不包括NULL值。count(*) 和count(1) 是没有区别的，而count(col) 是有区别的
- 内层三个union all的查询 每个查询单独执行都非常快,时间0.01 sec左右, 但是这个整体的SQL居然需要0.7s.. 查阅资料发现,有如下的情况,MySQL会直接使用磁盘临时表
  - 1.表中包含了BLOB和TEXT字段（MEMORY引擎不支持这两种字段）
  - 2.group by和distinct子句中的有超过512字节的字段
  - 3.UNION以及UNION ALL语句中，如果SELECT子句中包含了超过512（对于binary string是512字节，对于character是512个字符）的字段。
- [mysql 启动停止](https://blog.csdn.net/ybhjx/article/details/50833420)

### 如何给大表添加字段
	
```sql	
create table xx_order_bak like xx_order;        
alter table xx_order_bak add column `unit` int(10) DEFAULT 1;  

INSERT INTO xx_order_bak(`id`, `create_date`, `modify_date`, `address`, `amount_paid`)  select * from xx_order;  

rename table xx_order to xx_order_bak1;  
rename table xx_order_bak to xx_order;
```

### DBA 面试

##### mysql中myisam与innodb的区别

- InnoDB：
  - 支持事务处理等
  - 不加锁读取
  - 支持外键
  - 支持行锁
  - 如果没有设定主键或者非空唯一索引，就会自动生成一个6字节的主键(用户不可见)，数据是主索引的一部分，附加索引保存的是主索引的值
  - 以主键为索引的查询更快
  - 不支持FULLTEXT类型的索引
  - 没有保存表的总行数，如果使用select count(*) from table；就会遍历整个表，消耗相当大，但是在加了wehre条件后，myisam和innodb处理的方式都一样。
  - DELETE 从性能上InnoDB更优，但DELETE FROM table时，InnoDB不会重新建立表，而是一行一行的删除，在innodb上如果要清空保存有大量数据的表，最好使用truncate table这个命令
  - InnoDB 把数据和索引存放在表空间里面 ibd 文件 
  - InnoDB中必须包含AUTO_INCREMENT类型字段的索引
  - 表格很难被压缩

- MyISAM：
  - 不支持事务，回滚将造成不完全回滚，不具有原子性
  - 不支持外键
  - 支持全文搜索
  - 保存有表的总行数，如果select count(*) from table;会直接取出出该值
  - 普通索引的查询快于Innodb
  - 允许没有任何索引和主键的表存在，索引都是保存行的地址
  - DELETE 表时，先drop表，然后重建表
  - MyISAM 表被存放在三个文件 。frm 文件存放表格定义。 数据文件是MYD (MYData) 。 索引文件是MYI (MYIndex)引伸
  - MyISAM中可以使AUTO_INCREMENT类型字段建立联合索引 表格可以被压缩

- 选择：
  - 因为MyISAM相对简单所以在效率上要优于InnoDB.如果系统读多，写少。对原子性要求低。那么MyISAM最好的选择。且MyISAM恢复速度快。可直接用备份覆盖恢复。
如果系统读少，写多的时候，尤其是并发写入高的时候。InnoDB就是首选了。

##### 字段

- VARCHAR与CHAR的区别
  - CHAR列的长度固定为创建表时声明的长度。长度可以为从0到255的任何值。当保存CHAR值时，在它们的右边填充空格以达到指定的长度。当检索到CHAR值时，尾部的空格被删除掉。在存储或检索过程中不进行大小写转换。
  - 数字表示最大存储30个字符
  - INT(6),6即是其宽度指示器,该宽度指示器并不会影响int列存储字段的大小,也就是说,超过6位它不会自动截取,依然会存储,只有超过它本身的存储范围才会截取;此处宽度指示器的作用在于该字段是否有zerofill,如果有就未满足6位的部分就会用0来填充
  -
```sql
DROP table if EXISTS `order`;
CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(5) DEFAULT '',
  `good_id` int(10) NOT NULL,
  `num` int(4) ZEROFILL,
  PRIMARY KEY (`id`),
  KEY `good_id` (`good_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- varchar 会自动截取
insert `order` (`NAME`,good_id, num) VALUES ("fassssssssssssssssssssssssssssssssss",20,null);

SELECT * from `order`;
``` 

##### 事务隔离 & 创建用户

- 命令行进入 `mysql -hlocalhost -uroot -p` `use test，show tables;`
-  `select PASSWORD("1234");` `select OLD_PASSWORD("1234");`
- mysql> grant all privileges on mydb.* to deli@"localhost" identified by '1234';
- mysql> grant all privileges on mydb.* to deli identified by '1234';
- 需要输入2遍
- 事务隔离
  - READ-UNCOMMITTED  一个事务读取到另一个事务已经改变 但是没提交 的数据
  - READ-COMMITTED    一个事务读取到另一个事务已经改变并且提交了的数据，但是在这个事务中重复某次查询操作的时候，可能会出现不一样的结果
  - REPEATABLE-READ   同第二种情况，但是该事务在没有commit之前读取的同一个数据不会发生任何变化 
  - SERIALIZABLE      在一个autocommit = 0 的事务中 读取另一个开启事务并修改 但是不提交的数据， 会发生行锁， (用索引的情况下)
- MyISAM 引擎autocommit 一直处于开启状态

##### table info

- `show table status from mydb;` ` like 00`
- `use infomation_schema` `select table_catalog from tables where table_schema='mydb' and table_name='acount';`
- `select * from information_schema.`TABLES` where TABLE_SCHEMA = 'tkchina'`查看数据库大小

##### 数据库范式
- 属性原子性 （冗余属性） 中国上海 中国北京
- 非键字段必须依赖于键字段 要求实体的属性完全依赖于主关键字 （不能有冗余字段或者无意义字段） （联系人编号  联系人省份证）
- 任何非主属性不依赖于其它非主属性 在员工信息表中列出部门编号后就不能再将部门名称、部门简介等与部门有关的信息再加入员工信息表中

##### 不会用到索引的情况
- 尽量减少like，但不是绝对不可用，”xxxx%” 是可以用到索引的，
- 除了like，以下操作符也可用到索引：，BETWEEN，IN,   <，<=，=，>，>=
- <>，not in ，!=则不行  NOT IN可以NOT EXISTS代替

- 如果条件中有or，即使其中有部分条件带索引也不会使用 必须所有条件都是用索引
- 存在索引列的数据类型隐形转换，则用不上索引，比如列类型是字符串，那一定要在条件中将数据使用引号引用起来,否则不使用索引
-  where 子句里对索引列上有数学运算，对有索引列使用函数 用不上索引
  - `EXPLAIN select * from traveldistance_3 where id+content = 5002023`
- 索引不会包含有NULL值的列 只要列中包含有NULL值都将不会被包含在索引中，复合索引中只要有一列含有NULL值，那么这一列对于此复合索引就是无效的。所以我们在数据库设计时不要让字段的默认值为NULL。
  - `EXPLAIN select * from traveldistance_3 where contentid  = 312431 and runid = null`


##### EXISTS test
```sql
DROP TABLE if EXISTS biaoa;
CREATE TABLE `biaoa` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
SELECT * from biaoa;


DROP TABLE if EXISTS biaob;
CREATE TABLE `biaob` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Aid` int(11) default null,
  `Name` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
SELECT * from biaob;
alter table biaob add index Aid(Aid);

EXPLAIN
SELECT a.id,a.`name` FROM biaoa a WHERE not EXISTS (SELECT * FROM biaob b WHERE  b.Aid = a.id) 
```

##### 数据碎片

- 对于那些不支持optimizi table 的存储引擎，只需要 `alter table xxx engine = <xxx.engine>`
- alter如果很慢，优化一下my.cnf，[mysqld]加上以下内容，并重新加载。innodb_buffer_pool_size=1G innodb_file_io_threads=4 innodb_file_io_threads常规配置，小于等CPU核数。innodb_buffer_pool_size小于等于物理内存的1/2，原则上够用就好。


##### count 优化
- 

```sql
EXPLAIN 
select count(*) from city where id >100;

EXPLAIN 
select (SELECT count(*) from city) - count(*) from city where id <= 100;
```

##### limit 优化
- 第四种查询有个弊端，如果有人改动了这张表的话  id 不准确
- 当一个查询语句偏移量offset很大的时候，如select * from table limit 10000,10 , 最好不要直接使用limit，而是先获取到offset的id后，再直接使用limit size来获取数据。效果会好很多。
- 
```sql 
SELECT * from traveldistance_3 limit 50, 100; -- 0.001s  type all
SELECT * from traveldistance_3 limit 1500000, 100; -- 1.825s type all
SELECT * from traveldistance_3 ORDER BY id asc limit 1500000, 100; -- 1.684s index
SELECT * from traveldistance_3 where id > 5502021 ORDER BY id asc limit 100; -- 0.001s  range

select * From traveldistance_3 Where id >=(
select id From traveldistance_3 Order By id asc limit 1500000,1
) limit 100; -- 1.373s

select * from (
select id from traveldistance_3
 order by id asc limit 1500000,100
) a
inner join traveldistance_3 b on a.id=b.id; -- 最优  1.166s
```

##### 自定义变量
- 
``` sql

set @one := "faf";

SELECT @one;
SELECT @one,(@one:=20) FROM traveldistance_3;
```

##### 视图限制
- show create viwe 充满各种转义符和引号， 使用视图的.frm 文件最后一行 获取一些信息

##### 锁
- MyISAM在执行查询语句（SELECT）前，会自动给涉及的所有表加读锁，在执行更新操作（UPDATE、DELETE、INSERT等）前，会自动给涉及的表加写锁，这个过程并不需要用户干预，因此用户一般不需要直接用LOCK TABLE命令给MyISAM表显式加锁

### 参考
- [存储引擎](https://www.cnblogs.com/kevingrace/p/5685355.html)	
- [MySQL数据库规范及解读 ](https://my.oschina.net/u/1475115/blog/1622401)
- [mysql中OPTIMIZE TABLE的作用及使用](https://www.cnblogs.com/jimmy-muyuan/p/5874410.html)
- [Myisam与Innodb索引的区别](https://blog.csdn.net/qq_25551295/article/details/48901317)
- [VARCHAR与CHAR的区别](http://blog.itpub.net/21374452/viewspace-2136268/)
- [字段类型 与范围](https://www.cnblogs.com/nixi8/p/4514539.html?tvd)
- [zerofill](https://www.cnblogs.com/olinux/p/5180543.html)
- [show processlist结果筛选](https://www.cnblogs.com/hushaojun/p/5151828.html)
- [show processlist命令详解](https://blog.csdn.net/sunqingzhong44/article/details/70570728)
- [Block Nested Loop](https://www.2cto.com/database/201405/297833.html)
- [MySQL的四种事务隔离级别](https://blog.csdn.net/u012807459/article/details/52174601)
- [MySQL创建用户](https://www.cnblogs.com/wanghetao/p/3806888.html)
- [mysql lock tables](https://www.cnblogs.com/kerrycode/p/6991502.html)
- [datetime](https://www.cnblogs.com/ivictor/p/5028368.html)
- [数据库设计三大范式](https://www.cnblogs.com/knowledgesea/p/3667395.html)
- [ALTER COLUMN、CHANGE COLUMN、MODIFY COLUMN的区别](https://blog.csdn.net/bbbbbingo/article/details/77471336)
- [创建索引语句](https://www.jb51.net/article/107294.htm)
- [Mysql几种索引方式的区别及适用情况](http://blog.sina.com.cn/s/blog_4aca42510102v5l2.html)
- [outfile loaddata 创建索引](https://www.cnblogs.com/phpper/p/7572486.html)
- [mysql联合索引 Show index](https://www.cnblogs.com/softidea/p/5977860.html)
- [MySQL exists 和 not exists 的用法](https://www.cnblogs.com/huangshoushi/p/6600082.html)
- [MySQL EXISTS /NOT EXISTS](https://blog.csdn.net/u010003835/article/details/71628993)
- [MySQL EXISTS /NOT EXISTS](https://www.cnblogs.com/beijingstruggle/p/5885137.html)
- [查看mysql库大小，表大小，索引大小](https://www.cnblogs.com/lukcyjane/p/3849354.html)
- [Optimize](https://www.cnblogs.com/lpfuture/p/5772342.html)
- [MySQL查询缓存总结](https://www.cnblogs.com/Alight/p/3981999.html)
- [force index优化sql语句性能](https://blog.csdn.net/bruce128/article/details/46777567)
- [count(1) count(*)](http://www.cnblogs.com/Caucasian/p/7041061.html)
- [limit 优化](https://www.cnblogs.com/shiwenhu/p/5757250.html)
- [mysql 变量](https://www.cnblogs.com/genialx/p/5932558.html)
- [自定义变量限制](https://www.cnblogs.com/guaidaodark/p/6037040.html)
- [视图的作用](http://www.cnblogs.com/sustudy/p/4166714.html)
- [InnoDB 配置信息](https://www.cnblogs.com/benwu/articles/7717978.html)
- [mysql 配置主从 linux](https://blog.csdn.net/qq_21736743/article/details/78063530)
- [DBA 面试答疑](https://blog.csdn.net/mchdba/article/details/52196273)
- [mysql 异常控制](http://blog.itpub.net/29254281/viewspace-2112572/)
- [case when 查询](http://blog.itpub.net/29254281/viewspace-1873635/)
- [mysql date extract](https://blog.csdn.net/moakun/article/details/82527848)
- [MySQL中的锁（表锁、行锁）](https://www.cnblogs.com/chenqionghe/p/4845693.html)
- []()


聚簇索引
分区
load——file
DNS
Docker
Github
zabixx