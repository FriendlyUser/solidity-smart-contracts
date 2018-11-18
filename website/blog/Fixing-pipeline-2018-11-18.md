---
title: Fixing Build Pipeline
author: David Li
authorURL: http://friendlyuser.github.io
authorFBID: 661277175
---

# Solidity-docgen travis CI issues

Since the solc package was updated to version 5.0, and ppa eliminate previous versions, I found myself needed to install an old version.

What I ended up doing is manually downloading the binary using wget and then linking it to path