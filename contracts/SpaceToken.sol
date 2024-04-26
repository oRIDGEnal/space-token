// contracts/SpaceToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Capped} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import {ERC20Pausable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SpaceToken is
    ERC20,
    ERC20Capped,
    ERC20Burnable,
    ERC20Pausable,
    Ownable
{
    constructor(
        uint256 cap,
        address initialOwner
    )
        ERC20("SpaceToken", "SPTX")
        ERC20Capped(cap * (10 ** decimals()))
        Ownable(initialOwner)
    {
        _mint(msg.sender, 50000000 * (10 ** decimals()));
        require(
            cap >= 50000000 * (10 ** decimals()),
            "Cap is less than required initial mint amount"
        );
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _update(
        address from,
        address to,
        uint256 value
    ) internal override(ERC20, ERC20Capped, ERC20Pausable) {
        super._update(from, to, value);
    }
}
