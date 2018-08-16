pragma solidity 0.4.24;

import "../Whitelist/Whitelist.sol";

/** This contract is used to combine all the basic requirements of a Crowdsale at one place */

contract CrowdsaleCredentials is Whitelist{

    // The starting time of the crowdsale
    uint256 public startTime;

    // The end time of the crowdsale
    uint256 public endTime;

    // The target amount of tokens to reach on crowdsale
    uint256 public targetAmountOfTokens;

    // Minimum amount of tokens to invest in crowdsale
    uint256 public minAmountOfTokens;

    // Total number of tokens supplied upto now
    uint256 public suppliedTokens;

    // Total number of tokens ordered upto now
    uint256 public orderedTokens;

    // Total number of tokens ordered in the form of wei amount
    uint256 public orderedWeiAmount;

    // Count of the investors in crowdsale
    uint256 public crowdsalersCount;

    // Count of investors to which tokens are already supplied upto now
    uint256 public suppliedCrowdsalersCount;
    
    // Corwdsalers addresses are mapped to the unique ids
    mapping(uint256 => address) public crowdsaleAccounts;

    // No. of tokens of crowdsalers are stored here
    mapping(address => uint256) public addedTokens;

    // No. of tokens of crowdsalers are stored here in the form of wei amount
    mapping(address => uint256) public addedWeiAmount;

    // To find whether a crowdsaler is valid to this token sale
    mapping(uint256 => bool) public isACrowdsaleAccountant;

    // Whether an address holds tokens or not
    mapping(address => bool) public isATokenHolder;

    // It tells whether an address got tokens or not
    mapping(address => bool) public isTokensSupplied;
    
    // This function sets starting time to the crowdsale
    function setStartTime() public onlyOwner returns(bool){

        // The starting time of the crowdsale is the ending time of the whitelist
        require(startTime>=endsAt);
        startTime = endsAt;
        return true;
    }
    
    /**
     * @dev - This function sets the end time for the crowdsaler
       @param _endtime - The end time of the crowdsale
       @return - Whether the operation is success or not
     */
    function setEndTime(uint256 _endtime) public onlyOwner returns(bool){

        // end time must be greater than starting time
        // It checks off the human typo error
        require(_endtime >startTime);
        endTime = _endtime;
        return true;
    }
    
    /**
     * @dev - It is used to change the starting time
       @param _startTime - The starting time of the crowdsale
       @return - Checks whether the operation is success or not
     */
    function resetStartTime(uint256 _startTime) public onlyOwner returns(bool){

        // The starting time must be greater than the ending time
        require(_startTime <endTime);
        startTime = _startTime;
        return true;
    }
    
    /**
     * @dev - It is used to set the ending time of the crowdsale
       @return - It checks whether the operation got success or not
     */
    function resetEndTime(uint256 _endtime) public onlyOwner returns(bool){

        // End time must be greater than starting time
        require(_endtime>startTime);
        endTime = _endtime;
        return true;
    }
    
    /**
     * @dev - It sets the target for overall investment of tokens 
       @param _targetAmount - The target amount of investment in crowdsale
       @return - It check whether the operation is success or not 
     */
    function setTargetAmountOfTokens(uint256 _targetAmount) public onlyOwner returns(bool){

        // Amount must be greater than zero
        require(_targetAmount>0);
        targetAmountOfTokens = _targetAmount;
        return true;
    }
    
    /**
     * @dev - This function is used to set minimum amount of tokens to invest per investor in crowdsale
       @param _minAmount - The minimum amount ot invest
       @return - it checks whether the operation got success or not
     */
    function setMinimumAmountOfTokens(uint256 _minAmount) public onlyOwner returns(bool){

        // Minimum amount must be less than target amount
        require(_minAmount<=targetAmountOfTokens);
        minAmountOfTokens = _minAmount;
        return true;
    }
    
}