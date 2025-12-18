// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {TTT} from "../src/TTT.sol";
import {Vault} from "../src/Vault.sol";
import {StdTokens} from "tempo-std/StdTokens.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        console.log(type(uint256).max);

        vm.startBroadcast();

        // Simple vault that accepts deposits and withdrawals of any ERC20
        // Vault v = new Vault(msg.sender);

        // #1 Works without issue (regular ERC20 token)
        // TTT ttt = new TTT(msg.sender);
        // ttt.mint(msg.sender, 1_000_000e18);
        // ttt.approve(address(v), type(uint256).max);
        // v.depositTokens(address(ttt), 500_000e18);
        // v.withdrawTokens(address(ttt), 500_000e18);

        // #2 Only works with --skip-simulation
        // StdTokens.ALPHA_USD.approve(address(v), type(uint256).max);
        // v.depositTokens(address(StdTokens.ALPHA_USD), 1);
        // v.withdrawTokens(address(StdTokens.ALPHA_USD), 1);

        vm.stopBroadcast();
    }
}
