```bash
moc --package base $(dfx cache show)/base -r src/mysite/main.mo

dfx canister call mysite quicksort '(vec {-10; 2; 8; 10; 39; 333})'
```