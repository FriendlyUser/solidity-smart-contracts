/**
 * Copyright (c) 2017-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

const React = require('react');

const CompLibrary = require('../../core/CompLibrary.js');
const MarkdownBlock = CompLibrary.MarkdownBlock; /* Used to read markdown */
const Container = CompLibrary.Container;
const GridBlock = CompLibrary.GridBlock;

const siteConfig = require(process.cwd() + '/siteConfig.js');

function imgUrl(img) {
  return siteConfig.baseUrl + 'img/' + img;
}

function docUrl(doc, language) {
  return siteConfig.baseUrl + 'docs/' + (language ? language + '/' : '') + doc;
}

function pageUrl(page, language) {
  return siteConfig.baseUrl + (language ? language + '/' : '') + page;
}

class Button extends React.Component {
  render() {
    return (
      <div className="pluginWrapper buttonWrapper">
        <a className="button" href={this.props.href} target={this.props.target}>
          {this.props.children}
        </a>
      </div>
    );
  }
}

Button.defaultProps = {
  target: '_self',
};

const SplashContainer = props => (
  <div className="homeContainer">
    <div className="homeSplashFade">
      <div className="wrapper homeWrapper">{props.children}</div>
    </div>
  </div>
);

const Logo = props => (
  <div className="projectLogo">
    <img src={props.img_src} />
  </div>
);

const ProjectTitle = props => (
  <h2 className="projectTitle">
    {siteConfig.title}
    <small>{siteConfig.tagline}</small>
  </h2>
);

const PromoSection = props => (
  <div className="section promoSection">
    <div className="promoRow">
      <div className="pluginRowBlock">{props.children}</div>
    </div>
  </div>
);

class HomeSplash extends React.Component {
  render() {
    let language = this.props.language || '';
    return (
      <SplashContainer>
        <Logo img_src={imgUrl('VueDappLogo.png')} />
        <div className="inner">
          <ProjectTitle />
          <PromoSection>
            <Button href="#try">Try It Out</Button>
            <Button href={docUrl('Users.html', language)}>Users Contract</Button>
            <Button href={docUrl('TodoList.html', language)}>TodoList Contract</Button>
          </PromoSection>
        </div>
      </SplashContainer>
    );
  }
}

const Block = props => (
  <Container
    padding={['bottom', 'top']}
    id={props.id}
    background={props.background}>
    <GridBlock align="center" contents={props.children} layout={props.layout} />
  </Container>
);

const Features = props => (
  <Block layout="fourColumn">
    {[
      {
        content: 'Users can create an account through a smart contract.',
        image: imgUrl('TrustLess.png'),
        imageAlign: 'top',
        title: 'Authentication',
      },
      {
        content: 'A simple decentralized todolist, users can add entries.',
        image: imgUrl('TodoList.png'),
        imageAlign: 'top',
        title: 'Todolist ',
      },
    ]}
  </Block>
);

const FeatureCallout = props => (
  <div
    className="productShowcaseSection paddingBottom"
    style={{textAlign: 'center'}}>
    <h2>Feature Callout</h2>
    <MarkdownBlock>These are features of this project</MarkdownBlock>
  </div>
);

const LearnHow = props => (
  <Block background="light">
    {[
      {
        content: 'Trustless systems are massive important in the future with the rest of corrupt organizations abusing their power. For example every major social platofrm minus twitter banning alex jones. IN addition, I believe that blockchain technoogies will revolutionize the way business is done, and be as important if not more important than artifical intelligence. Although the Ethereum blockchain has be superseded by Hedera Hashgraph because of improvements to the blockchain data storage algorithm and the superiority of a Hashgraph, solidity will likely remain useful for a long time to come. Unless security is the most important, I doubt vyper will catch on.',
        image: imgUrl('TrustLess.png'),
        imageAlign: 'right',
        title: 'Learn How',
      },
    ]}
  </Block>
);

const TryOut = props => (
  <Block id="try">
    {[
      {
        content: 'The simplest way to try out this app is to navigate the url. Available on surge,  http://myFirstdApp.surge.sh',
        image: imgUrl('TodoList.png'),
        imageAlign: 'left',
        title: 'Try it Out',
      },
    ]}
  </Block>
);

const Description = props => (
  <Block background="dark">
    {[
      {
        content: 'This project has been invaluable for me learning how to work with vue, solidity, truffle and build decentralized applications. Solidity is used for smart contracts and deployed to the various test networks including kovan, rinkeby and ropsten. For the majority of use cases, I perfer to deploy my contracts to rinkeby, and then kovan. This Vue Dapp has authentication and todolist storage',
        image: imgUrl('VueDappLogo.png'),
        imageAlign: 'right',
        title: 'Description',
      },
    ]}
  </Block>
);

const Showcase = props => {
  if ((siteConfig.users || []).length === 0) {
    return null;
  }
  const showcase = siteConfig.users
    .filter(user => {
      return user.pinned;
    })
    .map((user, i) => {
      return (
        <a href={user.infoLink} key={i}>
          <img src={user.image} alt={user.caption} title={user.caption} />
        </a>
      );
    });

  return (
    <div className="productShowcaseSection paddingBottom">
      <h2>{"Who's Using This?"}</h2>
      <p>This project is used by all these people</p>
      <div className="logos">{showcase}</div>
      <div className="more-users">
        <a className="button" href={pageUrl('users.html', props.language)}>
          More {siteConfig.title} Users
        </a>
      </div>
    </div>
  );
};

class Index extends React.Component {
  render() {
    let language = this.props.language || '';

    return (
      <div>
        <HomeSplash language={language} />
        <div className="mainContainer">
          <Features />
          <FeatureCallout />
          <LearnHow />
          <TryOut />
          <Description />
          {/*<Showcase language={language} /> */}
        </div>
      </div>
    );
  }
}

module.exports = Index;
