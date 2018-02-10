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
* release UNICToken after November 30, 2018
* transfer UNICToken from and to users address

## UNIC PPS API

# API overview

The API supports HTTP and HTTPS.

# API Usage

`https://api.unicads.net/pps`

# Request types

There are two general types of request:

| request       | description                       |
|:--------------|:----------------------------------|
| `?get_widget`      | Request to UNIC PPS API to get widget content |
| `?store_address`  | Store visitor Ethereum address in UNIC referal data base. |

# API Fields

`get_widget` request to UNIC API server contain following fields:

* public_key
* widget_type (wordpress, joomla, drupal, dle, magento, php, html)

`store_address` request to UNIC API server contain following fields:

* public_key
* pub_id
* eth_address
* user_ip

# Result types

| request       | result type                       |
|:--------------|:----------------------------------|
| `?get_widget`      | returns a JavaScript code of widget. |
| `?store_address`  | return a JSON with status: 1 or 0 |

# UNIC PPS Widget

Widget JavaScript code content include HTML form with offer for visitor of advertiser's website to:
* Get agree with UNIC terms;
* Fill out a form with Ethereum address, from which visitor would transfer ETH to advertiser smart-contract to buy advertiser's tokens.

On form submition widget send API request to UNIC API server with `?store_address` request.
On submition complete visitor get access to advertiser's smart-contract address.

## Authors

* **Vladimir Tsyplyayev** - *Initial work* - [VladimirTsyplyayev](https://github.com/VladimirTsyplyayev)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
