// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {SkillsCoin} from "../src/SkillsCoin.sol";
import {RareCoin} from "../src/RareCoin.sol";
import "forge-std/console.sol";

contract CoinsTest is Test {
    SkillsCoin public skillsCoin;
    RareCoin public rareCoin;

    function setUp() public {
        skillsCoin = new SkillsCoin();
        rareCoin = new RareCoin(address(skillsCoin));
    }

    function testOwner() public {
        assertEq(skillsCoin.owner(), address(this));
    }

    function testMint(address _address, uint256 _amount) public {
        assertEq(skillsCoin.balanceOf(_address), 0);
        vm.prank(address(_address));
        skillsCoin.mint(_address, _amount);
        assertEq(skillsCoin.balanceOf(_address), _amount);
    }

    function testSource() public {
        assertEq(rareCoin.source(), address(skillsCoin));
    }

    function testMintRareCoinFailed(address _address, uint256 _amount) public {
        vm.expectRevert();
        (bool s,) = address(rareCoin).call(abi.encodeWithSignature("mint(address,uint256)", _address, _amount));
        require(s, "Cannot mint");
    }

    function testTrade(address _address, uint256 _amount) public {
        vm.startPrank(_address);
        skillsCoin.mint(_address, _amount);
        assertEq(skillsCoin.balanceOf(_address), _amount);

        skillsCoin.approve(address(rareCoin), _amount);
        uint256 allowance = skillsCoin.allowance(_address, address(rareCoin));
        assertEq(allowance, _amount);

        rareCoin.trade(_amount);
        assertEq(skillsCoin.balanceOf(address(rareCoin)), _amount);

        assertEq(rareCoin.balanceOf(_address), _amount);
        vm.stopPrank();
    }
}
