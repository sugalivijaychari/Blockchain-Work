pragma solidity 0.4.24;

import "./BasicToken.sol";
import "./Ownable.sol";

/** This contract is used to burn some amount of tokens */

contract BurnableToken is BasicToken, Ownable {

  // This event is used to intimate user about Burn operation  
  event Burn(address indexed burner, uint256 value);

  /**
   * @dev - This function burns some amount of tokens from own account
     @param _value - Amount of tokens to be burnt
   */
  function burn(uint256 _value) public {

    // The amount value must be less than the balance amount
    require(_value <= balances[msg.sender]);
    address burner = msg.sender;

    // Reduces given amount of tokens from own account
    balances[burner] = balances[burner].sub(_value);

    // Reduces same amount of tokens from total supply
    totalSupply_= totalSupply_.sub(_value);
    emit Burn(burner, _value);
    emit Transfer(burner, address(0), _value);
  }

  /**
   * @dev - This function is used to burn some amount of tokens from an address
     @param _from - The address of the user to burn its tokens
     @param _value - The amount of tokens to be burnt
     @return - Confirms whether the operation is success or not
   */
  function burnFrom(address _from, uint256 _value) public onlyOwner returns(bool success){

    // The value must be less than its balance
    require(balances[_from] >= _value);
    address burner = _from;
    balances[burner] = balances[burner].sub(_value);
    totalSupply_= totalSupply_.sub(_value);
    emit Burn(burner, _value);
    emit Transfer(burner, address(0), _value);
    return true;
  }

}
