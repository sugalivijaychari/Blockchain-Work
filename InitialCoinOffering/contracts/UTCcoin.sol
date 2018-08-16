pragma solidity 0.4.24;

/** This contract is used to store the basic info
 * of the crypto currency.
 */

contract UTCcoin{

  /** The name of the new crypto currency */
  string public name;

  /** The initial supply of the crypto currency */
  uint256 public initialSupply;

  /** The symbol of the crypto currency like BTC for Bitcoin */
  string public symbol;

  /** No. of decimals such as number of zeroes appended to the initial supply*/
  uint8 public decimals;

  /**
   * @dev This allocates the input given values
     @param _name - Name of the crypto currency
     @param _initialSupply - Initial supply of tokens
     @param _symbol - Symbol of the token
     @param _decimals - No. of decimals appended to the token 
   */
  constructor(string _name, uint256 _initialSupply,string _symbol, uint8 _decimals) internal {
    name = _name;
    initialSupply = _initialSupply;
    symbol = _symbol;
    decimals = _decimals;
  }
}
