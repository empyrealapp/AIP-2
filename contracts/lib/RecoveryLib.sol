// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.16;

library RecoveryLib {
    // This struct contains state variables we care about.
    struct RecoveryStorage {
        bool hasInitializedRecovery;
        mapping(address => uint) recoverAmount;
        mapping(address => bool) hasRecovered;
    }

    // Returns the struct from a specified position in contract storage
    // ds is short for DiamondStorage
    function recoveryStorage()
        internal
        pure
        returns (RecoveryStorage storage rs)
    {
        // Specifies a random position in contract storage
        // This can be done with a kaccak256 hash of a unique string as is
        // done here or other schemes can be used such as this:
        // bytes32 storagePosition = keccak256(abi.encodePacked(ERC1155.interfaceId, ERC1155.name, address(this)));
        bytes32 storagePosition = keccak256("arbitrum.recoverStorage");
        // Set the position of our struct in contract storage
        assembly {
            rs.slot := storagePosition
        }
    }

    function setRecoverForUser(address user, uint amount) public {
        RecoveryStorage storage rs = recoveryStorage();
        rs.recoverAmount[user] = amount;
    }

    function setRecovered(address user) public {
        RecoveryStorage storage rs = recoveryStorage();
        rs.hasRecovered[user] = true;
    }

    function hasRecovered(address user) public returns (bool) {
        RecoveryStorage storage rs = recoveryStorage();
        return rs.hasRecovered[user];
    }

    function getRecoverAmount(address user) public returns (uint) {
        RecoveryStorage storage rs = recoveryStorage();
        return rs.recoverAmount[user];
    }

    function hasInitializedRecovery() public view returns (bool) {
        RecoveryStorage storage rs = recoveryStorage();
        return rs.hasInitializedRecovery;
    }

    function initializeRecovery() public {
        RecoveryStorage storage rs = recoveryStorage();
        rs.hasInitializedRecovery = true;
    }
}
