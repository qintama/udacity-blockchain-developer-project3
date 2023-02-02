pragma solidity ^0.5.16;

import "./Roles.sol";

contract CustomerRole {
    using Roles for Roles.Role;

    event CustomerAdded(address indexed account);
    event CustomerRemoved(address indexed account);

    Roles.Role private customers;

    constructor() public {
        _addCustomer(msg.sender);
    }

    modifier isCustomer() {
        require(accountIsCustomer(msg.sender));
        _;
    }

    function accountIsCustomer(address account) public view returns (bool) {
        return customers.has(account);
    }

    function addCustomer(address account) public isCustomer {
        _addCustomer(account);
    }

    function renounceCustomer(address account) public isCustomer {
        _removeCustomer(account);
    }

    function _addCustomer(address account) internal {
        customers.add(account);
        emit CustomerAdded(account);
    }

    function _removeCustomer(address account) internal {
        customers.remove(account);
        emit CustomerRemoved(account);
    }
}