// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;


contract AccountState {
    address private owner;
    uint256 total = 0;
    struct Order {
        uint256 id;
        string token;
        uint256 value;
        uint256 price;
        bool existed;
    }
    mapping(uint256 => Order) private orders;
    constructor(address _owner) {
        owner = _owner;
    }

    modifier onlyOwner(string memory message) {
        require(msg.sender == owner, string(abi.encodePacked("Only contract owner can", message)));
        _;
    }

    function create_order(string memory _token, uint256 _value, uint256 _price) external payable onlyOwner("create") {
        require(msg.sender == owner, string(abi.encodePacked("Only contract owner can create")));
        orders[total] = Order(total, _token, _value, _price, true);
        total++;    
    }
    
    function update_order(uint256 _id, string memory _token, uint256 _value, uint256 _price) external payable onlyOwner("update") {
        require(orders[_id].existed, "Order does not exist");
        Order memory _newOrder = Order(_id, _token, _value, _price, true);
        orders[_id] = _newOrder;
    }

    function get_orders() external view onlyOwner("list") returns (Order[] memory) {
        Order[] memory _orders = new Order[](total);
        for (uint256 i = 0; i < total; i++) {
            _orders[i] = orders[i];
        }
        return _orders;
    }

    function get_order_by_id(uint256 _id) public view onlyOwner("get") returns (Order memory) {
        return orders[_id];
    }
}