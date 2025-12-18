// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "solady/tokens/ERC20.sol";
import {Ownable} from "solady/auth/Ownable.sol";

contract TTT is ERC20, Ownable {
    constructor(address owner) {
        _initializeOwner(owner);
    }

    function name() public pure override returns (string memory) {
        return "Tempo Test Token";
    }

    function symbol() public pure override returns (string memory) {
        return "TTT";
    }

    function decimals() public pure override returns (uint8) {
        return 18;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external onlyOwner {
        _burn(from, amount);
    }
}
