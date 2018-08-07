import soldoc from '@soldoc/soldoc';

/* default options */
soldoc.defaults = {
    in: './contracts',
    out: './docs/contracts',
    /* json: undefined, */
     /*repoUrl: FriendlyUser/solidity-smart-contracts, */ 
     log: ./docs/contracts/Soldoc.md, 
    quiet: false,
    theme: '@soldoc/markdown',
};
soldoc(options); // returns a promise