// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
        address _priceOracle1,
        address _priceOracle2
    ) external returns (uint256) {
        (bool s, bytes memory result) = _priceOracle1.call(abi.encodeWithSignature("price()"));
        require(s, "calling contract 1 failed");
        (bool s2, bytes memory result2) = _priceOracle2.call(abi.encodeWithSignature("price()"));
        require(s2, "calling contract 2 failed");
        (uint256 res, uint256 res2) = (abi.decode(result, (uint256)), abi.decode(result2, (uint256)));
        return res < res2 ? res : res2;
        // your code here
    }
}

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
