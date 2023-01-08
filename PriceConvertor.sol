// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConvertor {

    function getPrice() internal view returns(uint) {
        // ABI
        // Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int price, , ,)=priceFeed.latestRoundData();
        return uint(price*1e10);

    }

    function priceConversionRate(uint ethAmount) internal view returns(uint) {
        uint ethPrice = getPrice();
        // 3000_000000000000000000 = ETH / USD Price
        // 1_000000000000000000 = ETH
        uint ethPriceInUsd = ( ethAmount * ethPrice ) / 1e18;
        return ethPriceInUsd;

    }

    function getVersion() internal view returns(uint) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }
}
