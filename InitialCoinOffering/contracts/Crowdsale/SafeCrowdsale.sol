pragma solidity 0.4.24;

import "./CrowdsaleCredentials.sol";

/** This contract is used to store the crowdsale status */

contract SafeCrowdsale is CrowdsaleCredentials{
    
    bool crowdsaleStatus;
    
    function setCrowdsaleStatus(bool _crowdsaleStatus) onlyOwner public{
        crowdsaleStatus = _crowdsaleStatus;
    } 
    
    // It tells the crowdsale is in  safe mode or not
    modifier _safeCrowdsale{
        require(crowdsaleStatus && (now>=startTime && now<endTime) && (!paused));
        _;
    }
    
    modifier _unSafeCrowdsale{
        require(!crowdsaleStatus && (now>=startTime && now<endTime) && (paused));
        _;
    }
    
}