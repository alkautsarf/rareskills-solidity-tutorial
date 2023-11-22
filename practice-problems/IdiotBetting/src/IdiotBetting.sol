// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    uint256 public highestDeposit;
    uint256 public endTime;
    address public winner;

    function bet() public payable {
        require(msg.value > 0, "Deposit must be greater than 0");

        if (msg.value > highestDeposit) {
            highestDeposit = msg.value;
            endTime = block.timestamp + 1 hours;
            winner = msg.sender;
        }
    }

    function claimPrize() public {
        require(block.timestamp >= endTime, "Timer has not expired yet");
        require(msg.sender == winner, "You are not the winner");

        // Use transfer with a gas stipend to prevent potential gas exhaustion
        //! Not Recommend
        // payable(winner).transfer(address(this).balance);
        //? Recommended
        (bool ok,) = payable(winner).call{value: address(this).balance, gas: gasleft()}("");
        require(ok);
    }
}
