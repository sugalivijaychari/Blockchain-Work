pragma solidity 0.4.24;

import "./Whitelist.sol";
import "../BurnableToken.sol";

/** This contract is used to burn tokens of an investor in whitelist process */

contract BurnableWhitelist is Whitelist,BurnableToken{

  // This function is used to burn the tokens with the help of ID.
  function burnById(uint256 _uniqueId)onlyOwner validTime public returns(bool){

    // We calculate investor address using investor unique id
    address accountAddress = investors[_uniqueId];

    // The amount of tokens that an investor have to burnt.
    uint256 _value = tokensInvested[accountAddress];

    // Tokens of investor must be distributed
    require(isTokensDistributed[accountAddress]);

    // The investor address must not be frozen
    require(!frozenAccount[accountAddress]);

    // The token system must not be paused
    require(!paused);

    // There must be minimum balance to burn
    require(_value <= balances[accountAddress]);

    // We must make the investor's token to zero
    balances[accountAddress]=balances[accountAddress].sub(_value);

    // We must reduce total supply with burnt value of tokens
    totalSupply_ = totalSupply_.sub(_value);

    // We must make the investor's token to zero
    tokensInvested[accountAddress] = tokensInvested[accountAddress].sub(_value);

    //When tokens are burnt, tokens count must be decreased by the burnt value
    whiteListTokensCount = whiteListTokensCount.sub(_value);

    // We must reduce distributed tokens to the burnt value
    distributedTokens = distributedTokens.sub(_value);

    // Intimates Ui about the burnt operation
    emit Burn(accountAddress,_value);

    // returns true after the successful of burning an account
    return true;
  }

  // This fucniton is used to burn the account using address
  function burnByAddress(address accountAddress)onlyOwner validTime public returns(bool){

    // The value of tokens that an investor address have
    uint256 _value = tokensInvested[accountAddress];

    // Tokens must have distributed to the investor
    require(isTokensDistributed[accountAddress]);

    // The investor address must not me freezed
    require(!frozenAccount[accountAddress]);

    // The token system must not be in pause
    require(!paused);

    // There must be minimum balance to burn
    require(_value <= balances[accountAddress]);

    // We must make the investor's token to zero
    balances[accountAddress]=balances[accountAddress].sub(_value);

    // Total supply must be reduced the burnt value
    totalSupply_ = totalSupply_.sub(_value);

    // We must make the investor's token to zero
    tokensInvested[accountAddress] = tokensInvested[accountAddress].sub(_value);

    // Total tokens count must be reduced excluding the burnt value
    whiteListTokensCount = whiteListTokensCount.sub(_value);

    // We must reduce distributed tokens to the burnt value
    distributedTokens = distributedTokens.sub(_value);

    // Intimates Ui that burn operation is finished
    emit Burn(accountAddress,_value);

    // returns true after successful completion of the above operation
    return true;
  }
    
}