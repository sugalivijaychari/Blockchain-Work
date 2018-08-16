pragma solidity 0.4.24;

import "./FreezableToken.sol";

/** This contract is used to mint some amount of tokens */

contract MintableToken is FreezableToken{
  
  // The count of the total minted tokens upto now from starting of the token system
  uint256 mintedTokensCount;    
  event Mint(address indexed to, uint256 amount);
  event MintFinished();

  // It is used whether minting is finished or not.
  bool public mintingFinished = false;

  modifier canMint() {
    require(!mintingFinished);
    _;
  }
  
  /** 
   * @dev - This function is used to mint tokens to the particular account.
     @param _to - The address to which we mint the tokens
     @param _amount - The amount of tokens to mint
     @return - It checks whether minting is finished or not.
   */
  function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {

    // It increases the total supply with given amount of tokens.
    totalSupply_ = totalSupply_.add(_amount);
    //It increases the balance of given address with minting amount.
    balances[_to] = balances[_to].add(_amount);
    // It increases the total minting amount.
    mintedTokensCount = mintedTokensCount.add(_amount);
    emit Mint(_to, _amount);
    emit Transfer(address(0), _to, _amount);
    return true;
  }

  /**
   * @dev - This function is used to intimate that minting is finished.
     @return - It checks whether the operation is success or not.
   */
  function finishMinting() onlyOwner canMint public returns (bool) {
    mintingFinished = true;
    emit MintFinished();
    return true;
  }
}
