pragma solidity 0.4.24;

import "./SafeCrowdsale.sol";

/** This contract is used to participate in crowdsale */

contract CrowdsaleTokens is SafeCrowdsale{
    
    event CalculateTokens(uint256 _weiAmount);
    event BuyCrowdsale(uint256 _uniqueId, address _buyerAddr, uint256 _weiAmount, uint256 _sellingPricePerToken, uint256 _finalAmount);
    
    /**
     * @dev - It calculates the tokens for the actual ethers
       @param _weiAmount - Wei amount got by the transaction
       @param _sellingPricePerToken - The selling price per token
       @return - The calculated amount of tokens
     */
    function calculateTokens(uint256 _weiAmount, uint256 _sellingPricePerToken) public returns(uint noOfTokens){
        require((_weiAmount>0)&&(_sellingPricePerToken>0));
        uint amount = _weiAmount;
        amount = amount.div(_sellingPricePerToken);
        emit CalculateTokens(_weiAmount);
        return amount;
    }
    
    /**
     * @dev - Buy tokens with Id
       @param _uniqueId - The unique Id of the investor
       @param _sellingPricePerToken - The selling price per token
       @return - It check whether the operation is success or not
     */
    function buyCrowdsaleLocalAccount(uint256 _uniqueId, uint256 _sellingPricePerToken) _safeCrowdsale public payable returns(bool){
        
        // Wei amount is calculated
        uint256 _weiAmount = msg.value;

        // The address of the investor
        address _buyerAddr = msg.sender;

        // Buying tokens
        bool success = buyCrowdsale(_uniqueId, _weiAmount, _buyerAddr, _sellingPricePerToken);
        return success;
    }
    
    /**
     * @dev - Buy tokens to other account address
       @param _uniqueId - The unique Id of the investor
       @param _buyerAddr - The address of the investor
       @param _sellingPricePerToken - The selling price per token
       @return - It check whether the operation is success or not
     */
    function buyCrowdsaleToOtherAccount(uint256 _uniqueId, address _buyerAddr, uint256 _sellingPricePerToken) _safeCrowdsale public payable returns(bool){
        uint256 _weiAmount = msg.value;
        bool success = buyCrowdsale(_uniqueId, _weiAmount, _buyerAddr, _sellingPricePerToken);
        return success;
    }
    
    /**
     * @dev - This fucntion is used to buy the tokens in crowdsale
       @param _uniqueId - The unique id of the investor
       @param _weiAmount - The wei amount spending to buy the tokens
       @param _sellingPricePerToken - The selling price per token
       @return - It checks whether the operation got success or not
     */
    function buyCrowdsale(uint256 _uniqueId, uint256 _weiAmount, address _buyerAddr, uint256 _sellingPricePerToken) _safeCrowdsale internal returns(bool){
        
        // The investor must not be a whitelist participant
        require(!activeWhitelist[_buyerAddr]);

        // THe account must not be frozen
        require(!frozenAccount[_buyerAddr]);

        // The investing amount must be greater than zero
        require(_weiAmount> 0);

        // It calculates the final amount of tokens from wei amount
        uint256 _finalAmount = calculateTokens(_weiAmount, _sellingPricePerToken);

        // Ordered tokens must not increase to the targetted amount
        require((orderedTokens.add(_finalAmount)) <= targetAmountOfTokens);

        // Investing amount of tokens must not over breech the minimum amount of tokens
        require(addedTokens[_buyerAddr].add(_finalAmount)>=minAmountOfTokens);
        if(!isATokenHolder[_buyerAddr]){

            // It count the number of investors participated in crowdsale
            crowdsalersCount = crowdsalersCount.add(1);
        }

        // It assigns the address to the unique id through mapping
        crowdsaleAccounts[_uniqueId] = _buyerAddr;

        // Tokens must be added to the investors account
        addedTokens[_buyerAddr] = addedTokens[_buyerAddr].add(_finalAmount);

        // Wei maount is updated to the wei amount data of the investor
        addedWeiAmount[_buyerAddr] = addedWeiAmount[_buyerAddr].add(_weiAmount);

        // Ordered tokens must be added by the amount of tokens invested here
        orderedTokens = orderedTokens.add(_finalAmount);

        // Ordered tokens must be added by the wei amount of tokens invested here
        orderedWeiAmount = orderedWeiAmount.add(_weiAmount);

        // Declares the investor as a crowdsale accountant
        isACrowdsaleAccountant[_uniqueId] = true;

        // Declares the crowdsaler holds some tokens
        isATokenHolder[_buyerAddr] = true;

        // Invested amount of tokens is added to the total supply
        totalSupply_ = totalSupply_.add(_finalAmount);

        // Wei amount is added to the owner
        assert(!owner.send(_weiAmount));

        // Intimates Ui about the Buying crowdsale 
        emit BuyCrowdsale(_uniqueId, _buyerAddr, _weiAmount, _sellingPricePerToken, _finalAmount);
        return true;
    }
    
}