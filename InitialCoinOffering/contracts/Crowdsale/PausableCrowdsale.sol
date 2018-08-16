pragma solidity 0.4.24;

import "./SafeCrowdsale.sol";

/** This contract is used to pause the crowdsale */

contract PausableCrowdsale is SafeCrowdsale{
    
    function pauseCrowdsale() onlyOwner _safeCrowdsale public{
        crowdsaleStatus = false;
        pause();
    }
    
    function unpauseCrowdsale() onlyOwner _unSafeCrowdsale public{
        crowdsaleStatus = true;
        unpause();
    }
    
}