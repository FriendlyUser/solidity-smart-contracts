// .vuepress/config.js
// missing markdownItAds boostnote admonitions
const fs = require('fs')
const path = require('path')
const util = require('util')


module.exports = {
  base: '/solidity-smart-contracts/',
  //theme: 'cool',
  //dest: 'dist',
  // could add script to insert chart js in here.
  head: [
  ],
  themeConfig: {
    //logo: './myAvatar.png',
    sidebar: true,
    sidebarDepth: 2,
    displayAllHeaders: true, // Default: false
    nav:  genNavBarList(),
    // consider making this sidebar generation completely automatic, but would I prefer to make some control over titling and selected folders that are displayed.   
    // for nested folders in the sidebar, manually enter the folder names using genSideBarConfigFolder, but control the main control direction
    
    // the format of the sidebar folder should look like 
    /*  '/contracts/': [
        '',     // /foo/ 
        'Users',  // /foo/one.html 
        'TodoList', // /foo/two.html 
        'games/Users'
      ], */
    sidebar: {
      '/contracts/': genSideBarConfigFolder('/contracts/'),
      '/notes/': [
        '',
        'IntroBchain',
        'IPFS',
        'Solidity',
        'ContinuousIntegration'
      ],      /* /notes/ */
      // fallback
      '/': [
        '',        /* / */
      ]

    },
    sidebarDepth: 2,
    lastUpdated: 'Last Updated', // string | boolean
    // Assumes GitHub. Can also be a full GitLab url.
    repo: 'FriendlyUser/solidity-smart-contracts',
    // Customising the header label
    // Defaults to "GitHub"/"GitLab"/"Bitbucket" depending on `themeConfig.repo`
    repoLabel: 'Contribute!',
    // Optional options for generating "Edit this page" link
    // if your docs are in a different repo from your main project:
    //docsRepo: 'FriendlyUser/markdown-notes-template',
    // if your docs are not at the root of the repo:
    //docsDir: 'docs',
    // if your docs are in a specific branch (defaults to 'master'):
    docsBranch: 'gh-pages',
    // defaults to false, set to true to enable
    editLinks: true,
    // custom text for edit link. Defaults to "Edit this page"
    editLinkText: 'Help us improve this page!'

  },
  // testomg
  title: 'Solidity Smart Contracts',
  description: 'Documented for smart contracts that were interesting to me.',
  markdown: {
    // options for markdown-it-anchor
    anchor: { permalink: true },
    // options for markdown-it-toc
    toc: { includeLevel: [1, 2,3, 4] },
    config: md => {
      // use more markdown-it plugins!
      md.set({html: true})
      md.use(require("markdown-it-task-lists"));
      md.use(require("markdown-it-plantuml"));
      // use for easy syntax mermaid diagrams
 
    }
  }
}


// Helper functions
function fromDir(startPath,filter,recurse,callback){
  
    //console.log('Starting from dir '+startPath+'/');
    if (!fs.existsSync(startPath)){
        console.log("no dir ",startPath);
        return;
    }

    var files=fs.readdirSync(startPath);
    for(var i=0;i<files.length;i++){
        var filename=path.join(startPath,files[i]);
        var stat = fs.lstatSync(filename);
        if (stat.isDirectory() && recurse){
            fromDir(filename,filter,recurse,callback); //recurse
        }
        else if (filter.test(filename)) callback(filename);
    };
};

function getDirectories(path) {
  return fs.readdirSync(path).filter(function (file) {
    if (file != '.vuepress') {
        return fs.statSync(path+'/'+file).isDirectory();
    }
  });
}

// Not used at the moment, could be useful if I add string trimming to the front.
// cuts relative path to directory, docs/contracts/tokens/Test.md should become /tokens/Test  
// Signature: str.substring(x)
function getFilesInDir(directoryName,numberToCut) {
    var files = []
    // sidebar settings
    const relPath = path.join('docs', directoryName)
    fromDir(relPath,/\.md$/,true,function(filename){
        console.log('-- found:  ',filename);
        
        const vuepressLinkName = filename.substring(numberToCut).split('.').slice(0, -1).join('.')
        
        let baseName = path.basename(filename)
        baseName = filename.split('.').slice(0, -1).join('.')
        
        baseName = baseName.toUpperCase()
        //console.log(baseName)
        
        // Add README as ''
        if (baseName.indexOf('README') !== -1) {
            files.push('')
        }
        // check if file contains windows path ending  
        else if (filename.match(/\\/) != null){
            // cut unnecessary folders and 
            const properFilePath = vuepressLinkName.replace(/\\/g,"/");
            files.push(properFilePath)
        }
        // CI/CD, file path works with linux as is .
        else {
            files.push(vuepressLinkName)
        }
    });
    files.sort()
    return files
}

// Base file names with removed file extensions
function getFilesInDirBase(directoryName) {
    var files = []
    // sidebar settings
    const relPath = path.join('docs', directoryName)
    fromDir(relPath,/\.md$/,false,function(filename){
        console.log('-- found: ',filename);
        let baseName = path.basename(filename)
        
        // this it will fail on files without extension, see https://stackoverflow.com/questions/4250364/how-to-trim-a-file-extension-from-a-string-in-javascript
  
        baseName = baseName.split('.').slice(0, -1).join('.')
        
        //console.log(baseName)
        
        // Add README as '', and everything else as standard
        if (baseName.toUpperCase() == 'README') {
            files.push('')
        }
        else {
            files.push(baseName)
        }
    });

    return files.sort()
}

// pass in the folder relative to the folder docs
function genSideBarConfigFolder (directoryName) {
    const pathPathCut = 'docs/contracts/'.length
    const rawFilePaths = getFilesInDir(directoryName, pathPathCut)
    console.log('The file Paths are')
    console.log(rawFilePaths)
    
    /*const logFileSideBar = "docs/.vuepress/configSideBar" + directoryName + ".txt"
    fs.writeFile(logFileSideBar, util.inspect(rawFilePaths, {depth: null}), function(err) {
    if(err) {
        return console.log(err);
    }
    });
    console.log("Saving sidebar config for " + titleName);
    */
    return rawFilePaths
}

// doesn't work, fix later, can't figure out how to generate { text: link:} recursively? Or maybe have another function that returns text: link 
 function genNavBarList() {
    const dirNames = getDirectories('docs')
    // navbar settings
    let navBarNames = [
    ];
    
    navBarNames.push(genNavBarItem('Home','/'))
    console.log(navBarNames)
    var numOfDirs = dirNames.length;
    for (var i = 0; i < numOfDirs; i++) {
        // not last entry
        let stringValue = dirNames[i].toString()
        let linkValue = '/'+stringValue+'/'
        console.log(stringValue)
        
        // @todo change loop to iterate for nested directories
        if (true) {
            navBarNames.push(genNavBarItem(stringValue,linkValue))
        }
        // last entry 
        else {
            //navBarNames = navBarNames + "{ text : \'" + stringValue + "\', " + "link: " + "\'/" + stringValue + "/\'}, \n";
        }
        /** Old console log tests
        console.log(navBarNames.toString())
        console.log("testing")
        console.log(util.inspect(navBarNames, {depth: null}))
        console.log(navBarNames)
        */
    }
    fs.writeFile("docs/.vuepress/configNavbarDirAuto.txt", util.inspect(navBarNames, {depth: null}), function(err) {
    if(err) {
        return console.log(err);
    }
    console.log("navbar list directory file is saved.");
}); 
    return  navBarNames
    
}

function genNavBarItem(textValue, linkValue) {
    return {
        text: textValue,
        link: linkValue
    }
}