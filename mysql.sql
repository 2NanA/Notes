	
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
