pragma solidity 0.4.24;


import "./ERC20Basic.sol";
import "./SafeMath.sol";
import "./UTCcoin.sol";

contract BasicToken is ERC20Basic,UTCcoin {

  // We are using Safe Math library to do multiplication,addition, subtraction and division 
  using SafeMath for uint256;

  /** This mapping data structure is used to store the addresses
   * of users and those addresses are mapped with unique identities
   */
  mapping(address => uint256) balances;
  
  // The Total supply of tokens is calculated and placed here
  uint256 totalSupply_;

  /** This evaluates total supply of tokens from the
   * given input values such as initial supply and decimals.
   */
  constructor()public{
    totalSupply_ = initialSupply.mul(10** uint256(decimals));
  }

  // This function returns the value of total supply
  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }

  /**
   * @dev - This contract is used to transfer the tokens from given address
     @param _to - The address to whom we send our tokens
     @param _value - The amount of tokens to transfer
     @return - It shows whether the transfer operation gets success or not.
   */
  function transfer(address _to, uint256 _value) public returns (bool) {

    // The sender itself is not allowed to transfer money
    require(_to != address(0));

    // Value should be less than or equal to available balance
    require(_value <= balances[msg.sender]);

    // Firstly, balance is reduced from sender
    balances[msg.sender] = balances[msg.sender].sub(_value);

    // Next, balance of receiver is increased with the sended value
    balances[_to] = balances[_to].add(_value);

    // Transfer event intimates this action to user
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  
  function balanceOf(address _owner) public view returns (uint256 balance) {
    return balances[_owner];
  }

}
