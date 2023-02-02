pragma solidity ^0.5.16;

import "./Roles.sol";

contract HarvesterRole {
    using Roles for Roles.Role;

    event HarvesterAdded(address indexed account);
    event HarvesterRemoved(address indexed account);

    Roles.Role private harvesters;

    constructor() public {
        _addHarvester(msg.sender);
    }

    modifier isHarvester() {
        require(accountIsHarvester(msg.sender));
        _;
    }

    function accountIsHarvester(address account) public view returns (bool) {
        return harvesters.has(account);
    }

    function addHarvester(address account) public isHarvester {
        _addHarvester(account);
    }

    function renounceHarvester(address account) public isHarvester {
        _removeHarvester(account);
    }

    function _addHarvester(address account) internal {
        harvesters.add(account);
        emit HarvesterAdded(account);
    }

    function _removeHarvester(address account) internal {
        harvesters.remove(account);
        emit HarvesterRemoved(account);
    }
}