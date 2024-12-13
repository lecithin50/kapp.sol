// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SupplyChain {
    // Ürün yapısı
    struct Product {
        string id; // Ürün kimliği
        string name; // Ürün adı
        string manufacturer; // Üretici adı
        uint256 ecoScore; // Eko puan
        uint256 timestamp; // Eklenme zamanı
    }

    // Ürünlerin depolanması için bir mapping
    mapping(string => Product) private products;

    // Ürün eklendiğinde bir olay tetiklenir
    event ProductAdded(
        string id,
        string name,
        string manufacturer,
        uint256 ecoScore,
        uint256 timestamp
    );

    // Yeni bir ürün eklemek için bir fonksiyon
    function addProduct(
        string memory _id,
        string memory _name,
        string memory _manufacturer,
        uint256 _ecoScore
    ) public {
        require(bytes(_id).length > 0, "Product ID is required");
        require(bytes(_name).length > 0, "Product name is required");
        require(bytes(_manufacturer).length > 0, "Manufacturer is required");
        require(_ecoScore <= 100, "Eco score must be 100 or less");

        // Yeni ürünü oluştur ve kaydet
        products[_id] = Product({
            id: _id,
            name: _name,
            manufacturer: _manufacturer,
            ecoScore: _ecoScore,
            timestamp: block.timestamp
        });

        // Olayı yay
        emit ProductAdded(_id, _name, _manufacturer, _ecoScore, block.timestamp);
    }

    // Ürün bilgilerini almak için bir fonksiyon
    function getProduct(string memory _id)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            uint256,
            uint256
        )
    {
        Product memory product = products[_id];
        require(bytes(product.id).length > 0, "Product not found");

        return (
            product.id,
            product.name,
            product.manufacturer,
            product.ecoScore,
            product.timestamp
        );
    }
}
