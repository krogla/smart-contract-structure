# UNIC Smart Contracts

These are the smart contracts which will power the Ethereum side of our platform. The following are included:

1. UNICToken
1. UNICPlatform
1. PPSContract

## UNICToken

UNICToken is an ERC20 Token with added features enabling the UNIC contract to:

* send out tokens from the token sale
* finalise the token sale according to previously agreed up terms
* approve the UNICPlatform contract to transfer tokens
* be tradable amongst users
* be tradable on exchanges
* be upgradeable

## UNICPlatform

UNICPlatform will be the contract that will be able to:

* lock in UNICToken through transferFrom, an ERC20 standard function
* release UNICToken after November 30, 2020
* transfer UNICToken from and to users address

## PPSContract

The PPSContract is ERC20 Library for import to advertisers smart-contracts. It will be able to:

* lock in UNICToken through transferFrom, an ERC20 standard function
* transfer UNICToken from advertiser address to publisher address after confirmed sale

## Authors

* **Vladimir Tsyplyayev** - *Initial work* - [VladimirTsyplyayev](https://github.com/VladimirTsyplyayev)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
