pragma solidity 0.4.24;

import "./MintableToken.sol";

/** This contract limits the minting amount */

contract LimitMintToken is MintableToken {

  // The value of the limit amount.
  uint256 public limit;

  //It creates limit amount.
  constructor(uint256 _limit) public {
    require(_limit > 0);
    limit = _limit;
  }

  /** 
   * @dev - This function is used to mint tokens to the particular account according to the limit amount.
     @param _to - The address to which we mint the tokens
     @param _amount - The amount of tokens to mint
     @return - It checks whether minting is finished or not.
   */
  function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {

    // Amount must be limited according to the limit mentioned
    require(totalSupply_.add(_amount) <= limit);

    return super.mint(_to, _amount);
  }

}
