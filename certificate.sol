pragma solidity >=0.6.10 <0.8.20;
pragma experimental ABIEncoderV2;

import "./Table.sol";

contract Certificate {
    event CreateCertificate(int256 count);

    TableFactory tableFactory;
    string constant TABLE_NAME = "t_certificate";
    constructor() public {
        tableFactory = TableFactory(0x1001); //The fixed address is 0x1001 for TableFactory
        tableFactory.createTable(TABLE_NAME, "evidenceHash", "appKey,startEid,endEid");
    }

    function getCertificates(string memory name)
    public
    view
    returns (string[] memory, string[] memory, string[] memory,string[] memory)
    {
        Table table = tableFactory.openTable(TABLE_NAME);

        Condition condition = table.newCondition();

        Entries entries = table.select(name, condition);
        string[] memory evidenceHashList = new string[](
            uint256(entries.size())
        );
        string[] memory appKeyList = new string[](
            uint256(entries.size()));
        string[] memory startEidList = new string[](
            uint256(entries.size())
        );
        string[] memory endEidList = new string[](
            uint256(entries.size())
        );

        for (int256 i = 0; i < entries.size(); ++i) {
            Entry entry = entries.get(i);

            evidenceHashList[uint256(i)] = entry.getString("evidenceHash");
            appKeyList[uint256(i)] = entry.getString("appKey");
            startEidList[uint256(i)] = entry.getString("startEid");
            endEidList[uint256(i)] = entry.getString("endEid");
        }

        return (evidenceHashList, appKeyList, startEidList, endEidList);
    }
    //insert records
    function addCertificate(string memory evidenceHash, string memory appKey, string memory startEid,string memory endEid)
    public
    returns (int256)
    {
        Table table = tableFactory.openTable(TABLE_NAME);

        Entry entry = table.newEntry();
        entry.set("evidenceHash", evidenceHash);
        entry.set("appKey", appKey);
        entry.set("startEid", startEid);
        entry.set("endEid", endEid);

        int256 count = table.insert(name, entry);
        emit CreateCertificate(count);

        return count;
    }
  
}