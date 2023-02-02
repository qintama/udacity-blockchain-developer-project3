pragma solidity ^0.5.16;

contract Ownable {
    address private origOwner;

    event TransferOwnerShip(address oldOwner, address newOwner);

    modifier isOwner() {
        require(accountIsOwner());
        _;
    }

    constructor() internal {
        origOwner = msg.sender;
        emit TransferOwnerShip(address(0), origOwner);
    }

    function accountIsOwner() public view returns (bool) {
        return msg.sender == origOwner;
    }

    function owner() public view returns (address) {
        return origOwner;
    }

    function renounceOwnerShip() public isOwner {
        emit TransferOwnerShip(origOwner, address(0));
        origOwner = address(0);
    }

    function transferOwnerShip(address newOwner) public isOwner {
        _transferOwnerShip(newOwner);
    }

    function _transferOwnerShip(address newOwner) internal {
        require(newOwner != address(0));
        emit TransferOwnerShip(origOwner, newOwner);
        origOwner = newOwner;
    }
}