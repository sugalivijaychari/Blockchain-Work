pragma solidity 0.4.24;

import "./Whitelist.sol";

/** This contract is used to know the details of each and every details of whitelist process*/

contract WhitelistInfo is Whitelist{
    
    event DisplayInvestorTokens(address _investorAddr);
    
    // It displays the starting time of the whitelist process
    function displayStartTime()public view returns(uint256){
        return startsAt;
    }

    // It displays the ending time of the whitelist
    function displayEndTime()public view returns(uint256){
        return endsAt;
    }
    
    // This is used to know this time is valid for whitelist or not
    function isThisValidTime() public view returns(bool){
        return (now>=startsAt && now<endsAt);
    }
    
    // This is used to know the total tokens counted in whitelist process
    function displayWhiteInvestment()public view returns(uint256){
        return whiteListTokensCount;
    }
    
    // To know the tokens invested by a whitelist investor
    function displayInvestorTokens(address _investorAddr)public returns(uint256){
        require(isTokensDistributed[_investorAddr]);
        require(activeWhitelist[_investorAddr]);
        emit DisplayInvestorTokens(_investorAddr);
        return tokensInvested[_investorAddr];
    }
    
    // To display the count of distributed tokens till now
    function displayDistributedTokens()public view returns(uint256){
        return distributedTokens;
    }
    
    // To display how many tokens are left to distribute
    function displayDistributableTokens()public view returns(uint256){
        return whiteListTokensCount.sub(distributedTokens);
    }
    
    // TO know whether ending time of whitelist investment is extended or not
    function isEndTimeExtended()public view returns(bool){
        return _isEndTimeChanged;
    }
    
}