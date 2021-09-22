// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Marketplace {
    struct Product {
        address owner;
        string name;
        string description;
        uint256 price;
        uint256 quantity;
    }

    mapping(uint256 => Product) internal products;

    // Events
    event AddProduct(
        address prodOwner,
        string name,
        uint256 amount,
        uint256 quantity,
        uint256 totalProductsAvail
    );
    event BuyProduct(
        address buyers,
        address seller,
        uint256 price,
        bool success
    );

    uint256 totalProducts;

    // Add a new product function
    function addProduct(
        string memory _name,
        string memory _desc,
        uint256 _price,
        uint256 _qty
    ) public {
        totalProducts = totalProducts + 1;
        products[totalProducts] = Product(
            msg.sender,
            _name,
            _desc,
            _price,
            _qty
        );

        emit AddProduct(msg.sender, _name, _price, _qty, totalProducts);
    }

    // Custom error
    error productNotAvailable(uint256 requested, uint256 total);

    // Get a partivular product details
    function getProduct(uint256 _index)
        public
        view
        returns (
            string memory,
            string memory,
            uint256,
            uint256
        )
    {
        if (_index > totalProducts) {
            revert productNotAvailable({
                requested: _index,
                total: totalProducts
            });
        }

        return (
            products[_index].name,
            products[_index].description,
            products[_index].price,
            products[_index].quantity
        );
    }

    // Function to get a particular product owner
    function getProductOwner(uint256 _index) public view returns (address) {
        return products[_index].owner;
    }

    // Function to get the total product available in the store
    function productLength() public view returns (uint256) {
        return totalProducts;
    }
}
