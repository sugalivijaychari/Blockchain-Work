The roadmap for the whole project:

    -> Gathering the features of ICO launching by the company.
    -> Developing smart contracts for the entire project.
    -> Designing the wire frame for the Ui part of the project.
    -> Developing the Ui part.
    -> Interacting the Ui part with smart contracts.
    -> Testing every module of the project.
    -> Deploying smart contracts.
        * Initialising the token name, symbol, decimals, initial supply.
        * Gathering the whitelist addresses of designers, company collegues, investors and partners.
        * Distributing the tokens for the whitelisted candidates.
        * End of Whitelist.
        * Start of the Crowdsale.
        * Setting time intervals for the crowdsale.
        * If discounts on crowdsale prefers, discount on buying tokens decreases by time.
        * End of crowdsale.
        * Distributing all the tokens to crowdsale investors.
    -> Launching the Ui part to all the open markets.
    -> As usual transactions through the tokens.

Note: In this roadmap, extra milestones are added as per company requirements.

    TODO - ALL THE OTHER FEATURES WHICH TO BE DONE CAN BE PLACED HERE.

Installation Instructions:

As per present activities, to develop smart contracts the softwares needed are - Node.js and NPM, truffle, testrpc or ganache-cli, remix ide and meta mask. 
Usage of other softwares and their installation part will be up to the date.

1. Install Node.js and NPM
    
        * Download the appropriate Node.js software through the link : https://nodejs.org/en/download/
        * For detailed installation process, check https://nodesource.com/blog/installing-nodejs-tutorial-windows/
    
2. Install Testrpc or Ganache-cli

        * Before using truffle, we should install choco, git and visual studio code.
        * Install choco through https://chocolatey.org/
        * Now install git through the command 'choco install git –y'
        * Now install Visual Studio Code through command 'choco install VisualStudioCode -y'
        * Now if you aren't installed node, install node via 'npm install -g npm'
        * Now do 'npm install -g -production windows-build-tools'
        * Recently, testrpc is updated with ganache-cli. Install ganache-cli by the command 'npm install -g ganache-cli'. Learn more on Ganache-cli through https://github.com/trufflesuite/ganache-cli
        
3. Install Truffle

        * Install by using command 'npm install -g truffle'
        * Follow https://truffleframework.com/tutorials/ to know more on truffle, testrpc and ganache-cli.
        
4. Metamask

        * Go to https://metamask.io/
        * You will find to add meta mask extension to your browser.
        * Click add extension.
        * Now you will get a window in your task bar of your browser. Select Ropsten Test Network and create a new account.
        * Now you get your wallet appeared.
        * Now click on Buy option to buy the test ether for free through https://faucet.metamask.io/
            * Now click on - Request 1 ether from faucet
            * This will be enough to play with contracts in test network
            * If you want to add more, you can add with same process in future
        * Now in your wallet you will have 1 ether.

5. Remix IDE

        * Open https://remix.ethereum.org
        * This is the online environment in which you will be working with smart contracts by using solidity language.
        * Write your code here.
        * After writing code, you should go to -> Settings -> Select New Compiler Version
            * Note1 : Make sure that you select right compiler version where you used in your contract code.
            * For Example, If you have written your code with 
                * pragma solidity ^0.4.13;
                * You should select below compiler version
                * 0.4.13+commit.fb4cb1a
            * Note2 : Make sure that you check out the optimization for not getting any errors in future.
        * Now write your smart contract with functionalities you need to keep to your new Token.
        * Now you deploy the smart contract using Metamask.
        * Test your transaction status in ropsten test network via https://ropsten.etherscan.io/tx/[transaction address]
        * If it's successful, then your new token is ready.
    
Directory Structure:

        InitialCoinOffering
        ├──build
        ├──├──contracts
        ├──contracts
        ├──├── Crowdsale
        ├──├── Whitelist
        ├──migrations
        
    TODO - ALL THE FUTURE UPDATES CAN BE PLACED HERE.
    
    As per present developing stage of the project, above mentioned are the main directories related to initial coin offering.
    Future developed project directories should be updated without any inconvenience.
    
Architecture:

    Description on various directories:
    
        build/contracts => This directory contains all the JSON files of the smart contracts of the project.
        contracts => usually contains all the smart contracts related to our project.
        contracts/UTCcoin/Crowdsale => All the smart contracts related to crowsale part is placed here.
        contracts/UTCcoin/Whitelist => All the smart contracts related to whitelist part is placed here.
        
    TODO - UPDATES CAN BE PLACED HERE WITH DESCRIPTION
        
Deployment and Migration scripting:

    * Deploying and migrating the smart contracts can be done by using Truffle.
    * Firstly create a directory and name the project.
    * mkdir <project-name>
    * => Now place all the smart contracts in the path: ./project-name/contracts/
    * Now do the below three steps:
        * truffle compile
        * truffle migrate
        * truffle test
    * Now the process of deploying and migrating is done using truffle.
    
KYC Module:

    * Merely now-a-days, illegal activities are allowing with cypto-currencies. But by adding the feature of KYC module, we can resolve this problem.
    * In this KYC module, we take the unique identity of a citizen in India. It's UID.
    * All the data is sent in the form of bytes.
    * We convert that bytes into raw data and pass to the blockchain.
    
    TODO - WIRE FRAME IS TO BE DONE
    TODO - Ui PART IS TO BE DEVELOPED
    TODO - MODULES USED IN UI PART IS TO BE PLACED HERE
    TODO - SCREENSHOTS OF THE UI PART IS TO BE PLACED HERE
