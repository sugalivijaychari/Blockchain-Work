pragma solidity 0.4.24;

import "./Whitelist.sol";

/** This contract is used to distribute the tokens to whitelist investors */

contract WhitelistDistribution is Whitelist{
    

    event DistributeTokensById(uint256);
    event DistributeTokensByAddress(address);

    // This funciton is used to distribute tokens by id
    function distributeTokensById(uint256 _uniqueId)onlyOwner public returns(bool){

        // Getting investor address using its unique id
        address accountAddress = investors[_uniqueId];

        // Investor must be active
        require(activeWhitelist[investors[_uniqueId]]);

        // Token system must not be in paused state
        require(!paused);

        // Tokens must not be distributed to the investor
        require(!isTokensDistributed[accountAddress]);

        // The investor address must not be in freezed mode
        require(!frozenAccount[accountAddress]);

        // The amount to tokens to distribute
        uint256 amount = tokensInvested[investors[_uniqueId]];

        // Transfers amount to the investor
        transfer(investors[_uniqueId], amount);

        // Amount of tokens are added to the distribution count of tokens
        distributedTokens = distributedTokens.add(amount);

        // Intimates Ui about the distribution of tokens
        emit DistributeTokensById(_uniqueId);

        // Returns true after the successful completion of above operations
        return true;
    }
    
    // This function is used to distribute tokens from the investor address
    function distributeTokensByAddress(address _investorAddr)onlyOwner public returns(bool){

        // The address of the investor
        address accountAddress = _investorAddr;

        // Token system must not be in a paused state
        require(!paused);

        // Tokens must not be distributed to the investor
        require(!isTokensDistributed[accountAddress]);
        
        // The investor account must not be in freezed mode
        require(!frozenAccount[accountAddress]);

        // The account must be active in whitelist process
        require(activeWhitelist[_investorAddr]);

        // Amount of tokens to distribute to the investor
        uint256 amount = tokensInvested[_investorAddr];

        // Tranferring tokens to the investor
        transfer(_investorAddr, amount);

        // Increaments tokens in distribution data
        distributedTokens = distributedTokens.add(amount);

        // Intimates Ui about the distribution of tokens
        emit DistributeTokensByAddress(_investorAddr);

        // Returns true after the successful completion of above process
        return true;
    }
    
}