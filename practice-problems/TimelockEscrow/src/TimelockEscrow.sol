// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    uint256 public escrowId = 0;
    mapping(uint => bool) public escrowActive;
    address public buyer;
    uint256 public escrowTime;
    uint256 public escrowEnd = escrowTime + 3 days;
    mapping(address => uint256) private escrowAmount;

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */

    function createBuyOrder() external payable {
        require(escrowAmount[msg.sender] == 0);
        buyer = msg.sender;
        escrowTime = block.timestamp;
        escrowAmount[msg.sender] = msg.value;
        escrowActive[escrowId] = true;
        // your code here
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with has passed
     */

    function sellerWithdraw(address _buyer) external {
        require(block.timestamp >= escrowEnd && msg.sender == seller);
        (bool ok,) = seller.call{value: escrowAmount[_buyer]}("");
        require(ok);
        escrowActive[escrowId] = false;
        escrowAmount[_buyer] = 0;
        // your code here
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        require(block.timestamp < escrowEnd && msg.sender == buyer);
        (bool ok,) = buyer.call{value: escrowAmount[buyer]}("");
        require(ok);
        escrowActive[escrowId] = false;
        escrowAmount[buyer] = 0;
        // your code here
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address _buyer) external view returns (uint256) {
        return escrowAmount[_buyer];
        // your code here
    }
}
