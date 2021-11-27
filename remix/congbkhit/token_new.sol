// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.10;

interface IBEP20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns (uint8);

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the token name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view returns (address);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address _owner, address spender)
        external
        view
        returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor() {}

    function _msgSender() internal view returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

struct Miner {
    uint256 amount;
    address minerPrevious;
    address minerNext;
}

struct IDOToken{
    address owner;
    address tokenAddress;
    uint256 price;
    uint256 softcap;
    uint256 hardcap;
    
}

struct TokenLock {
    address tokenAddress;
    uint256 amount;
    uint256 unlockTime;
    address [] owners;
    bool [] isLocks;
    string reson;
}


contract AToken is Context, IBEP20, Ownable {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    mapping(address => Miner) private _miners;
    mapping(address => uint256) private _miner_balances;
    mapping(address => TokenLock[]) private _tokenLocked;
    mapping(address => uint256) private _fee_balances;

    mapping(address => bool) private _noFeeAccounts;

    
    uint256 private _totalSupply;
    uint8 private _decimals;
    string private _symbol;
    string private _name;
    
    address public _lastMiner;
    address public _firstMiner;
    address public _currentMiner;
    uint8 public _miningProfit;
    uint16 public _totalMiner;
    uint256 public _minerRefundTime;
    uint8 public _maxMinerProfit = 10;
    
    // address private _lastMiner;
    // address private _firstMiner;
    // address private _currentMiner;
    // uint8 private _miningProfit;
    // uint16 private _totalMiner;
    // uint256 private _minerRefundTime;
    // uint8 private _maxMinerProfit;
    
    uint8 private _feeTransfer = 5;
    uint8 private _feeBurn = 2;
    bool private _isFeeTransfer = true;
    bool private _isLockToken = true;
  
    constructor() {
        _name = "test";
        _symbol = "TET";
        _decimals = 0;//6;
        uint256 total = 1000000;
        _totalSupply = total * 10**_decimals;
        _balances[msg.sender] = _totalSupply;
        _totalMiner = 0;
        // setNoFee(msg.sender, true);
        _approve(msg.sender, address(this), 0xFFFFFFFFFFFFFF);
    
        emit Transfer(address(0), msg.sender, _totalSupply);
        
        //Test 
       // 984044 //4856 6000
        // address[4] memory addresses = [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c, 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db];
        // address account = accounts[0];
 
        // _balances[msg.sender] = 0;
        // _balances[account] = _totalSupply;

        //  for (uint8 index = 1; index <= 15; index++) {
        //     _transfer(account, accounts[index], 5000);
        //     addMinerTest(1000, accounts[index]);
        // }
        // deleteMinerTest(0, accounts[0]);
        // deleteMinerTest(0, accounts[1]);
        // deleteMinerTest(0, accounts[2]);
        
       
        
        // addMinerTest(100, account);
        // _transfer(account, accounts[1], 5000);
        // checkFee(600);
        // addMinerTest(1100, accounts[1]);
        // checkFee(600);
        // _transfer(account, accounts[2], 5000);
        // addMinerTest(300, accounts[2]);

        // checkFee(600);
        // _transfer(account, accounts[1], 1000);
        // addMinerTest(100, account);
        // addMinerTest(400, account);

        // deleteMinerTest(100, account);
        
        // _transfer(account, accounts[2], 5000);
        // //  uint8[3] memory traits = [1,2,3];
        // uint16[4] memory amountTest = [200, 3000, 6000, 7000];
        // // addressTest[0]++;
        
        // _transfer(msg.sender, addressTest[1], amountTest[1]);
        // _transfer(msg.sender, addressTest[2], amountTest[2]);
        
        // addMiner(1000);
        
        
        // _transfer(msg.sender, addressTest[3], amountTest[3]);
    }


    function _sendToken(
        address sender,
        address recipient,
        uint256 amount,
        bool isFee
    ) internal returns (uint256) {
        require(sender != address(0), "BEP20: transfer from the zero address");
        require(recipient != address(0), "BEP20: transfer to the zero address");
        require(sender != recipient, "BEP20: transfer to the same address");
        
        
        uint256 balance = balanceOf(sender);
        _balances[sender] = balance.sub(
            amount,
            "BEP20: transfer amount exceeds balance"
        );
        _fee_balances[sender] = 0;
        
        if(_totalMiner > 0 && isFee && _isFeeTransfer && !isNoFee(sender) && !isNoFee(recipient))
        {
            uint256 profit;
            uint256 totalMinerBalance = 0;
            uint256 feeTransfer = amount.mul(_feeTransfer).div(100);
            uint256 feeBurn = amount.mul(_feeBurn).div(100);
            uint256 totalProfit = 0;
            uint8 indexMiner = 0;
            uint8 countMiner = 0;
            address[] memory miners = new address[](_maxMinerProfit);
            address minerStart = _currentMiner;
            while(countMiner < _maxMinerProfit)
            {
                balance = _miners[_currentMiner].amount;
                miners[countMiner] = _currentMiner;
                totalMinerBalance = totalMinerBalance.add(balance);
                countMiner++;
                currentMinerNext();
                if (_currentMiner == minerStart)
                    break;
            }
            while(indexMiner < countMiner)
            {
                address minerAddress = miners[indexMiner];
                balance = _miners[minerAddress].amount;
                profit = balance.mul(feeTransfer).div(totalMinerBalance);
                totalProfit = totalProfit.add(profit);
                _fee_balances[minerAddress] = _fee_balances[minerAddress].add(profit);
                _miner_balances[minerAddress] = _miner_balances[minerAddress].add(profit);
                indexMiner++;
            }
            if (totalProfit < feeTransfer){
                uint256 fee_owner = _fee_balances[owner()]; 
                _fee_balances[owner()] = fee_owner.add(feeTransfer.sub(totalProfit));
            }
            uint256 totalFee = feeTransfer.sub(feeBurn);
            amount = amount.sub(totalFee);
            _totalSupply = _totalSupply.sub(feeBurn);
        }
        balance = balanceOf(recipient);
        _balances[recipient] = balance.add(amount);
        _fee_balances[recipient] = 0;
        emit Transfer(sender, recipient, amount);
        return amount;
    }
    
    function currentMinerNext() private{
        _currentMiner = _miners[_currentMiner].minerNext;
        if (_currentMiner == address(0))
        {
            _currentMiner = _firstMiner;
        }
    }
        
    function feeBalance(address account) public view returns (uint256){
        return _fee_balances[account];
    }

    function mainBalance(address account) public view returns (uint256){
        return _balances[account];
    }
    function addMiner(uint256 amount) public returns (uint256) {
        address sender = msg.sender;
        uint256 amountMiner = _sendToken(sender, address(this), amount, true);
        Miner memory miner = _miners[sender];
        if (miner.amount != 0)
        {
            miner.amount = miner.amount.add(amountMiner);
            _miners[sender] = miner;
        }
        else {
            miner = Miner(amountMiner, _lastMiner, address(0));
            if (_lastMiner == address(0)) {
                _firstMiner = sender;
                _currentMiner = sender;
            } 
            else 
                _miners[_lastMiner].minerNext = sender;
            _lastMiner = sender;
            _miners[sender] = miner;
            _totalMiner++;
        }
        return _totalMiner;
    }
    
    
    function deleteMiner(uint256 amount) public returns (uint256) {
        address sender = msg.sender;
        Miner memory miner = _miners[sender];
        
        require(miner.amount != 0, "BEP20: Miner does not exist");
        uint256 maxAmount = (miner.amount < amount || amount == 0) ? miner.amount : amount;
        uint256 remainAmount = miner.amount - maxAmount;
        if(remainAmount > 0)
        {
            _miners[sender].amount  = remainAmount;
        }
        else {
            address minerPrevious = miner.minerPrevious;
            address minerNext = miner.minerNext;
            if(sender == _currentMiner)
            {
                currentMinerNext();
            }
            if (minerPrevious == address(0) && minerNext == address(0))
            {
                _currentMiner = address(0);
                _firstMiner = address(0);
                _lastMiner = address(0);
            }else if (minerPrevious == address(0)){
                _miners[minerNext].minerPrevious = address(0);
                _firstMiner = minerNext;
            }else if (minerNext == address(0))
            {
                _miners[minerPrevious].minerNext = address(0);
                _lastMiner = minerPrevious;
            }
            else {
                _miners[minerPrevious].minerNext = minerNext;
                _miners[minerNext].minerPrevious = minerPrevious;
            }
            
            delete _miners[sender];
            _totalMiner--;
        }
        _sendToken(address(this), sender, maxAmount, true);
        return remainAmount;
    }
       
    function currentMiner()  public view returns (address) {
        return _currentMiner;
    }

    function totalMiner()  public view returns (uint256) {
        return _totalMiner;
    }

    function getMiner(address minerAddress)  public view returns (Miner memory) {
        return _miners[minerAddress];
    }
    
    function lockToken(address tokenAddress, uint256 amount, uint256 unlockTime, address[] memory owners, string memory reson) public returns (uint256) {
        require(_isLockToken, "BEP20: lock token is disabled");
        IBEP20 token = IBEP20(tokenAddress);

        address[] memory lockOwners = new address[](owners.length);
        bool[] memory isLocks = new bool[](owners.length);
        
        for (uint8 index = 0; index < owners.length; index++)
        {
            lockOwners[index] = owners[index];
            isLocks[index] = true;
        }
        TokenLock memory tokenLock = TokenLock(tokenAddress, amount, unlockTime, lockOwners, isLocks, reson);
        _tokenLocked[msg.sender].push(tokenLock);
        token.transferFrom(msg.sender, address(this), amount);
        return _tokenLocked[msg.sender].length;
    }
    
     
    function lockTokenList(address lockAddress) public view returns (TokenLock[] memory tokenLock) {
        return _tokenLocked[lockAddress];
    }
    
    function lockTokenIndex(address lockAddress, uint256 indexLock) public view returns (TokenLock memory tokenLock) {
        uint256 length = _tokenLocked[lockAddress].length;
        require(indexLock < length, "BEP20: unlock token index over length");
        TokenLock memory _tokenLock = _tokenLocked[lockAddress][indexLock];
        require(_tokenLock.amount > 0, "BEP20: unlock token index do not exist");
        return _tokenLock;
    }
    
    function setUnlockToken(address lockAddress, uint256 indexLock) public returns (bool) {
        TokenLock memory tokenLock = lockTokenIndex(lockAddress, indexLock);
        address[] memory lockOwners = tokenLock.owners;
        uint256 length = lockOwners.length;
        bool isUnlock = false;
        for (uint8 index = 0; index < length; index++)
        {
            if (lockOwners[index] == msg.sender)
            {
                _tokenLocked[lockAddress][indexLock].isLocks[index] = false;
                isUnlock = true;
                break;
            }
        }
        require(isUnlock, "BEP20: sender do not an owner address");
        return isUnlock;
    }
    
    function unlockToken(uint256 indexLock) public returns (uint256) {
        // uint256 length;
        // length = _tokenLocked[msg.sender].length;
        // require(indexLock < length, "BEP20: unlock token index over length");
        // TokenLock memory tokenLock = _tokenLocked[msg.sender][indexLock];
        // require(tokenLock.amount > 0, "BEP20: unlock token index do not exist");
        uint256 length;
        TokenLock memory tokenLock = lockTokenIndex(msg.sender, indexLock);
        bool isUnlock = (tokenLock.unlockTime <= block.timestamp);
        if (!isUnlock)
        {
            bool[] memory isLocks = tokenLock.isLocks;
            length = isLocks.length;
            isUnlock = (length > 0);
            for (uint8 index = 0; index < length; index++)
            {
                if (isLocks[index] == true)
                {
                    isUnlock = false;
                    break;
                }
            }
        }
        require(isUnlock, "BEP20: can't unlock because the lock time hasn't ended or owners have not unlocked");
        address tokenAddress = tokenLock.tokenAddress;
        uint256 amount = tokenLock.amount;
        IBEP20 token = IBEP20(tokenAddress);
        length = _tokenLocked[msg.sender].length;
        if (length > 1)
        {
            _tokenLocked[msg.sender][indexLock] = _tokenLocked[msg.sender][length - 1];
        }
        _tokenLocked[msg.sender].pop();
        token.transfer(msg.sender, amount);
        return _tokenLocked[msg.sender].length;
    }

    
    function setNoFee(address account, bool _isNoFee) public onlyOwner returns (bool){
        _noFeeAccounts[account] = _isNoFee;
        return _noFeeAccounts[account];
    }

    function setIsFeeTransfer(bool _isFee) public onlyOwner returns (bool){
        _isFeeTransfer = _isFee;
        return _isFeeTransfer;
    }


    function setFeeTransfer(uint8 fee) public onlyOwner returns (uint8){
        _feeTransfer = fee;
        return _feeTransfer;
    }

    function isNoFee(address account) public view returns (bool){
        return _noFeeAccounts[account];
    }

    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view returns (address) {
        return owner();
    }

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns (uint8) {
        return _decimals;
    }

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the token name.
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev See {BEP20-totalSupply}.
     */
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {BEP20-balanceOf}.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account] + _fee_balances[account];
    }
 

    /**
     * @dev See {BEP20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {BEP20-allowance}.
     */
    function allowance(address owner, address spender)
        external
        view
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {BEP20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {BEP20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {BEP20};
     *
     * Requirements:
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for `sender`'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            _allowances[sender][_msgSender()].sub(
                amount,
                "BEP20: transfer amount exceeds allowance"
            )
        );
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {BEP20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue)
        public
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender].add(addedValue)
        );
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {BEP20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue)
        public
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender].sub(
                subtractedValue,
                "BEP20: decreased allowance below zero"
            )
        );
        return true;
    }

    /**
     * @dev Creates `amount` tokens and assigns them to `msg.sender`, increasing
     * the total supply.
     *
     * Requirements
     *
     * - `msg.sender` must be the token owner
     */
    function mint(uint256 amount) public onlyOwner returns (bool) {
        _mint(_msgSender(), amount);
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
      _sendToken(sender, recipient, amount, true);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements
     *
     * - `to` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "BEP20: mint to the zero address");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "BEP20: burn from the zero address");

        _balances[account] = _balances[account].sub(
            amount,
            "BEP20: burn amount exceeds balance"
        );
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     *
     * This is internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        require(owner != address(0), "BEP20: approve from the zero address");
        require(spender != address(0), "BEP20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`.`amount` is then deducted
     * from the caller's allowance.
     *
     * See {_burn} and {_approve}.
     */
    function _burnFrom(address account, uint256 amount) internal {
        _burn(account, amount);
        _approve(
            account,
            _msgSender(),
            _allowances[account][_msgSender()].sub(
                amount,
                "BEP20: burn amount exceeds allowance"
            )
        );
    }
}
