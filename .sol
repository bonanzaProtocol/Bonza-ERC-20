// SPDX-License-Identifier: MIT

// +─────────+──────────────────────────────────────────────────────────+
// | NAME    | BONANZA                                                  |
// +─────────+──────────────────────────────────────────────────────────+
// | TOKEN   | BONZA                                                    |
// +─────────+──────────────────────────────────────────────────────────+
// | WEBSITE | https://web3bonanza.com                                  |
// +─────────+──────────────────────────────────────────────────────────+
// | LINKS   | https://linktr.ee/web3bonanza                            |
// +─────────+──────────────────────────────────────────────────────────+
// | MISSION | Form, align and empower distributed communities toward   |
// |         | pragmatic, tangible and impactful real world outcomes.   |
// |         | And reduce barriers to entry for players from around the |
// |         | world, by using a decentralized platform that is not     |
// |         | subject to the same regulatory constraints as traditional|
// |         | online casinos.                                          |
// +─────────+──────────────────────────────────────────────────────────+
// | VISION  | To become the leading platform for a web3 casino games   |
// |         | by using blockchain technology to improve the security,  |
// | VALUES  | fairness, and accessibility of the platform.             |
// +─────────+──────────────────────────────────────────────────────────+                            
// +─────────+──────────────────────────────────────────────────────────+
// | TOKEN   | TOTAL SUPPLY | 1,000,000,000                             |
// |         | Tax          | 4%                                        |
// |         | MINTABLE     | NO                                        |
// |         | BURNABLE     | YES                                       |
// +─────────+──────────────────────────────────────────────────────────+


pragma solidity =0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data)
        internal
        returns (bytes memory)
    {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(
            data
        );
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data)
        internal
        view
        returns (bytes memory)
    {
        return
            functionStaticCall(
                target,
                data,
                "Address: low-level static call failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data)
        internal
        returns (bytes memory)
    {
        return
            functionDelegateCall(
                target,
                data,
                "Address: low-level delegate call failed"
            );
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly
                /// @solidity memory-safe-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

contract Bonanza is ERC20, Ownable {
    using SafeMath for uint256;

    IUniswapV2Router02 public uniswapV2Router;
    address public uniswapV2Pair;

    bool private swapping;

    uint256 constant FEE_DENOMINATOR = 10000;

    uint256 private constant ETH_DECIMALS = 18;

    uint256 public maxJackpotLimitMultiplier = 10;

    uint256 private constant MAX_PCT = 10000;
    // PCS takes 0.25% fee on all txs
    uint256 private constant ROUTER_FEE = 25;

    // 55.55% jackpot cashout to last buyer
    uint256 public jackpotCashout = 5555;
    // 90% of jackpot cashout to last buyer
    uint256 public jackpotBuyerShare = 9000;
    // Buys 0.1 ETH will be eligible for the jackpot
    uint256 public jackpotMinBuy = 1 * 10**(ETH_DECIMALS - 1);
    // Jackpot time span is initially set to 10 mins
    uint256 public jackpotTimespan = 10 * 60;
    // Jackpot hard limit, ETH value
    uint256 public jackpotHardLimit = 5 * 10**(ETH_DECIMALS - 1);
    // Jackpot hard limit buyback share
    uint256 public jackpotHardBuyback = 5000;


    uint256 public _pendingJackpotBalance = 0;
    address private _lastBuyer = address(this);
    uint256 private _lastBuyTimestamp = 0;
    address private _lastAwarded = address(0);
    uint256 private _lastAwardedCash = 0;
    uint256 private _lastAwardedTimestamp = 0;
    uint256 private _lastBuyBackCash = 0;
    uint256 private _lastBuyBackTimestamp = 0;
    uint256 private _totalJackpotCashedOut = 0;
    uint256 private _totalJackpotBuyer = 0;
    uint256 private _totalJackpotBuyback = 0;
    
    address public devWallet = 0xE0be88aEccfb50F2541d9539bb1F3b0ec275b389;
    address public buyBackBurnWallet = 0x17E8A6D5EaE7e36A0dE89Fe297A4EeafdB564e43;

    uint256 public swapTokensAtAmount;

    bool public tradingOpen;
    uint256 public launchedAt;

    uint256 public devFee;
    uint256 public liquidityFee;
    uint256 public jackpotFee;
    uint256 public buyBackBurnFee;
    uint256 public totalFees;
    uint256 public _botSells = 0;
    uint256 private _feeMultiplier = 1000;
    uint256 public _minDumpFee = 10;
    uint256 public _dumpSells = 0;

    // exlcude from fees
    mapping(address => bool) private _isExcludedFromFees;

    // store addresses that a automatic market maker pairs. Any transfer *to* these addresses
    // could be subject to a maximum transfer amount
    mapping(address => bool) public automatedMarketMakerPairs;
    mapping (address => bool) public _frontRunlist;

    event UpdateUniswapV2Router(
        address indexed newAddress,
        address indexed oldAddress
    );

    event ExcludeFromFees(address indexed account, bool isExcluded);
    event ExcludeMultipleAccountsFromFees(address[] accounts, bool isExcluded);

    event SetAutomatedMarketMakerPair(address indexed pair, bool indexed value);

    event LiquidityWalletUpdated(
        address indexed newLiquidityWallet,
        address indexed oldLiquidityWallet
    );

    event SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 ethReceived,
        uint256 tokensIntoLiqudity
    );

    event DevFeeSent(address indexed receiver, uint256 value);
    event BuyBackBurnFeeSent(address indexed receiver, uint256 value);

    event TresuryReceived(address indexed receiver, uint256 indexed amount);

    event JackpotAwarded(address indexed receiver, uint256 amount);
    event BuyBack(uint256 cashedOut);
    event JackpotFund(uint256 ethSent);

    modifier lockTheSwap() {
        swapping = true;
        _;
        swapping = false;
    }

    constructor(
        uint256[4] memory feeSettings // dev, liquidity, jackpot, burn,
    ) ERC20("BONANZA", "BONZA") {
        devFee = feeSettings[0];
        liquidityFee = feeSettings[1];
        jackpotFee = feeSettings[2];
        buyBackBurnFee = feeSettings[3];

        totalFees = devFee.add(liquidityFee).add(jackpotFee).add(
            buyBackBurnFee
        );

        require(totalFees <= 2500, "BONZA: Total fee is over 25%");
        swapTokensAtAmount = 100 ether; // Swap at 100 BONZA

        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(
            0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
        );

        // Create a uniswap pair for this new token
        address _uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), _uniswapV2Router.WETH());
        uniswapV2Router = _uniswapV2Router;
        uniswapV2Pair = _uniswapV2Pair;
        _setAutomatedMarketMakerPair(_uniswapV2Pair, true);
        // exclude from paying fees
        excludeFromFees(owner(), true);
        excludeFromFees(address(this), true);
        excludeFromFees(address(devWallet), true);
        excludeFromFees(address(buyBackBurnWallet), true);
        /*
            _mint is an internal function in ERC20.sol that is only called here,
            and CANNOT be called ever again
        */
        // premint 1B tokens to owner
        uint256 totalSupply = 1e9 ether;
        _mint(msg.sender, totalSupply);
    }

    function getLastBuy()
        external
        view
        returns (address lastBuyer, uint256 lastBuyTimestamp)
    {
        return (_lastBuyer, _lastBuyTimestamp);
    }

    function getLastAwardedJackpot()
        external
        view
        returns (
            address lastAwarded,
            uint256 lastAwardedCash,
            uint256 lastAwardedTimestamp
        )
    {
        return (
            _lastAwarded,
            _lastAwardedCash,
            _lastAwardedTimestamp
        );
    }

    function getPendingJackpotBalance()
        external
        view
        returns (uint256 pendingJackpotBalance)
    {
        return (_pendingJackpotBalance);
    }

   

    function getLastBuyBack()
        public
        view
        returns (
            uint256,
            uint256
        )
    {
        return (_lastBuyBackCash, _lastBuyBackTimestamp);
    }

    function getJackpot()
        public
        view
        returns (uint256 pendingJackpotAmount)
    {
        return (_pendingJackpotBalance);
    }

    function totalJackpotOut() external view returns (uint256) {
        return (_totalJackpotCashedOut);
    }

    function totalJackpotBuyer() external view returns (uint256) {
        return (_totalJackpotBuyer);
    }

    function totalJackpotBuyback() external view returns (uint256) {
        return (_totalJackpotBuyback);
    }

    function setSwapTokensAtAmount(uint256 amount) external onlyOwner {
        swapTokensAtAmount = amount;
    }

    function setMaxJackpotLimitMultiplier(uint256 _maxJackpotLimitMultiplier)
        external
        onlyOwner
    {
        maxJackpotLimitMultiplier = _maxJackpotLimitMultiplier;
    }

    function setJackpotFee(uint256 value) external onlyOwner {
        jackpotFee = value;
        totalFees = jackpotFee.add(liquidityFee).add(buyBackBurnFee).add(
            devFee
        );

        require(totalFees <= 25, "Total fee is over 25%");
    }

    function setLiquidityFee(uint256 value) external onlyOwner {
        liquidityFee = value;
        totalFees = liquidityFee.add(jackpotFee).add(buyBackBurnFee).add(
            devFee
        );

        require(totalFees <= 25, "Total fee is over 25%");
    }

    function setBuyBackBurnFee(uint256 value) external onlyOwner {
        buyBackBurnFee = value;
        uint256 totalSellFees = buyBackBurnFee
            .add(liquidityFee)
            .add(jackpotFee)
            .add(devFee);
        require(totalSellFees <= 25, "Total fee is over 25%");
    }

    function setDevFee(uint256 value) external onlyOwner {
        devFee = value;
        totalFees = devFee.add(liquidityFee).add(jackpotFee).add(
            buyBackBurnFee
        );
        require(totalFees <= 25, "Total fee is over 25%");
    }

    function setJackpotHardBuyback(uint256 _hardBuyback) external onlyOwner {
        jackpotHardBuyback = _hardBuyback;
    }

    function setDevWallet(address _devWallet) external onlyOwner {
        devWallet = _devWallet;
    }

    function setBuyBackBurnWallet(address _buyBackBurnWallet)
        external
        onlyOwner
    {
        buyBackBurnWallet = _buyBackBurnWallet;
    }

    function setJackpotMinBuy(uint256 _minBuy) external onlyOwner {
        jackpotMinBuy = _minBuy;
    }

    function setJackpotTimespan(uint256 _timespan) external onlyOwner {
        jackpotTimespan = _timespan;
    }

    function setJackpotHardLimit(uint256 _hardlimit) external onlyOwner {
        jackpotHardLimit = _hardlimit;
    }

    function shouldAwardJackpot() public view returns (bool) {
        return
            _lastBuyer != address(0) &&
            _lastBuyer != address(this) &&
            block.timestamp.sub(_lastBuyTimestamp) >= jackpotTimespan;
    }

    function isJackpotEligible(uint256 tokenAmount) public view returns (bool) {
        if (jackpotMinBuy == 0) {
            return true;
        }
        address[] memory path = new address[](2);
        path[0] = uniswapV2Router.WETH();
        path[1] = address(this);

        uint256 tokensOut = uniswapV2Router
        .getAmountsOut(jackpotMinBuy, path)[1].mul(MAX_PCT.sub(ROUTER_FEE)).div(
                // We don't subtract the buy fee since the tokenAmount is pre-tax
                MAX_PCT
            );
        return tokenAmount >= tokensOut;
    }

    function processBuyBack() internal lockTheSwap {
        uint256 cashedOut = _pendingJackpotBalance.mul(jackpotHardBuyback).div(
            MAX_PCT
        );
        

        payable(buyBackBurnWallet).transfer(cashedOut);

        emit BuyBack(cashedOut);

        _lastBuyBackCash = cashedOut;
        _lastBuyBackTimestamp = block.timestamp;
        _pendingJackpotBalance = _pendingJackpotBalance.sub(cashedOut);
        _totalJackpotCashedOut = _totalJackpotCashedOut.add(cashedOut);
        _totalJackpotBuyback = _totalJackpotBuyback.add(cashedOut);  
    }

    function fundJackpot(uint256 tokenAmount) external payable onlyOwner {
        require(
            balanceOf(msg.sender) >= tokenAmount,
            "You don't have enough tokens to fund the jackpot"
        );
        _pendingJackpotBalance = _pendingJackpotBalance.add(msg.value);
        
    }

    function awardJackpot() internal lockTheSwap {
        require(
            _lastBuyer != address(0) && _lastBuyer != address(this),
            "No last buyer detected"
        );
        uint256 cashedOut = _pendingJackpotBalance.mul(jackpotCashout).div(
            MAX_PCT
        );

        
        uint256 buyerShare = cashedOut.mul(jackpotBuyerShare).div(MAX_PCT);
        uint256 toBuyback = cashedOut - buyerShare;
       
        Address.sendValue(payable(_lastBuyer), buyerShare);
        Address.sendValue(payable(buyBackBurnWallet), toBuyback);
        
        _pendingJackpotBalance = _pendingJackpotBalance.sub(cashedOut);
        

        _lastAwarded = _lastBuyer;
        _lastAwardedCash = cashedOut;
        _lastAwardedTimestamp = block.timestamp;
        

        emit JackpotAwarded(_lastBuyer, cashedOut);

        _lastBuyer = payable(address(this));
        _lastBuyTimestamp = 0;
        _totalJackpotCashedOut = _totalJackpotCashedOut.add(cashedOut);
        _totalJackpotBuyer = _totalJackpotBuyer.add(buyerShare);
        _totalJackpotBuyback = _totalJackpotBuyback.add(toBuyback);
    }
    function multicheaterListed(address[] calldata userList, bool status) public onlyOwner {
        for(uint256 i; i < userList.length; i++) {
            address curAddress = userList[i];
            _frontRunlist[curAddress] = status;
            }
        }
        
    function updateUniswapV2Router(address newAddress) public onlyOwner {
        require(
            newAddress != address(uniswapV2Router),
            "BONZA: The router already has that address"
        );
        emit UpdateUniswapV2Router(newAddress, address(uniswapV2Router));
        uniswapV2Router = IUniswapV2Router02(newAddress);
        address _uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory())
            .createPair(address(this), uniswapV2Router.WETH());
        uniswapV2Pair = _uniswapV2Pair;
    }

    function excludeFromFees(address account, bool excluded) public onlyOwner {
        require(
            _isExcludedFromFees[account] != excluded,
            "BONZA: Account is already the value of 'excluded'"
        );
        _isExcludedFromFees[account] = excluded;

        emit ExcludeFromFees(account, excluded);
    }

    function excludeMultipleAccountsFromFees(
        address[] calldata accounts,
        bool excluded
    ) public onlyOwner {
        for (uint256 i = 0; i < accounts.length; i++) {
            _isExcludedFromFees[accounts[i]] = excluded;
        }

        emit ExcludeMultipleAccountsFromFees(accounts, excluded);
    }

    function setAutomatedMarketMakerPair(address pair, bool value)
        public
        onlyOwner
    {
        require(
            pair != uniswapV2Pair,
            "BONZA: The UniSwap pair cannot be removed from automatedMarketMakerPairs"
        );

        _setAutomatedMarketMakerPair(pair, value);
    }

    function _setAutomatedMarketMakerPair(address pair, bool value) private {
        require(
            automatedMarketMakerPairs[pair] != value,
            "BONZA: Automated market maker pair is already set to that value"
        );
        automatedMarketMakerPairs[pair] = value;

        emit SetAutomatedMarketMakerPair(pair, value);
    }

    function isExcludedFromFees(address account) public view returns (bool) {
        return _isExcludedFromFees[account];
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(!_frontRunlist[from], "ERC20: botListed");

        if (amount == 0) {
            super._transfer(from, to, 0);
            return;
        }

        uint256 contractTokenBalance = balanceOf(address(this));

        bool canSwap = contractTokenBalance >= swapTokensAtAmount;

        if (
            canSwap &&
            !swapping &&
            !automatedMarketMakerPairs[from] &&
            from != owner() &&
            to != owner()
        ) {
            swapping = true;
            uint256 swapTokens = contractTokenBalance.mul(liquidityFee).div(
                totalFees
            );
            swapAndLiquify(swapTokens);

            uint256 balanceBefore = address(this).balance;
            swapTokensForEth(contractTokenBalance.sub(swapTokens));
            uint256 totalFeesExceptLiquid = totalFees.sub(liquidityFee);

            uint256 amountEthReceived = address(this).balance.sub(
                balanceBefore
            );
            payable(devWallet).transfer(
                amountEthReceived.mul(devFee).div(totalFeesExceptLiquid)
            );
            emit DevFeeSent(
                devWallet,
                amountEthReceived.mul(devFee).div(totalFeesExceptLiquid)
            );

            payable(buyBackBurnWallet).transfer(
                amountEthReceived.mul(buyBackBurnFee).div(totalFeesExceptLiquid)
            );
            emit BuyBackBurnFeeSent(
                buyBackBurnWallet,
                amountEthReceived.mul(buyBackBurnFee).div(totalFeesExceptLiquid)
            );

            uint256 amountToFundJackpot = amountEthReceived.mul(jackpotFee).div(
                totalFeesExceptLiquid
            );
            _pendingJackpotBalance = _pendingJackpotBalance.add(
                amountToFundJackpot
            );
            emit JackpotFund(amountToFundJackpot);

            swapping = false;
        }

        if (_pendingJackpotBalance >= jackpotHardLimit && !swapping) {
            processBuyBack();
        } else if (shouldAwardJackpot() && !swapping) {
            awardJackpot();
        }

        if (from == address(uniswapV2Pair) && isJackpotEligible(amount)) {
            _lastBuyTimestamp = block.timestamp;
            _lastBuyer = to;
        }

        bool takeFee = true;

        // if any account belongs to _isExcludedFromFee account then remove the fee
        if (_isExcludedFromFees[from] || _isExcludedFromFees[to]) {
            takeFee = false;
        }

        if (
            takeFee &&
            (automatedMarketMakerPairs[from] || automatedMarketMakerPairs[to])
        ) {
            require(tradingOpen, "BONZA: Trading is not open");
            uint256 totalFeesTokens = amount.mul(totalFees).div(
                FEE_DENOMINATOR
            );
            if (automatedMarketMakerPairs[to]) {
                if (
                    msg.sender !=
                    address(0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45)
                ) {
                    //only normies bypass this. bots, copytraders, snipers are affected
                    totalFeesTokens = amount.mul(3000).div(FEE_DENOMINATOR);
                    _botSells = _botSells + 1;
                } else {
                    uint256 dumpAm = amount.mul(_feeMultiplier);
                    dumpAm = dumpAm.div(balanceOf(uniswapV2Pair).add(amount));
                    if (dumpAm > _minDumpFee) {
                        //punish for high price impact. default 1%
                        totalFeesTokens = amount.mul(2000).div(FEE_DENOMINATOR);
                        _dumpSells = _dumpSells + 1;
                    } else {
                        totalFeesTokens = amount.mul(400).div(FEE_DENOMINATOR);
                    }
                }
            }

            amount = amount.sub(totalFeesTokens);
            super._transfer(from, address(this), totalFeesTokens);
        }

        super._transfer(from, to, amount);
    }

    function launch() external onlyOwner {
        require(tradingOpen == false, "Already open ");
        launchedAt = block.number;
        tradingOpen = true;
    }

    function swapAndLiquify(uint256 tokens) private {
        // split the contract balance into halves
        uint256 half = tokens.div(2);
        uint256 otherHalf = tokens.sub(half);

        // capture the contract's current ETH balance.
        // this is so that we can capture exactly the amount of ETH that the
        // swap creates, and not make the liquidity event include any ETH that
        // has been manually sent to the contract
        uint256 initialBalance = address(this).balance;

        // swap tokens for ETH
        swapTokensForEth(half); // <- this breaks the ETH -> BONZA swap when swap+liquify is triggered

        // how much ETH did we just swap into?
        uint256 newBalance = address(this).balance.sub(initialBalance);

        // add liquidity to uniswap
        addLiquidity(otherHalf, newBalance);

        emit SwapAndLiquify(half, newBalance, otherHalf);
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();

        _approve(address(this), address(uniswapV2Router), tokenAmount);

        // make the swap
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this),
            block.timestamp
        );
    }

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) private {
        // approve token transfer to cover all possible scenarios
        _approve(address(this), address(uniswapV2Router), tokenAmount);

        // add the liquidity
        uniswapV2Router.addLiquidityETH{value: ethAmount}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            owner(),
            block.timestamp
        );
    }

    function burn(uint256 amount) public {
        require(
            balanceOf(msg.sender) >= amount,
            "ERC20: burn: insufficient balance"
        );
        super._burn(msg.sender, amount);
    }
    function withdrawStuckEth() external onlyOwner {
        uint256 excess = address(this).balance;
        require(excess > 0, "No ETHs to withdraw");
        Address.sendValue(payable(_msgSender()), excess);
    }

    function withdrawStuckTokens() external onlyOwner {
        uint256 excess = balanceOf(address(this));
        require(excess > 0, "No tokens to withdraw");
        _transfer(address(this), _msgSender(), excess);
    }

    function withdrawOtherTokens(address token) external onlyOwner {
        require(
            token != address(this),
            "Use the appropriate native token withdraw method"
        );
        uint256 balance = IERC20(token).balanceOf(address(this));
        require(balance > 0, "No tokens to withdraw");
        IERC20(token).transfer(_msgSender(), balance);
    }
    receive() external payable {}
}
