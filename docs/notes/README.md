# Thoughts on blockchain technology

Ethereum will be replaced by Hedera eventually.
### Topics for bchain Notes


Reading version [](https://s3.amazonaws.com/hedera-hashgraph/hh-whitepaper-v1.1-180518.pdf)


### Hedera

> Since the Hedera blockchain platform uses solidity, good idea to practise solidity and keep up with changes without banking too much on Ethereum.

The Hedera blockchain platform appears better than bitcoin and ethereum.

> No license will be required to use the Hedera platform. No license will be
required to write software that uses the services of the Hedera platform.
No license will be required to build smart contracts on top of the Hedera
platform.

![48e02f0a.png](:storage\0465a229-b3e8-4a99-9d99-1032d5af9897\48e02f0a.png)

A blockchain is like a tree that is continuously pruned as it grows -
this pruning is necessary to keep the branches from growing out of
control. In hashgraph, rather than pruning new growth, it is woven
back into the body

In hashgraph, every container is used, and none are discarded. All the
branches continue to exist forever, and eventually grow back together
into a single whole. This is more efficient.

Finally, because the hashgraph doesn’t require pruning and therefore
is simpler, it allows more powerful mathematical guarantees, such
as Byzantine agreement and fairness. Distributed databases such as
Paxos are Byzantine, but not fair. Blockchain is neither Byzantine nor
fair. Hashgraph is both Byzantine and fair.

The hashgraph algorithm accomplishes being fair, fast, Byzantine,
ACID compliant, efficient, inexpensive, timestamped, and DoS
resistant.

The hashgraph is ACID compliant. ACID (Atomicity, Consistency, Isolation, Durability) is a database term,
and applies to the hashgraph when it is used as a distributed database. A community of nodes uses it
to reach a consensus on the order in which transactions occurred. After reaching consensus, each node
feeds those transactions to that node’s local copy of the database, sending in each one in the consensus
order. If the local database has all the standard properties of a database (ACID), then the community as a
whole can be said to have a single, distributed database with those same properties. In blockchain, there is
never a moment when you know that consensus has been reached, so it would not be ACID compliant.

Hedera technical and legal controls ensure the platform will not fork into a competing platform and
cryptocurrency. 

#### Sharding 

Consensus can consequently proceed in
parallel. Shards trust each other, so one shard will honor requests to move cryptocurrency or to put a
hold on various resources made by another shard - as long as those requests can be proven to reflect the
consensus of the requesting shard. This allows the multi-shard ledger as a whole to achieve asynchronous
Byzantine fault tolerance, and to prevent double spends or other illegal states, because each individual
shard has those properties, and because all messages between them contain proofs that they are the
consensus of that shard.


The Hedera ledger will use proof-of-stake. When a node joins the system, it must declare one or more
accounts that it can control, and prove that it has the private keys for those accounts. From then on,
the amount of cryptocurrency in those accounts will be used to weight its votes in the hashgraph virtual
voting algorithm. 