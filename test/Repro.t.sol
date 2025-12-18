// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../src/Vault.sol";
import {StdTokens} from "tempo-std/StdTokens.sol";
import {TTT} from "../src/TTT.sol";

contract ReproTest is Test {
    Vault vault;
    TTT ttt;

    function setUp() public {
        vault = new Vault(address(this));

        ttt = new TTT(address(this));
        ttt.mint(address(this), 1_000_000e18);
    }

    function testDepositWithdrawTTT() public {
        ttt.approve(address(vault), type(uint256).max);
        vault.depositTokens(address(ttt), 500_000e18);
        vault.withdrawTokens(address(ttt), 500_000e18);
    }

    function testDepositWithdrawAlphaUSD() public {
        StdTokens.ALPHA_USD.approve(address(vault), type(uint256).max);
        vault.depositTokens(address(StdTokens.ALPHA_USD), 1);
        vault.withdrawTokens(address(StdTokens.ALPHA_USD), 1);
    }
}
