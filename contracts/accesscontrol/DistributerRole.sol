pragma solidity ^0.5.16;

import "./Roles.sol";

contract DistributerRole {
    using Roles for Roles.Role;

    event DistributerAdded(address indexed account);
    event DistributerRemoved(address indexed account);

    Roles.Role private distributers;

    constructor() public {
        _addDistributer(msg.sender);
    }

    modifier isDistributer() {
        require(accountIsDistributer(msg.sender));
        _;
    }

    function accountIsDistributer(address account) public view returns (bool) {
        return distributers.has(account);
    }

    function addDistributer(address account) public isDistributer {
        _addDistributer(account);
    }

    function renounceDistributer(address account) public isDistributer {
        _removeDistributer(account);
    }

    function _addDistributer(address account) internal {
        distributers.add(account);
        emit DistributerAdded(account);
    }

    function _removeDistributer(address account) internal {
        distributers.remove(account);
        emit DistributerRemoved(account);
    }
}