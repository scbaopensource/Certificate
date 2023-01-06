pragma solidity ^0.4.24;

contract TableFactory {
    /**
     * @brief 打开表，返回Table合约地址
     * @param tableName 表的名称
     * @return 返回Table的地址，当表不存在时，将会返回空地址即address(0x0)
     */
    function openTable(string tableName) public constant returns (Table);

    /**
     * @brief 创建表，返回是否成功
     * @param tableName 表的名称
     * @param key 表的主键名
     * @param valueFields 表的字段名，多个字段名以英文逗号分隔
     * @return 返回错误码，成功为0，错误则为负数
     */
    function createTable(string tableName,string key,string valueFields) public returns(int);
}

// 查询条件
contract Condition {
    //等于
    function EQ(string, int) public;
    function EQ(string, string) public;

    //不等于
    function NE(string, int) public;
    function NE(string, string)  public;

    //大于
    function GT(string, int) public;
    //大于或等于
    function GE(string, int) public;

    //小于
    function LT(string, int) public;
    //小于或等于
    function LE(string, int) public;

    //限制返回记录条数
    function limit(int) public;
    function limit(int, int) public;
}

// 单条数据记录
contract Entry {
    function getInt(string) public constant returns(int);
    function getAddress(string) public constant returns(address);
    function getBytes64(string) public constant returns(byte[64]);
    function getBytes32(string) public constant returns(bytes32);
    function getString(string) public constant returns(string);

    function set(string, int) public;
    function set(string, string) public;
    function set(string, address) public;
}

// 数据记录集
contract Entries {
    function get(int) public constant returns(Entry);
    function size() public constant returns(int);
}

// Table主类
contract Table {
    /**
     * @brief 查询接口
     * @param key 查询主键值
     * @param cond 查询条件
     * @return Entries合约地址，合约地址一定存在
     */
    function select(string key, Condition cond) public constant returns(Entries);
    /**
     * @brief 插入接口
     * @param key 插入主键值
     * @param entry 插入字段值
     * @return 插入影响的行数
     */
    function insert(string key, Entry entry) public returns(int);
    /**
     * @brief 更新接口
     * @param key 更新主键值
     * @param entry 更新字段值
     * @param cond 更新条件
     * @return 更新影响的行数
     */
    function update(string key, Entry entry, Condition cond) public returns(int);
    /**
     * @brief 删除接口
     * @param key 删除的主键值
     * @param cond 删除条件
     * @return 删除影响的行数
     */
    function remove(string key, Condition cond) public returns(int);

    function newEntry() public constant returns(Entry);
    function newCondition() public constant returns(Condition);
}