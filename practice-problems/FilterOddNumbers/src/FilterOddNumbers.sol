// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract FilterOddNumbers {
    /*
        This exercise assumes you understand how to manipulate Array.
        1. Function `filterOdd` takes an array of uint256 as argument. 
        2. Filter and return an array with the odd numbers removed.
        Note: this is tricky because you cannot allocate a dynamic array in memory, 
              you need to count the even numbers then declare an array of that size.
    */

    function filterOdd(uint256[] memory _arr)
        public
        pure
        returns (uint256[] memory)
    {
        // your code here
        uint count;
        for(uint i = 0; i < _arr.length; i++){
            if(_arr[i] % 2 == 0){
                count++;
            }
        }
        uint[] memory res = new uint[](count);
        uint position;
        for(uint i = 0; i < _arr.length; i++){
            if(_arr[i] % 2 == 0){
                res[position] = _arr[i];
                position++;
            }
        }
        return res;
    }
}
