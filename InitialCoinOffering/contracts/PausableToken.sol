pragma solidity 0.4.24;

/** This contract is used to retain the functionalities of ERC20 with pause and unpause */

import "./StandardToken.sol";
import "./Pausable.sol";

contract PausableToken is StandardToken, Pausable {

  /**
   * @dev - This transfer function includes pause functionality
     @param _to - The address of the receiver
     @param _value - The amount of tokens to be transferred
     @return - It checks whether the operation is success or not
   */
  function transfer(address _to, uint256 _value) public whenNotPaused returns (bool) {
    return super.transfer(_to, _value);
  }

  /**
   * @dev - This transfer From function includes pause functionality
     @param _from - The address of the receiver
     @param _to - The address of the receiver
     @param _value - The amount of tokens to be transferred
     @return - It checks whether the operation is success or not
   */
  function transferFrom(address _from, address _to, uint256 _value) public whenNotPaused returns (bool) {
    return super.transferFrom(_from, _to, _value);
  }

  /**
   * @dev - This funciton is used give approval for an address to spend some amount of tokens from our own address
     @param _spender - The address of the receiver
     @param _value - The amount of tokens to be approved for transfer of tokens
     @return - Confirms whether this operation is success or not.
   */
  function approve(address _spender, uint256 _value) public whenNotPaused returns (bool) {
    return super.approve(_spender, _value);
  }

  /**
   * @dev - This function is used to increase the approval amount to an address
     @param _spender - The address in which approved tokens to be added
     @param _addedValue - The amount of tokens to be added
     @return - confirms whether this operation is success or not
   */
  function increaseApproval(address _spender, uint _addedValue) public whenNotPaused returns (bool success) {
    return super.increaseApproval(_spender, _addedValue);
  }

  /**
   * @dev - This function is used to decrease the approval amount to an address
     @param _spender - The address in which approved tokens to be subtracted
     @param _subtractedValue - The amount of tokens to be subtracted
     @return - confirms whether this operation is success or not
   */
  function decreaseApproval(address _spender, uint _subtractedValue) public whenNotPaused returns (bool success) {
    return super.decreaseApproval(_spender, _subtractedValue);
  }
}
