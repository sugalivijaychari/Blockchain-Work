pragma solidity 0.4.24;

import "./FreezableToken.sol";

/** This contract is used to buy and sell the tokens in ethers */

contract ExchangeableToken is FreezableToken{
    
    // The selling price of a token.
    uint256 public sellingPrice;

    // The buying price of a token.
    uint256 public buyingPrice;
    
    /**
     * @dev - This function sets the selling and buying prices for the token.
       @param _sellingPrice - The price to sell
       @param _buyingPrice - The price to buy
     */
    function setExchangePrices(uint256 _sellingPrice, uint256 _buyingPrice)public onlyOwner{
        sellingPrice = _sellingPrice;
        buyingPrice = _buyingPrice;
    }
    
    /**
     * @dev - This function is used to buy tokens
       @return - Amount of tokens that are bought.
     */
    function buyTokens()public payable returns(uint256 amount){
        amount = msg.value/buyingPrice;

        // After buying our tokens with ethers, such amount is transferred to bought person.
        transferFrom(this,msg.sender,amount);
    }
    
    /**
     * @dev - This function is used to sell the tokens 
       @param amount - This function is used to sell this amount of tokens
     */
    function sellTokens(uint256 amount)public{
        address myAddress = this;

        // Minimum balance should be there according to selling price.
        require(myAddress.balance >= amount*sellingPrice);
        transferFrom(msg.sender,this,amount);
        // It transfers ethers to his ethereum account.
        msg.sender.transfer(amount*sellingPrice);
    } 
    
}