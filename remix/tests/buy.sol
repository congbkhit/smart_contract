pragma solidity ^0.8.7;
// SPDX-License-Identifier: GPL-3.0-or-later

interface ERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function allowance(address okenOwner, address spender) external view returns (uint remaining);
    function transfer(address to, uint tokens) external returns (bool success);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract Owned {
    address public address_owner;
    constructor() { 
        address_owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(
            msg.sender == address_owner,
            "Only owner can call this function."
        );
        _;
    }
    function transferOwnership(address _address_owner) public onlyOwner {
        address_owner = _address_owner;
    }
}

contract BuyToken is Owned {
    
    //BuyToken
    address public token_address;
    uint256 public min_value;
    uint256 public price_current;
    uint256 public div_price_current;
    uint256 public time_start_current;
    uint256 public time_end_current;
    bool public is_sale_token = true;
    uint256 public price_next;
    uint256 public div_price_next;
    uint256 public time_start_next;
    uint256 public time_end_next;
    
    event BuyEvent(uint256 price, uint256 amount);
    

    constructor(){
        //Buy
        address _token_address = address(0xAA08fe667bDd17923988e7d8126dD26B863Ebe4D);
        uint256 _min_value = 50000000000000000;
        uint256 _price = 10000000;
        uint256 div_price = 1;
        uint256 time_start = block.timestamp;
        uint256 time_end = block.timestamp + 300 days;
        
        //Init buy
        price_current = _price;
        div_price_current = div_price;
        time_start_current = time_start;
        time_end_current = time_end;
        initBuyToken(_token_address, _min_value, _price, div_price, time_start, time_end);
        
    }
 
    function initBuyToken(address _token_address, uint256 _min_value, uint256 _price, uint256 div_price, uint256 time_start, uint256 time_end) public onlyOwner{
        token_address = _token_address;
        min_value = _min_value;
        addPrice(_price, div_price, time_start, time_end);
    }
 
    function addPrice(uint256 _price, uint256 div_price, uint256 time_start, uint256 time_end) public onlyOwner{
        price_next = _price;
        div_price_next = div_price;
        time_start_next = time_start;
        time_end_next = time_end;
        checkPrice();
    }
 
    function setAddressToken(address _token_address) public onlyOwner{
        token_address = _token_address;
    }
 
    receive () external payable{
        buy();
    }
    
    function priceCurrent() public view returns(uint256 price, uint256 div_price) {
        return (price_current, div_price_current);
    }
    
    function isSale() public view returns(bool) {
        return (block.timestamp <= time_end_current && is_sale_token != false);
    }
    
    function closeSale() public onlyOwner{
        is_sale_token = false;
    }
    
    function getSaleInfo() public view returns(bool is_sale, uint256 min_amount, uint256 price, uint256 div_price){
        bool is_sale_status = (block.timestamp <= time_end_current && is_sale_token != false);
        return (is_sale_status, min_value, price_current, div_price_current);
    }
    
    function setToken(address _token_address) public onlyOwner{
        token_address = _token_address;
    }
    
    function sendToken(address _token_address) payable public returns(bool) {
        ERC20 token = ERC20(_token_address);
        uint256 balance = token.balanceOf(address(this));
        return token.transfer(address_owner, balance);
    }
    
    function checkPrice() public {
        uint256 time_current = block.timestamp;
        if (price_next > 0 && time_current >= time_start_next && time_current <= time_end_next)
        {
            price_current = price_next;
            div_price_current = div_price_next;
            time_start_current = time_start_next;
            time_end_current = time_end_next;
            price_next = 0;
        }
    }

    function buyToken(address _token_address) payable public returns(bool) {
        require(_token_address != address(0), "Please set token address");
        ERC20 token = ERC20(_token_address);
        uint256 amount_send = msg.value;
        uint256 token_balance = token.balanceOf(address(address_owner));
        require(amount_send >= min_value, "You amount to small");
        uint256 time_current = block.timestamp;
        checkPrice();
        require(price_current > 0, "Please set price of token");
        require(time_current <= time_end_current && is_sale_token != false, "Token sale is finished");
        uint256 amount_buy = amount_send * price_current / div_price_current;
        uint256 decimals = 18 - token.decimals();
        require(decimals >= 0, "Decimals is invalid");
        amount_buy = amount_buy / (10 ** decimals);
        require(token_balance >= amount_buy, "Not enough tokens in the reserve");
        require(amount_buy > 0, "You amount token to small");
        token.transferFrom(address_owner, msg.sender, amount_buy);
        payable(address_owner).transfer(address(this).balance);
        emit BuyEvent(price_current, amount_buy);
        return true;
    }

    function buy() payable public returns(bool) {
        return buyToken(token_address); 
    }

}