// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract ReceiveAndFallback {
    uint public result;

    receive() external payable {
        result = 1;
    }

    fallback() external payable {
        result = 2;
    }
}
