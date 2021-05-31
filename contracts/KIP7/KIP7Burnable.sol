// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "./KIP7.sol";
import "../library/KIP7Pausable.sol";

abstract contract KIP7Burnable is KIP7, KIP7Pausable {
    event Burn(address indexed burned, uint256 amount);

    function burn(uint256 amount)
        external
        whenNotPaused
        returns (bool success)
    {
        success = _burn(msg.sender, amount);
        emit Burn(msg.sender, amount);
        success = true;
    }

    function burnFrom(address burned, uint256 amount)
        external
        whenNotPaused
        returns (bool success)
    {
        _burn(burned, amount);
        emit Burn(burned, amount);
        success = _approve(
            burned,
            msg.sender,
            _allowances[burned][msg.sender] - amount
        );
    }
}