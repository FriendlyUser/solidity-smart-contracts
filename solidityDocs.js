import soldoc from '@soldoc/soldoc';

/* default options */
soldoc.defaults = {
    in: './contracts',
    out: './docs',
    /* json: undefined, */
    /* repoUrl: undefined, */
    /* log: undefined, */
    quiet: false,
    theme: '@soldoc/markdown',
};
soldoc(options); // returns a promise