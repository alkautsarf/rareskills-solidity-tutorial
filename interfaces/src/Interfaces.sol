// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;


// ------------------ V1 -------------------
contract GetSumV1 {

    function getSum(address adder, uint256 a, uint256 b) public returns (uint256) {
        (bool ok, bytes memory result) = adder.call(abi.encodeWithSignature("add(uint256,uint256)", a, b));
        require(ok, "call failed");
        uint256 sum = abi.decode(result, (uint256));
        return sum;
    }
}

// ----------------- V2 --------------------
interface IAdder {
    function add(uint256, uint256) external view returns (uint256);
}

contract GetSumV2 {
    function getSum(IAdder adder, uint256 a, uint256 b) public returns (uint256) {
        return adder.add(a, b);
    }
}

contract Adder {
    function add(uint256 a, uint256 b) public view returns (uint256) {
        return a + b;
    }
}


// ------------------ V1 -------------------
contract GetSumV3 {

    // note we changed call to staticcall
    // public --> external
    // added a view modifier
    function getSum(address adder, uint256 a, uint256 b) external view returns (uint256) {
        (bool ok, bytes memory result) = adder.staticcall(abi.encodeWithSignature("add(uint256,uint256)", a, b));
        require(ok, "call failed");
        uint256 sum = abi.decode(result, (uint256));
        return sum;
    }
}

contract AdderV2 {

    // view changed to pure
    function add(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }
}