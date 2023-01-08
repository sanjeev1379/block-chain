// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './PriceConvertor.sol';

contract FundMe {
    using PriceConvertor for uint;

    uint public mimimumUsd = 10 * 1e18; // 1000000000000000000 ETH
    address[] public funders;
    mapping(address=>uint) public funderAddressToPrice;

    address public owner;

    constructor() {
        owner = msg.sender;
    }


    function fund() public payable {
        // want to send minimum USD for fund
        // require(priceConversionRate(msg.value) > mimimumUsd, "don't have enfough amount");

        // with library we need to call something like below
        // require(priceConversionRate(msg.value) > mimimumUsd, "don't have enfough amount"); // or
        require(msg.value.priceConversionRate() > mimimumUsd, "don't have enfough amount"); // here bydefault msg.value is first paramter if we need to send second Params use msg.value.priceConversionRate(234)

        funders.push(msg.sender);
        funderAddressToPrice[msg.sender] = msg.value;
    }

    function withdraw() public _onlyOwner {
        for(uint fundIndex = 0; fundIndex < funders.length; fundIndex++) {
            address funder = funders[fundIndex];
            funderAddressToPrice[funder] = 0;
        }
        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{ value : address(this).balance}("");
        require(callSuccess, "Transfer Failed");
    }

    modifier _onlyOwner() {
        require(owner == msg.sender, "Your are not owner!");
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }


}
