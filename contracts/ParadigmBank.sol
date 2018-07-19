pragma solidity ^0.4.24;

import "./Token.sol";

contract ParadigmBank {

    mapping(bytes32 => uint) remaining; //TODO Bytes 32 may have overlap

    function transferFromOrigin(address token, address to, uint value) public returns (bool) {
        return Token(token).transferFrom(tx.origin, to, value);
    }

    function transferFromSignature(
        address token,
        address from,
        address to,
        uint value,
        address signedTo,
        uint signedValue,
        uint8 v,
        bytes32 r,
        bytes32 s,
        uint nonce
    ) public returns (bool) {
        bytes32 hash = signatureHash(token, from, signedTo, signedValue, nonce);
        require(validateSignature(hash, from, v, r, s)); //TODO to signedTo may not be clean enough
        require(signedTo == to || signedTo == 0x0 );
        require(value <= signedValue);
        require(value + remaining[hash] <= signedValue);

        remaining[hash] = remaining[hash] + value;
        return Token(token).transferFrom(from, to, value);
    }

    function signatureHash(address token, address from, address signedTo, uint signedValue, uint nonce) internal returns (bytes32){
        return keccak256("\x19Ethereum Signed Message:\n32", keccak256(msg.sender, token, from, signedTo, signedValue, nonce));
    }

    function validateSignature(bytes32 hash, address from, uint8 v, bytes32 r, bytes32 s) internal returns (bool) {
        address recoveredAddress = ecrecover(hash, v, r, s);

        return from == recoveredAddress;
    }
}