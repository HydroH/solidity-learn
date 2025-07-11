// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/// @custom:oz-upgrades-from CounterV1
contract CounterV2 is UUPSUpgradeable, OwnableUpgradeable {
    uint256 public count;
    uint256 public resets;

    event CountUpdated(uint256 newCount);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
        count = 0;
    }

    function initializeV2() public reinitializer(2) {
        resets = 0;
    }

    function increment() external {
        count += 1;
        emit CountUpdated(count);
    }

    function reset() external onlyOwner {
        count = 0;
        resets += 1;
        emit CountUpdated(count);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
