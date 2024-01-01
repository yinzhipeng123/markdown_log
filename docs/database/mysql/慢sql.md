在 MySQL 中查询 SQL 的执行记录通常涉及以下几个步骤：

1. **慢查询日志**：MySQL 提供了慢查询日志功能，它记录执行时间超过某个阈值的所有 SQL 查询。首先确保慢查询日志已经被启用，并设置了合适的阈值。

   ```sql
   SHOW VARIABLES LIKE 'slow_query_log';
   SHOW VARIABLES LIKE 'long_query_time';
   ```

   如果慢查询日志未启用，可以通过以下方式启用：

   ```sql
   SET GLOBAL slow_query_log = 'ON';
   ```

   并设置一个适当的时间阈值：

   ```sql
   SET GLOBAL long_query_time = [秒数];
   ```

2. **查询日志文件**：慢查询日志被写入到一个文件中，你可以查看这个文件来获取执行记录。文件位置可以通过以下命令找到：

   ```sql
   SHOW VARIABLES LIKE 'slow_query_log_file';
   ```

3. **日志分析工具**：可以使用一些日志分析工具，如 `mysqldumpslow`，来解析慢查询日志，并得到更易于理解的报告。

4. **常规查询日志**：除了慢查询日志，MySQL 还有一个常规查询日志，记录所有的 SQL 语句。这个功能默认是关闭的，因为它可能会显著影响性能。如果需要，可以通过设置 `general_log` 和 `general_log_file` 变量来启用。

5. **性能模式**：MySQL 5.6 及更高版本提供了一个性能模式（Performance Schema），它可以用来监控服务器的运行情况，包括 SQL 执行的详细信息。

请注意，频繁查询这些日志或启用某些日志记录特性可能会对数据库性能产生影响，因此建议仅在必要时使用，并在使用后及时关闭。