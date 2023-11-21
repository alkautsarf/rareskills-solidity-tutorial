// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {SkillsCoin} from "../src/SkillsCoin.sol";
import {RareCoin} from "../src/RareCoin.sol";
import "forge-std/console.sol";

contract CoinsScript is Script {
    SkillsCoin skillsCoin;
    RareCoin rareCoin;
    function setUp() public {}

    function run() public {
        uint privateKey = vm.envUint("PRIVATE_KEY");
        address account = vm.addr(privateKey);
        uint _amount = 1000e18;

        console.log("Account", account);
        vm.startBroadcast(privateKey);

        skillsCoin = new SkillsCoin();
        rareCoin = new RareCoin(address(skillsCoin));

        skillsCoin.mint(account, _amount);
        skillsCoin.approve(address(rareCoin), _amount);
        rareCoin.trade(_amount);
        assert(rareCoin.balanceOf(account) == _amount);
        vm.stopBroadcast();
    }
}
