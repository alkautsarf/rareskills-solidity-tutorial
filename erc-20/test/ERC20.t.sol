// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {ERC20} from "../src/ERC20.sol";

contract CounterTest is Test {
    ERC20 public erc20;

    function setUp() public {
        erc20 = new ERC20("elpabl0","elpabl0");
    }

    function testName() public {  
        assertEq(erc20.name(), "elpabl0", "name should be elpabl0");
    }

    function testSymbol() public {  
        assertEq(erc20.symbol(), "elpabl0", "symbol should be elpabl0");
    }

    function testMint() public {
        erc20.mint(2500);
        assertEq(erc20.balanceOf(erc20.owner()), 2500, "Owner balance should be 2500");
    }

    function testFail_SupplyMax() public {
        erc20.mint(1000000);
    }

    // function testFuzz_SetNumber(uint256 x) public {
    //     erc20.setNumber(x);
    //     assertEq(erc20.number(), x);
    // }
}
