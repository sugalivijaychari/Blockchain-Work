pragma solidity 0.4.24;

/** This contract is library which is used to deal with
 * bytes. It takes the data in the form of bytes and converts
 * it into actual data we need.
 */

library BytesExtraction{


    /** 
     * @dev - This function is used to extract 32 byte data
       @param data - The data in bytes
       @param index - The position by which data starts
       @return - It returns the 32 byte data
     */
    function extract32bytes(bytes data, uint256 index) public pure returns(bytes32){
        bytes32 result;
        for(uint256 i=0; i<32; i++){
            result |= bytes32(data[index+i] & 0xFF) >> (i*8);
        }
        return result;    
    }
    
    /** 
     * @dev - This function is used to extract token account user address from 32 byte data
       @param data - The data in bytes
       @param index - The position by which account address starts
       @return - It returns the account address
     */
    function extractAddress(bytes data, uint256 index) public pure returns (address){
        bytes32 result;
        for(uint256 i=0; i< 20; i++){
            result |= bytes32(data[index +i] & 0xFF) >> ((i+12) * 8);
        }
        return address(uint256(result));
    }
    
    /** 
     * @dev - This function is used to extract 16 byte data
       @param data - The data in bytes
       @param index - The position by which data starts
       @return - It returns the 16 byte data
     */
    function extract16bytes(bytes data, uint256 index) public pure returns(bytes16){
        bytes16 result;
        for(uint256 i=0; i< 16; i++){
            result |= bytes16(data[index +i] & 0xFF) >> (i * 8);
        }
        return result;
    }
       
}