# BlockChain

This repositories is for recording all the results by learning BlockChain.


### MISC

address.go is a golang code for generate ethernum network address start with 0x00000000

```
$ go mod init address 

$ go get github.com/ethereum/go-ethereum/common/hexutil

$ go get github.com/ethereum/go-ethereum/crypto

$ GOOS=linux GOARCH=amd64 go build -o bin/address address.go

$ ./address
```

## DefiHackPoc

### List of Exploits

[20221201 APC](#20221201---apc---flashloan--price-manipulation)

---
#### 20221201 - APC - FlashLoan & price manipulation
#### Lost: $6K

Exploiting

```sh
forge test --contracts ./src/test/APC_exp.sol -vvv
```

#### Contract

[APC_exp.sol](DefiHackPoc/src/test/APC_exp.sol)

#### Link reference

https://bscscan.com/tx/0xf2d4559aeb945fb8e4304da5320ce6a2a96415aa70286715c9fcaf5dbd9d7ed2