package main

import (
	"crypto/ecdsa"
	"fmt"
	"io/ioutil"
	"log"
	"strings"

	"github.com/ethereum/go-ethereum/common/hexutil"
	"github.com/ethereum/go-ethereum/crypto"
)

func main() {
	for {
		privateKey, err := crypto.GenerateKey()
		if err != nil {
			log.Fatal(err)
		}

		privateKeyBytes := crypto.FromECDSA(privateKey)
		// fmt.Printf("Private key: %s\r", hexutil.Encode(privateKeyBytes))

		publicKey := privateKey.Public()
		publicKeyECDSA, ok := publicKey.(*ecdsa.PublicKey)
		if !ok {
			log.Fatal("cannot assert type: publicKey is not of type *ecdsa.PublicKey")
		}

		address := crypto.PubkeyToAddress(*publicKeyECDSA).Hex()
		fmt.Printf("Address: %s Private key: %s\r", address, hexutil.Encode(privateKeyBytes))

		if strings.HasPrefix(address, "0x0000000000") {
			// Print the private key and address
			fmt.Printf("Private key: %s\n", hexutil.Encode(privateKeyBytes))
			fmt.Printf("Address: %s\n", address)

			// Write the data to a file
			str := fmt.Sprintf("Addr: %s PK: %s\r", address, hexutil.Encode(privateKeyBytes))
			data := []byte(str)
			err := ioutil.WriteFile("address.txt", data, 0644)
			if err != nil {
				panic(err)
			}
			break
		}
	}
}
