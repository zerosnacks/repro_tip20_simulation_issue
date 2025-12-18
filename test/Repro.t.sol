// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Vault} from "../src/Vault.sol";
import {StdTokens} from "tempo-std/StdTokens.sol";
import {TTT} from "../src/TTT.sol";

contract ReproTest is Test {
    Vault vault;
    TTT ttt;

    address constant SENDER = address(0x2f05B1546B2E5170DB125708b228E03573ecc5E0);

    function setUp() public {
        vm.startPrank(SENDER);
        vault = new Vault(SENDER);
        ttt = new TTT(SENDER);
        ttt.mint(SENDER, 1_000_000e18);
        vm.stopPrank();
    }

    function testDepositWithdrawTTT() public {
        vm.startPrank(SENDER);
        ttt.approve(address(vault), type(uint256).max);
        vault.depositTokens(address(ttt), 500_000e18);
        vault.withdrawTokens(address(ttt), 500_000e18);
        vm.stopPrank();
    }

    function testDepositWithdrawAlphaUSD() public {
        vm.startPrank(SENDER);
        StdTokens.ALPHA_USD.approve(address(vault), type(uint256).max);
        vault.depositTokens(address(StdTokens.ALPHA_USD), 1);
        vault.withdrawTokens(address(StdTokens.ALPHA_USD), 1);
        vm.stopPrank();
    }
}
