Before creating any token we should practise and verify our contracts in a test network which is a best practise.
In this document, we described how to create a new UTCToken in a test network.

Softwares and Tools we need are:
1. testrpc
2. meta mask extension in any browser
3. online remix ide

1.Installation Process of TestRPC:
    Note: Before we install TestRPC, we need Node to be installed in our system.
    
    a. Open Command Prompt and type below command and hit enter
        npm install -g ethereumjs-testrpc
    b. Open a new command prompt in admin mode and type below command and hit enter.
        admin$testrpc
        
    Now, you will get sample 10 addresses to work with your test netorks.
    
2.Installation Process of Meta Mask:

    a. Go to https://metamask.io/
    b. You will find to add meta mask extension to your browser.
    c. Click add extension.
    d. Now you will get a window in your task bar of your browser. Select Ropsten Test Network and create a new account.
    e. Now you get your wallet appeared.
    f. Now click on Buy option to buy the test ether for free through https://faucet.metamask.io/
        Now click on - Request 1 ether from faucet
        This will be enough to play with contracts in test network
        If you want to add more, you can add with same process in future
    g. Now in your wallet you will have 1 ether.
    
3.Using Remix IDE online

    a. Open https://remix.ethereum.org
    b. This is the online environment in which you will be working with smart contracts by using solidity language.
    c. Write your code here.
    d. After writing code, you should go to -> Settings -> Select New Compiler Version
        Note1 : Make sure that you select right compiler version where you used in your contract code.
        For Example, If you have written your code with 
            pragma solidity ^0.4.13;
        You should select below compiler version
            0.4.13+commit.fb4cb1a
        Note2 : Make sure that you check out the optimization for not getting any errors in future.
    e. Now write your smart contract with functionalities you need to keep to your new Token.
    f. Now you deploy the smart contract using Metamask.
    g. Test your transaction status in ropsten test network via https://ropsten.etherscan.io/tx/[transaction address]
    f. If it's successful, then your new token is ready.
    
Verifying our contract:

    a. Open https://ropsten.etherscan.io/verifyContract
    b. Fill the contract address, contract name, compiler version and optimisation details correctly.
    c. Paste the code you wrote in online remix IDE.
    d. Verify and Publish your Contract. Now your contract is publicly visible to every node in Ropsten test network.
    e. To check and do operations with this contract, go to https://ropsten.etherscan.io/address/[contract address].
    
Simple way of doing transactions with newly created Token:

    a. Open https://www.myetherwallet.com/
    b. Select Ropsten Test Network.
    c. Choose option -> Send Ethers & Tokens
    d. Add custom token.
    e. Fill the details like Contract address, Token Symbol and decimals and click add.
    f. Now you can do transactions with this web interface.
    g. You can check your token balances in Metamask also.
    
Note that this is the process where we test our contracts before creating and applying our new token or crypto currency into the market.
To do that in Ethereum Main Network and for friendly usage of our new token by users, we need a User Interface to integrate with our smart contracts.
Choosing a user interface type and developing is important like choosing on website, desktop application or mobile application for user friendly usage.
To achieve that, we need to aware of Solidity, Web3.js, Truffle and Javascript libraries such as React.js, Node.js and so on.
    
