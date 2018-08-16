pragma solidity 0.4.24;

import "./CrowdsaleTokens.sol";

// This contract is used to destroy an account in crowdsale

contract CrowdsalesAction is CrowdsaleTokens{
    
    // Whether the request to destory for an investor is accepted or not
    mapping(address => bool) requestedDestroy;

    // Finalize the request of investor by owner
    mapping(address => bool) finalizeRequest;

    // Whether request is accepted or not 
    mapping(address => bool) acceptedDestroy;

    // Whether opinion to destory changed or not
    mapping(address => uint256) opinionsChanged;
    
    event RequestToDestroy(uint256 _uniqueId, address _buyerAddr, bool _opinion);
    event DestroyCrowdsaler(uint256 _uniqueId, address _buyerAddr, uint256 _finalAmount);
    
    /**
     * The functions mentioned in this contract are 
     * very dangerous functions which
     * destroys his/her investment in crowdsale and he no longer
     * can make use of this ICO
     * Eventhough this gonna be a critical decision, but we can't judge future
     * as well inverstor have his own liberty to be a part of this
     * system or not.
     * In that aspect, this contract is developed!!
     */
    
    /**
     * @dev - Request to destroy by Id
       @param _uniqueId - THe unique id of the investor
       @param _opinion - Boolean value to destroy tokens or not in crowdsale
       @return - Whether this operation got success or not
     */
    function requestToDestroyById(uint256 _uniqueId, bool _opinion) public _safeCrowdsale returns(bool){

        // The address of the crowdsaler
        address _buyerAddr = crowdsaleAccounts[_uniqueId];

        // Operation got success or not
        bool success = requestToDestroy(_uniqueId, _buyerAddr,_opinion);
        return success;
    }
    
    /**
     * @dev - This function is usde to request the owner to destroy investors account in this crowdsale
       @param _uniqueId - The unique id of the investor
       @param _buyerAddr - The address of the investor
       @param _opinion - Whether the operation is success or not
     */
    function requestToDestroy(uint256 _uniqueId, address _buyerAddr, bool _opinion) public _safeCrowdsale returns(bool){
        
        // The investor must not be whitelist participant
        require(!activeWhitelist[_buyerAddr]);

        // It must not be a frozen account
        require(!frozenAccount[_buyerAddr]);

        // It must not already finalized the opinion
        require(!finalizeRequest[_buyerAddr]);

        // Requesting to destroy makes to true
        requestedDestroy[_buyerAddr] = _opinion;

        // How many times opinions changed to destory the account
        opinionsChanged[_buyerAddr] = opinionsChanged[_buyerAddr].add(1);
        emit RequestToDestroy(_uniqueId, _buyerAddr, _opinion);
        return true;
    }
    
    /**
     * @dev - Owner accepts the request to destory the account of the crowdsale
       @param _uniqueId - The unique id of the crowdsaler 
       @param _buyerAddr - The address of the investor
       @param _opinion - The opinion of the investor
       @return - It checks whether the operation is success or not
     */
    function acceptToDestroy(uint256 _uniqueId, address _buyerAddr, bool _opinion) public onlyOwner _safeCrowdsale returns(bool){
        
        // The investor must not be a whitelist candidate
        require(!activeWhitelist[_buyerAddr]);

        // The investor account must not be frozen
        require(!frozenAccount[_buyerAddr]);

        // The request to destroy from the investor must be true
        require(requestedDestroy[_buyerAddr]);

        // opinion is stored
        acceptedDestroy[_buyerAddr] = _opinion;

        if(_opinion == true){

            // It assigns the final request as true
            finalizeRequest[_buyerAddr] = true;

            // It freezes the account
            freezeAccount(_buyerAddr, _opinion);

            // It makes investor as unholder of tokens
            isATokenHolder[_buyerAddr] = false;

            //It makes investor as not valid 
            isACrowdsaleAccountant[_uniqueId] = false;

            // Final amount of investor is calculated
            uint256 _finalAmount = addedTokens[_buyerAddr];

            // Final amount of investor is calculated in the form of wei amount
            uint256 _weiAmount = addedWeiAmount[_buyerAddr];

            // Tokens reduces in investors account
            addedTokens[_buyerAddr] = addedTokens[_buyerAddr].sub(_finalAmount);

            // Tokens reduces in investors account in wei calculation
            addedWeiAmount[_buyerAddr] = addedWeiAmount[_buyerAddr].sub(_weiAmount);

            // Amount is reduced in ordered tokens
            orderedTokens = orderedTokens.sub(_finalAmount);

            // Amount is reduced in wei amount
            orderedWeiAmount = orderedWeiAmount.sub(_weiAmount);

            // Amount is reduced in total supply
            totalSupply_ = totalSupply_.sub(_finalAmount);
        }

        // Intimates Ui about the destoying of the account
        emit DestroyCrowdsaler(_uniqueId, _buyerAddr, _finalAmount);
        return _opinion;
    }
    
}




