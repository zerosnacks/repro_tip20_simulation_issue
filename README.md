## Repro

Prepare account:

```sh
foundryup -n tempo
export TEMPO_RPC_URL=https://rpc.testnet.tempo.xyz
read ADDR PK < <(cast wallet new --json | jq -r '.[0] | "\(.address) \(.private_key)"')
cast rpc tempo_fundAddress "$ADDR" --rpc-url "$TEMPO_RPC_URL"
```

Inspect `Deploy.s.sol`, next:

Run `#1`:

```sh
forge script script/Deploy.s.sol --private-key $PK --rpc-url $TEMPO_RPC_URL --broadcast
```

See that ERC20 token approval & deposit & withdrawal works.

Next, comment out `#1`, uncomment `#2`:

```sh
forge script script/Deploy.s.sol --private-key $PK --rpc-url $TEMPO_RPC_URL --broadcast
```

See that TIP20 approval succeeds but deposit results in

```
  [16515] Vault::depositTokens(0x20C0000000000000000000000000000000000001, 1)
    ├─ [10524] 0x20C0000000000000000000000000000000000001::transferFrom(0x2f05B1546B2E5170DB125708b228E03573ecc5E0, Vault: [0xA52D7E926358a0705B84d7Ebcfb27968625fb152], 1)
    │   └─ ← [Revert] panic: arithmetic underflow or overflow (0x11)
    └─ ← [Revert] panic: arithmetic underflow or overflow (0x11)
```

Runnig the same command with `--skip-simulation`:

```
forge script script/Deploy.s.sol --private-key $PK --rpc-url $TEMPO_RPC_URL --broadcast --skip-simulation
```

Works without issue:

```
[⠊] Compiling...
No files changed, compilation skipped
Script ran successfully.

SKIPPING ON CHAIN SIMULATION.

##### tempo-testnet
✅  [Success] Hash: 0x0d4f88b9b4880f66987530cf7198c7146600002e145c6f05f5cd348426d27c20
Contract Address: 0xA52D7E926358a0705B84d7Ebcfb27968625fb152
Block: 5994423
Paid: 0.00536829236632284 PathUSD (536820 gas * 10.000172062 gwei)


##### tempo-testnet
✅  [Success] Hash: 0x98f0d6682af47232562db2c5154d5ff4801437a23beda74e912164ee5733cf75
Block: 5994427
Paid: 0.000459187900742916 PathUSD (45918 gas * 10.000172062 gwei)


##### tempo-testnet
✅  [Success] Hash: 0x2ac126e3a00d2812dd1b29395be74a8261b840bd6e6f82775e300947cb001655
Block: 5994432
Paid: 0.00079861374087132 PathUSD (79860 gas * 10.000172062 gwei)


##### tempo-testnet
✅  [Success] Hash: 0x22841c368cc2f3c3f7fd904e86dcb67a74619a27edebfa3ec87c5d23a60a21fa
Block: 5994435
Paid: 0.000605400416461418 PathUSD (60539 gas * 10.000172062 gwei)

✅ Sequence #1 on tempo-testnet | Total Paid: 0.007231494424398494 PathUSD (723137 gas * avg 10.000172062 gwei)


==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.

Transactions saved to: /home/zerosnacks/Projects/work/testrepo12/broadcast/Deploy.s.sol/42429/run-latest.json

Sensitive values saved to: /home/zerosnacks/Projects/work/testrepo12/cache/Deploy.s.sol/42429/run-latest.json
```
