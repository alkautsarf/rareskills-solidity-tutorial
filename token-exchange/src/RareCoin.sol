// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RareCoin is ERC20 {
    address public source;
    constructor(address _source) ERC20("RareCoin", "RRC") {
        source = _source;
    }

    function mint(address to, uint256 amount) private {
        _mint(to, amount);
    }

    function trade(uint256 amount) public {
        // some code
        // you can pass the address of the deployed SkillsCoin contract as a parameter to the constructor of the RareCoin contract as 'source'
        (bool ok, ) = source.call(
            abi.encodeWithSignature(
                "transferFrom(address,address,uint256)",
                msg.sender,
                address(this),
                amount
            )
        );
        // this will fail if there is insufficient approval or balance
        require(ok, "call failed");
        mint(msg.sender, amount);
        // more code
    }
}
