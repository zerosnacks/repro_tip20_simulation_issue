// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Ownable} from "solady/auth/Ownable.sol";
import {ERC20} from "solady/tokens/ERC20.sol";

contract Vault is Ownable {
    constructor(address owner) {
        _initializeOwner(owner);
    }

    function depositTokens(address token, uint256 amount) external onlyOwner {
        bool success = ERC20(token).transferFrom(msg.sender, address(this), amount);
        require(success, "Transfer failed");
    }

    function withdrawTokens(address token, uint256 amount) external onlyOwner {
        bool success = ERC20(token).transfer(msg.sender, amount);
        require(success, "Transfer failed");
    }
}
