```bash
moc --package base $(dfx cache show)/base -r src/mysite/main.mo

dfx canister call mysite quicksort '(vec {-10; 2; 8; 10; 39; 333})'

dfx deploy --network=ic --with-cycles=400000000000 --no-wallet

dfx identity get-principal
dfx identity --network=ic set-wallet bmpeg-laaaa-aaaal-qadyq-cai

dfx canister --network=ic --no-wallet update-settings --controller bmpeg-laaaa-aaaal-qadyq-cai a5f2z-tiaaa-aaaal-qad5a-cai

dfx canister --network=ic stop <canister_name>

```