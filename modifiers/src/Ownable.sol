// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Ownable {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "onlyOwner");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

}

contract HoldFunds is Ownable {
    
    function withdrawFunds() public onlyOwner {
        (bool ok, ) = owner.call{value: address(this).balance}("");
        require(ok, "transfer failed");
    }

    receive() external payable {

    }
}