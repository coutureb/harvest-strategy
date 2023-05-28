pragma solidity 0.5.16;

import "./base/ConvexStrategyUL.sol";

contract ConvexStrategyEURS_USDMainnet is ConvexStrategyUL {

  address public eurs_usd_unused; // just a differentiator for the bytecode

  constructor() public {}

  function initializeStrategy(
    address _storage,
    address _vault
  ) public initializer {
    address underlying = address(0x3D229E1B4faab62F621eF2F6A610961f7BD7b23B); // Info -> LP Token address
    address rewardPool = address(0xb0c1B7b83Baae51284B8BbBa02Ec37742440199d); // Info -> Rewards contract address
    address crv = address(0xD533a949740bb3306d119CC777fa900bA034cd52);
    address cvx = address(0x4e3FBD56CD56c3e72c1403e103b45Db9da5B9D2B);
    address usdc = address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    address curveDeposit = address(0x98a7F18d4E56Cfe84E3D081B40001B3d5bD3eB8B); // only needed if deposits are not via underlying
    bytes32 sushiDex = bytes32(0xcb2d20206d906069351c89a2cb7cdbd96c71998717cd5a82e724d955b654f67a);
    ConvexStrategyUL.initializeBaseStrategy(
      _storage,
      underlying,
      _vault,
      rewardPool, // rewardPool
      54,  // Pool id: Info -> Rewards contract address -> read -> pid
      usdc, // depositToken
      0, //depositArrayPosition. Find deposit transaction -> input params 
      curveDeposit, // deposit contract: usually underlying. Find deposit transaction -> interacted contract 
      2, //nTokens -> total number of deposit tokens
      false, //metaPool -> if LP token address == pool address (at curve)
      1000 // hodlRatio 10%
    );
    rewardTokens = [crv, cvx];
    storedLiquidationPaths[crv][weth] = [crv, weth];
    storedLiquidationDexes[crv][weth] = [sushiDex];
    storedLiquidationPaths[cvx][weth] = [cvx, weth];
    storedLiquidationDexes[cvx][weth] = [sushiDex];
    storedLiquidationPaths[weth][usdc] = [weth, usdc];
    storedLiquidationDexes[weth][usdc] = [sushiDex];
  }
}
