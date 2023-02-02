pragma solidity ^0.5.16;

import "../core/Ownable.sol";
import "../accesscontrol/HarvesterRole.sol";
import "../accesscontrol/DistributerRole.sol";
import "../accesscontrol/RetailerRole.sol";
import "../accesscontrol/CustomerRole.sol";


contract SupplyChain is 
    Ownable,
    HarvesterRole,
    DistributerRole,
    RetailerRole,
    CustomerRole
{
    uint upc;
    uint sku;

    struct Wood {
        uint    sku;
        uint    upc;
        address ownerID;
        address originHarvesterID;
        string  originHarvesterName;
        string  originForestInformation;
        string  originForestLatitude;
        string  originForestLongitude;
        uint    productID;
        string  productNotes;
        uint    productPrice;
        State   woodState;
        address distributerID;
        address retailerID;
        address customerID;
    }

    enum State {
        Harvested,  // 0
        Processed,  // 1
        Packed,     // 2
        ForSale,    // 3
        Sold,       // 4
        Shipped,    // 5
        Received,   // 6
        Purchased   // 7
    }

    mapping(uint => Wood) woods;
    mapping(uint => string[]) woodsHistory;

    event Harvested(uint256 upc);
    event Processed(uint256 upc);
    event Packed(uint256 upc);
    event ForSale(uint256 upc);
    event Sold(uint256 upc);
    event Shipped(uint256 upc);
    event Received(uint256 upc);
    event Purchased(uint256 upc);

    modifier verifyCaller(address _address) {
        require(msg.sender == _address, "invalid caller");
        _;
    }

    modifier paidEnough(uint _price) { 
        require(msg.value >= _price, "not enough value"); 
        _;
    }

    modifier checkValue(uint _upc) {
        _;
        uint _price = woods[_upc].productPrice;
        uint amountToReturn = msg.value - _price;
        address(uint160(msg.sender)).transfer(amountToReturn);
    }

    modifier harvested(uint _upc) {
        require(woods[_upc].woodState == State.Harvested);
        _;
    }

    modifier processed(uint _upc) {
        require(woods[_upc].woodState == State.Processed);
        _;
    }

    modifier packed(uint _upc) {
        require(woods[_upc].woodState == State.Packed);
        _;
    }

    modifier forSale(uint _upc) {
        require(woods[_upc].woodState == State.ForSale);
        _;
    }

    modifier sold(uint _upc) {
        require(woods[_upc].woodState == State.Sold);
        _;
    }

    modifier shipped(uint _upc) {
        require(woods[_upc].woodState == State.Shipped);
        _;
    }

    modifier received(uint _upc) {
        require(woods[_upc].woodState == State.Received);
        _;
    }

    modifier purchased(uint _upc) {
        require(woods[_upc].woodState == State.Purchased);
        _;
    }

    constructor() public payable {
        sku = 1;
        upc = 1;
    }

    function kill() public isOwner {
        selfdestruct(msg.sender);
    }

    function harvestWood(
        uint _upc, 
        address _originHarvesterID, 
        string memory _originHarvesterName, 
        string memory _originForestInformation, 
        string memory  _originForestLatitude, 
        string memory  _originForestLongitude, 
        string memory  _productNotes
    )
        public
        isHarvester
    {
        woods[_upc] = Wood({
            sku: sku,
            upc: _upc,
            ownerID: _originHarvesterID,
            originHarvesterID: address(uint160(_originHarvesterID)),
            originHarvesterName: _originHarvesterName,
            originForestInformation: _originForestInformation,
            originForestLatitude: _originForestLatitude,
            originForestLongitude: _originForestLongitude,
            productID: _upc + sku,
            productNotes: _productNotes,
            productPrice: 0,
            woodState: State.Harvested,
            distributerID: address(0),
            retailerID: address(0),
            customerID: address(uint160(0))
        });

        sku += 1;

        emit Harvested(_upc);
    }

    function processWood(uint _upc) 
        public
        isHarvester
        harvested(_upc)
        verifyCaller(woods[_upc].originHarvesterID)
    {
        woods[_upc].woodState = State.Processed;
        
        emit Processed(_upc);
    }

    function packWood(uint _upc) 
        public
        isHarvester
        processed(_upc)
        verifyCaller(woods[_upc].originHarvesterID)
    {
        woods[_upc].woodState = State.Packed;
        
        emit Packed(_upc);
    }

    function sellWood(uint _upc, uint _price) 
        public
        isHarvester
        packed(_upc)
        verifyCaller(woods[_upc].originHarvesterID)
    {
        woods[_upc].woodState = State.ForSale;
        woods[_upc].productPrice = _price;
        
        emit ForSale(_upc);
    }

    function buyWood(uint _upc) 
        public
        payable
        isDistributer
        forSale(_upc)
        paidEnough(woods[_upc].productPrice)
        checkValue(_upc)
    {
        woods[_upc].ownerID = msg.sender;
        woods[_upc].distributerID = msg.sender;
        woods[_upc].woodState = State.Sold;

        address(uint160(woods[_upc].originHarvesterID)).transfer(woods[_upc].productPrice);
        
        emit Sold(_upc);
    }

    function shipWood(uint _upc) 
        public
        isDistributer
        sold(_upc)
        verifyCaller(woods[_upc].distributerID)
    {
        woods[_upc].woodState = State.Shipped;

        emit Shipped(_upc);
    }

    function receiveWood(uint _upc) 
        public 
        isRetailer
        shipped(_upc)
    {
        woods[_upc].ownerID = msg.sender;
        woods[_upc].retailerID = msg.sender;
        woods[_upc].woodState = State.Received;

        emit Received(_upc);
    }

    function purchaseWood(uint _upc) 
        public
        isCustomer
        received(_upc)
    {
        woods[_upc].ownerID = msg.sender;
        woods[_upc].customerID = msg.sender;
        woods[_upc].woodState = State.Purchased;

        emit Purchased(_upc);
    }

    function fetchWoodInfoBufferOne(uint _upc) public view returns
        (
            uint woodSKU,
            uint woodUPC,
            address ownerID,
            address originHarvesterID,
            string memory originHarvesterName,
            string memory originForestInformation,
            string memory originForestLatitude,
            string memory originForestLongitude
        )
    {
        woodSKU = woods[_upc].sku;
        woodUPC = woods[_upc].sku;
        ownerID = woods[_upc].ownerID;
        originHarvesterID = woods[_upc].originHarvesterID;
        originHarvesterName = woods[_upc].originHarvesterName;
        originForestInformation = woods[_upc].originForestInformation;
        originForestLatitude = woods[_upc].originForestLatitude;
        originForestLongitude = woods[_upc].originForestLongitude;

        return (
            woodSKU,
            woodUPC,
            ownerID,
            originHarvesterID,
            originHarvesterName,
            originForestInformation,
            originForestLatitude,
            originForestLongitude
        );
    }

    function fetchWoodInfoBufferTwo(uint _upc) public view returns
        (
            uint productID,
            string memory productNotes,
            uint productPrice,
            uint woodState,
            address distributerID,
            address retailerID,
            address customerID
        )
    {
        productID = woods[_upc].productID;
        productNotes = woods[_upc].productNotes;
        productPrice = woods[_upc].productPrice;
        woodState = uint(woods[_upc].woodState);
        distributerID = woods[_upc].distributerID;
        retailerID = woods[_upc].retailerID;
        customerID = woods[_upc].customerID;

        return (
            productID,
            productNotes,
            productPrice,
            woodState,
            distributerID,
            retailerID,
            customerID
        );
    }
}

