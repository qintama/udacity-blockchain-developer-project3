pragma solidity ^0.5.16;

import "./Roles.sol";

contract RetailerRole {
    using Roles for Roles.Role;

    event RetailerAdded(address indexed account);
    event RetailerRemoved(address indexed account);

    Roles.Role private retailers;

    constructor() public {
        _addRetailer(msg.sender);
    }

    modifier isRetailer() {
        require(accountIsRetailer(msg.sender));
        _;
    }

    function accountIsRetailer(address account) public view returns (bool) {
        return retailers.has(account);
    }

    function addRetailer(address account) public isRetailer {
        _addRetailer(account);
    }

    function renounceRetailer(address account) public isRetailer {
        _removeRetailer(account);
    }

    function _addRetailer(address account) internal {
        retailers.add(account);
        emit RetailerAdded(account);
    }

    function _removeRetailer(address account) internal {
        retailers.remove(account);
        emit RetailerRemoved(account);
    }
}