// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Capped} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import {ERC20Pausable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract SpaceCoin is
    ERC20,
    ERC20Capped,
    ERC20Burnable,
    ERC20Pausable,
    AccessControl
{
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event Minted(address indexed to, uint256 amount);
    event Burned(address indexed from, uint256 amount);

    constructor(
        uint256 cap,
        address initialOwner
    ) ERC20("SpaceCoin", "SCTX") ERC20Capped(cap * (10 ** decimals())) {
        require(
            initialOwner != address(0),
            "Initial owner cannot be the zero address"
        );
        require(
            cap >= 50000000 * (10 ** decimals()),
            "Cap is less than required initial mint amount"
        );

        _grantRole(DEFAULT_ADMIN_ROLE, initialOwner);
        _grantRole(PAUSER_ROLE, initialOwner);
        _grantRole(MINTER_ROLE, initialOwner);

        _mint(msg.sender, 50000000 * (10 ** decimals()));
        _mint(initialOwner, 50000000 * (10 ** decimals())); // Mint initial supply to owner
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        require(to != address(0), "Cannot mint to the zero address");
        _mint(to, amount);
        emit Minted(to, amount);
    }

    function burn(address from, uint256 amount) public onlyRole(MINTER_ROLE) {
        require(from != address(0), "Cannot burn from the zero address");
        _burn(from, amount);
        emit Burned(from, amount);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
        emit Paused(msg.sender);
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
        emit Unpaused(msg.sender);
    }

    function _update(
        address from,
        address to,
        uint256 value
    ) internal virtual override(ERC20Capped, ERC20, ERC20Pausable) {
        super._update(from, to, value);
    }
}
