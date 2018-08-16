pragma solidity 0.4.24;

import "../MintableToken.sol";

/** This contract is used to have all the details of whitelist */

contract Whitelist is MintableToken{
    
    // The time in which whitelist starts by
    uint256 public startsAt;

    // The time by which whitelist ends by
    uint256 public endsAt;// This gonna be the starting time of crowdsale
    
    // Unique ids for all the whitelist users
    uint256[] public uniqueIds;

    // Count of the whitelist investors
    uint256 public whiteListCount;

    // No. of tokens that are bought by whitelist investors
    uint256 public whiteListTokensCount;

    // No. of tokens that are distributed in whitelist process
    uint256 public distributedTokens;

    // Tells whether the end time of whitelist is changed or not.
    bool public _isEndTimeChanged;
    
    // The limit to buy tokens per account
    uint256 public limitOfTokensPerInvestor;

    // The limit count of investors to participate in whitelist
    uint256 public limitOfInvestors;

    // The limit for overall tokens will there in whitelist process
    uint256 public limitOfTotalTokens;

    // Tells whether there is a limit or not
    bool public limitEnable;
    
    // Tells whether a whitelist investor address account is active or not
    mapping(address => bool) public activeWhitelist;

    // Maps investor addresses with unique ids
    mapping(uint256 => address) public investors;

    // Maps investors address with bought tokens
    mapping(address => uint256) public tokensInvested;

    // Tells whether whitelist investor address got tokens or not
    mapping(address=>bool)public isTokensDistributed;

    /** 
     * @dev - This function sets end and starting time of the whitelist process
       @param _startsAt - The starting time of the whitelist process
       @param _endsAt - The ending period of the whitelist
       @return - It tells whether we set timings or not
     */
    function setTimings(uint256 _startsAt,uint256 _endsAt)onlyOwner public returns(bool){

        // Starting time must be less than ending time
        require(_startsAt<_endsAt);
        startsAt = _startsAt;
        endsAt = _endsAt;
        return true;
    }
    
    /** 
     * @dev - This function assigns whether we need limit or not
       @param _limitEnable - The boolean value to enable limit or not
     */
    function enableLimits(bool _limitEnable)public onlyOwner{
        
        limitEnable = _limitEnable;
    }
    
    /** 
     * @dev - This funciton is used to set the limits.
       @param _limitOfTokensPerInvestor - The limit to buy tokens per account
       @param _limitOfInvestors - The limit count of investors to participate in whitelist
       @param _limitOfTotalTokens - The limit for overall tokens will there in whitelist process
       @return - Checks whether this process is success or not
     */
    function setLimits(uint256 _limitOfTokensPerInvestor,uint256 _limitOfInvestors, uint256 _limitOfTotalTokens)public onlyOwner returns(bool){
        require((_limitOfTokensPerInvestor>0)&&(_limitOfInvestors>0)&&(_limitOfTotalTokens>0));
        limitOfTokensPerInvestor = _limitOfTokensPerInvestor;
        limitOfInvestors = _limitOfInvestors;
        limitOfTotalTokens = _limitOfTotalTokens;
        return true;
    }
    
    // Checks whether input account have right to include in whitelist or not
    modifier validAccount{
        require(whiteListCount<limitOfInvestors && whiteListTokensCount<limitOfTotalTokens);
        _;
    }
    
    // Checks whether input account get chance to have whitelist account in the right time or not.
    modifier validTime{
        require(now>=startsAt && now<endsAt);
        _;
    }
    
    event AddInvestor(uint256 _uniqueId, address investorAddr, uint256 _tokensInvested);
    
    /**
     * @dev - This function is used to add a new investor in the whitelist process
       @param _uniqueId - The unique id for whitelist investor
       @param investorAddr - The address of the whitelist investor
       @param _tokensInvested - The amount of tokens that investor is invested
       @return - Checks whether a new investor is added or not.
     */
    function addInvestor(uint256 _uniqueId, address investorAddr, uint256 _tokensInvested) onlyOwner validTime validAccount public returns(bool){
        
        // Only owner adds a new investor
        require(msg.sender == owner);
        
        // Investing tokens must be greater than zero and must not cross the limit
        require((_tokensInvested>0)&&(_tokensInvested<=limitOfTokensPerInvestor));

        // The tokens system must not be in paused state
        require(!paused);

        // It adds the tokens count in whitelist
        whiteListTokensCount = whiteListTokensCount.add(_tokensInvested);

        // Unique ids are placed in one place
        uniqueIds.push(_uniqueId);

        // Assigns a address with unique id for an investor
        investors[_uniqueId] = investorAddr; 

        // Assign invested tokens to the whitelist investor
        tokensInvested[investorAddr] = _tokensInvested;
        mint(owner, _tokensInvested);

        // Increaments whitelist investors count
        whiteListCount +=1;

        // Assigns active to the whitelist investor
        activeWhitelist[investorAddr]=true;

        // Assigns tokens distributed to investor as true
        isTokensDistributed[investorAddr]=true;
        emit AddInvestor(_uniqueId, investorAddr, _tokensInvested);
        return true;
    }
    
    /**
     * @dev - This fucntion is used to extend the end time
       @param _endsAt - The end time of the whitelist
       @return - The boolean value tells whether this process is success or not
     */
    function extendEndTime(uint256 _endsAt)onlyOwner public returns(bool){
        require(_endsAt>startsAt);
        endsAt = _endsAt;
        _isEndTimeChanged = true;
        return true;
    }
    
    /**
     * @dev - This function reduces the end time
       @param _endsAt - The time of the ending period of the whitelist
       @return - It tells whether this operation is success or not
     */
    function reduceEndTime(uint256 _endsAt) onlyOwner public returns(bool){
        require(_endsAt>startsAt);
        endsAt = _endsAt;
        _isEndTimeChanged = true;
        return true;
    }
    
}