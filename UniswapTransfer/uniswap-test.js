const IERC20 = artifacts.require("IERC20");
const TestUniswap = artifacts.require("UniswapTester");

contract("UniswapTester", (accounts) => {
    const WHALE = WBTC_WHALE;
  const AMOUNT_IN = 100000000;
  const AMOUNT_OUT_MIN = 1;
  const TOKEN_IN = WBTC;
  const TOKEN_OUT = DAI;
  const TO = accounts[0];

  let testUniswap;
  let tokenIn;
  let tokenOut;
  beforeEach(async () => {
    tokenIn = await IERC20.at(TOKEN_IN);
    tokenOut = await IERC20.at(TOKEN_OUT);
    testUniswap = await UniswapTester.new();

    await tokenIn.approve(testUniswap.address, AMOUNT_IN, { from: WHALE });
  });

  it("should pass", async () => {
    await testUniswap.swap(
      tokenIn.address,
      tokenOut.address,
      AMOUNT_IN,
      AMOUNT_OUT_MIN,
      TO,
      {
        from: WHALE,
      }
    );

    console.log(`in ${AMOUNT_IN}`);
    console.log(`out ${await tokenOut.balanceOf(TO)}`);
  });
});