pragma solidity 0.4.24;

import "./CrowdsalesAction.sol";
import "./DisplayableCrowdsale.sol";

/** This contract is used to supply the tokens to the investors of the crowdsale */

contract SuppliableCrowdsale is CrowdsalesAction,DisplayableCrowdsale{
    

    uint256 public _validSupplyTime;
    
    event SupplyTokens(uint256 _uniqueId, address _crowdsalerAddr, uint256 value);
    
    // This function is used to know whether a period is valid to supply the tokens to the investors
    function validSupplyTime() public view returns(bool){
        require(!paused);
        require((now>startTime)&&(now>endTime)&&(!crowdsaleStatus)&&(!isCrowdsaleActive()));
        return true;
    }
    
    // Owner can supply tokens in valid time
    modifier canSupply{
        require(validSupplyTime());
        _;
    }
    
    /**
     * @dev - This function is used to supply the tokens to the investors of crowdsale
       @param _uniqueId - The unique id of the investor
       @param _crowdsalerAddr - The address of the investor in crowsale
       @return - It checks whether the operation got success or not
     */
    function supplyTokens(uint256 _uniqueId, address _crowdsalerAddr) public onlyOwner canSupply returns(bool){
        
        // Investor must not be whitelist participant
        require(!activeWhitelist[_crowdsalerAddr]);

        // This account must not be frozen
        require(!frozenAccount[_crowdsalerAddr]);

        // Investor must not have requested to destroy account 
        require(!finalizeRequest[_crowdsalerAddr]);

        // This address must not be destroyed
        require(!acceptedDestroy[_crowdsalerAddr]);

        // There must be minimum amount of tokens to participate in crowdsale
        require((addedTokens[_crowdsalerAddr]>0)&&(addedWeiAmount[_crowdsalerAddr]>0));

        // Investor must not be an active crrowdsale accountant in previous
        require(!isACrowdsaleAccountant[_uniqueId]);

        // Investor must not be a token holder in previous
        require(!isATokenHolder[_crowdsalerAddr]);

        // Tokens must not have supplied already
        require(!isTokensSupplied[_crowdsalerAddr]);

        // The amount of tokensto supply for an investor of crowdsale
        uint256 amount = addedTokens[_crowdsalerAddr];

        // Supplied tokens of investor got updated
        suppliedTokens = suppliedTokens.add(amount);

        // Increases crowdsalers count
        suppliedCrowdsalersCount = suppliedCrowdsalersCount.add(1);

        // It allocates investor address to supplied mode
        isTokensSupplied[_crowdsalerAddr] = true;

        // Transfers tokens to investor
        transfer(_crowdsalerAddr, amount);

        // Intimates Ui about this supply tokens operation
        emit SupplyTokens(_uniqueId, _crowdsalerAddr, amount);

        // it returns true when above operations gets successfully completed
        return true;
        
    }
    
}