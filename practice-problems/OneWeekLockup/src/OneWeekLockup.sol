// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */
     mapping(address => uint256) public balances;
     uint256 public lastDeposit;

    function balanceOf(address user) public view returns (uint256) {
        return balances[user];
        // return the user's balance in the contract
    }

    function depositEther() external payable {
        balances[msg.sender] += msg.value;
        lastDeposit = block.timestamp;
        /// add code here
    }

    function withdrawEther(uint256 amount) external {
        require(lastDeposit != 0 && block.timestamp >= lastDeposit + 1 weeks && balances[msg.sender] >= amount);
        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "Tx Failed");
        balances[msg.sender] -= amount;
        /// add code here
    }
}
