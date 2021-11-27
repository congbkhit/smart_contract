// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.10;
contract Test {
    uint256 testData;
    constructor(){
        testData = 10;
    }
    function getData() public view returns (uint256 data){
        return testData;
    }
}