// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Distribute {
    /*
        This exercise assumes you know how to sending Ether.
        1. This contract has some ether in it, distribute it equally among the
           array of addresses that is passed as argument.
        2. Write your code in the `distributeEther` function.
    */

    constructor() payable {}

    function distributeEther(address[] memory addresses) public {
        uint eqBal = address(this).balance / addresses.length;
        for(uint i; i < addresses.length; i++) {
            (bool ok, ) = addresses[i].call{value: eqBal}("");
            require(ok, "Can't send Ether");
        }
        // your code here
    }
}
