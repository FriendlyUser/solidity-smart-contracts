[![Build Status](https://travis-ci.org/FriendlyUser/solidity-smart-contracts.svg?branch=master)](https://travis-ci.org/FriendlyUser/solidity-smart-contracts) [![DOI](https://zenodo.org/badge/143545024.svg)](https://zenodo.org/badge/latestdoi/143545024)
# Solidity-smart contracts

Since the solidity programming language is used in multiple blockchain platform including

- Ethereum
- Hedera

learning solidity is invaluable as blockchain technologies and smart contracts will be eseential in the future.

**Disclaimer** Getting contracts to compile on solidity *4.2x and 5 is quite difficult in addition to the rapid changes to the openzeppelin framework.

I think I'll end up flattener all open zeppelin contracts just to be save in the future and may rely on other ways to generic solidity documentation.

## Documentation

A statically generated site via vuepress and the soldoc solidity documentation which produces markdown.

To generate markdown documentation make sure [soldoc](https://github.com/dev-matan-tsuberi/soldoc) is installed.
```sh
soldoc -o ./docs/contracts --log ./docs/contracts/Soldoc.md
```


### References

* https://github.com/aunyks/vitruvius
* https://github.com/PruthviKumarBK/Decentralized_eCom
* https://github.com/woodydeck/What-Does-Nadia-Think
