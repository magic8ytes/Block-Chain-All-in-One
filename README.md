# BlockChain

This repositories is for recording all the results by learning BlockChain.


## MISC

### List of Scripts

#### 1.Crack0Address-ByGolang

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

[20221212 Mev](#20221212---mev---flashloan--DSPFlashLoanCall-LackPermissionCheck)

[20221201 APC](#20221201---apc---flashloan--price-manipulation)

---
#### 20221212 - Mev - FlashLoan DSPFlashLoanCall Lack of Permission Check
#### Lost:  $1.3K

Exploiting

```sh
forge test --contracts ./src/test/Mev_Lack_Permission_Check_exp.t.sol -vvv
```
#### Contract

[Mev_Lack_Permission_Check_exp.t.sol](DefiHackPoc/src/test/Mev_Lack_Permission_Check_exp.t.sol)

#### Link reference

https://etherscan.io/tx/0x313d23bdd9277717e3088f32c976479c09d4b8a94d5d94deb835d157fd0850ce

#### 20221201 - APC - FlashLoan & price manipulation
#### Lost:  $6K

Exploiting

```sh
forge test --contracts ./src/test/APC_exp.t.sol -vvv
```

#### Contract

[APC_exp.t.sol](DefiHackPoc/src/test/APC_exp.t.sol)

#### Link reference

https://bscscan.com/tx/0xf2d4559aeb945fb8e4304da5320ce6a2a96415aa70286715c9fcaf5dbd9d7ed2