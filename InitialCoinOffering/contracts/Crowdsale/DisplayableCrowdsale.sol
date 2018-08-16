pragma solidity 0.4.24;

import "./CrowdsalesAction.sol";

/** This contract is used to display all the details that are related to crowdsale */

contract DisplayableCrowdsale is CrowdsalesAction{
    
    // Whether the crowdsale is paused or not
    bool public _isCrowdsalePaused = (crowdsaleStatus && paused);
    
    // Gives whether the crowdsale is paused or not
    function isCrowdsalePaused() public view returns(bool){
        return _isCrowdsalePaused;
    }
    
    // It displays the starting time of the crowdsale
    function viewStartTime()public view returns(uint256){
        return startTime;
    }
    
    // It displays the end time of the crowdsale
    function viewEndTime()public view returns(uint256){
        return endTime;
    }
    
    // It gives whether the crowdsale is active or not
    function isCrowdsaleActive()public view returns(bool){
        return (_isCrowdsalePaused && (now>=startTime && now<endTime) );
    }
    
    // It gives the target amount of tokens for the crowdsale
    function viewTargetTokens()public view returns(uint256){
        return targetAmountOfTokens;
    }
    
    // It gives the minimum amount of tokens to invest per investor in crowdsale
    function viewMinimumTokens()public view returns(uint256){
        return minAmountOfTokens;
    }
    
    // It gives the amount of tokens ordered upto now in crowdsale
    function viewOrderedTokens()public view returns(uint256){
        return orderedTokens;
    }
    
    // It gives the amount of wei amount ordered in crowdsale
    function viewOrderedWeiAmount()public view returns(uint256){
        return orderedWeiAmount;
    }
    
    // It gives the count of the investors of crowdsale
    function viewCrowdsalersCount()public view returns(uint256){
        return crowdsalersCount;
    }
    
    // It gives the address of the crowdsaler by its Id
    function viewAddressOfCrowdsaleId(uint256 _uniqueId)public view returns(address){
        return crowdsaleAccounts[_uniqueId];
    }
    
    // It gives the amount of tokens had to the crowdsaler
    function viewIncentiveOfCrowdsaler(address _crowdsalerAddr) public view returns(uint256){
        return addedTokens[_crowdsalerAddr];
    }
    
    // It gives the amount of wei added by crowdsaler
    function weiAddedByCrowdsaler(address _crowdsalerAddr) public view returns(uint256){
        return addedWeiAmount[_crowdsalerAddr];
    }
    
    // It gives the status of investor whether he is active or not
    function viewStatusOfCrowdsaler(uint256 _uniqueId, address _crowdsalerAddr) public view returns(bool){
        return ((isACrowdsaleAccountant[_uniqueId])&&(isATokenHolder[_crowdsalerAddr]));
    }
    
    // It checks whether the crowdsaler left from the crowdsale or not
    function isCrowdsalerLeft(address _crowdsalerAddr) public view returns(bool){
        return (finalizeRequest[_crowdsalerAddr] && acceptedDestroy[_crowdsalerAddr]);
    }
    
    // It checks whether the crowdsaler kept request to destory its account or not
    function isCrowdsalerRequestedToLeft(address _crowdsalerAddr)public view returns(bool){
        return (requestedDestroy[_crowdsalerAddr]);
    }
    
    // It gives how many times an investor requested to destory its acount
    function crowdsalerOpinionsCount(address _crowdsalerAddr)public view returns(uint256){
        return opinionsChanged[_crowdsalerAddr];
    }
    
}







