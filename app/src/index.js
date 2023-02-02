import Web3 from "web3";
import supplyChainArtifact from "../../build/contracts/SupplyChain.json";

const App = {
  web3Provider: null,
  supplyChain: null,
  emptyAddress: "0x0000000000000000000000000000000000000000",
  sku: 0,
  upc: 0,
  metamaskAccountID: "0x0000000000000000000000000000000000000000",
  ownerID: "0x0000000000000000000000000000000000000000",
  originHarvesterID: "0x0000000000000000000000000000000000000000",
  originHarvesterName: null,
  originForestInformation: null,
  originForestLatitude: null,
  originForestLongitude: null,
  productNotes: null,
  productPrice: 0,
  distributerID: "0x0000000000000000000000000000000000000000",
  retailerID: "0x0000000000000000000000000000000000000000",
  customerID: "0x0000000000000000000000000000000000000000",

  start: async function () {
    const { web3 } = this;
    try {
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = supplyChainArtifact.networks[networkId];
      this.supplyChain = new web3.eth.Contract(
        supplyChainArtifact.abi,
        deployedNetwork.address,
      );
      
      const accounts = await web3.eth.getAccounts();
      this.metamaskAccountID = accounts[0];

      this.fetchEvents();
    } catch (error) {
      console.error("could not connect to SupplyChain contract", error)
    }
  },

  readForm: function () {
    App.sku = $("#sku").val();
    App.upc = $("#upc").val();
    App.ownerID = $("#ownerID").val();
    App.originHarvesterID = $("#originHarvesterID").val();
    App.originHarvesterName = $("#originHarvesterName").val();
    App.originForestInformation = $("#originForestInformation").val();
    App.originForestLatitude = $("#originForestLatitude").val();
    App.originForestLongitude = $("#originForestLongitude").val();
    App.productNotes = $("#productNotes").val();
    App.productPrice = $("#productPrice").val();
    App.distributerID = $("#distributerID").val();
    App.retailerID = $("#retailerID").val();
    App.customerID = $("#customerID").val();

    console.log(
        App.sku,
        App.upc,
        App.ownerID, 
        App.originHarvesterID, 
        App.originHarvesterName, 
        App.originForestInformation, 
        App.originForestLatitude, 
        App.originForestLongitude, 
        App.productNotes, 
        App.productPrice, 
        App.distributerID, 
        App.retailerID, 
        App.customerID
    );
  },

  harvestWood: async function() {
    const { harvestWood } = this.supplyChain.methods;

    try {
      const result = await harvestWood(
        this.upc, 
        this.metamaskAccountID, 
        this.originHarvesterID, 
        this.originForestInformation, 
        this.originForestLatitude, 
        this.originForestLongitude, 
        this.productNotes
      ).send({
        from: this.metamaskAccountID,
      });
      console.log('harvestWood',result);
    } catch (error) {
      console.log(error);
    }
  },

  processWood: async function () {
    const { processWood } = this.supplyChain.methods;

    try {
      const result = await processWood(
        this.upc,
      ).send({
        from: this.metamaskAccountID,
      });
      console.log('processWood',result);
    } catch (error) {
      console.log(error);
    }
  },

  packWood: async function () {
    const { packWood } = this.supplyChain.methods;

    try {
      const result = await packWood(
        this.upc,
      ).send({
        from: this.metamaskAccountID,
      });
      console.log('packWood',result);
    } catch (error) {
      console.log(error);
    }
  },

  sellWood: async function () {
    const { sellWood } = this.supplyChain.methods;

    try {
      const _productPrice = this.web3.utils.toWei("1000000", "gwei");
      console.log("productPrice", _productPrice);

      const result = await sellWood(
        this.upc,
        _productPrice,
      ).send({
        from: this.metamaskAccountID,
      });
      console.log('sellWood',result);
    } catch (error) {
      console.log(error);
    }
  },

  buyWood: async function () {
    const { buyWood } = this.supplyChain.methods;

    try {
      const walletValue = this.web3.utils.toWei("2000000", "gwei");

      const result = await buyWood(
        this.upc,
      ).send({
        from: this.metamaskAccountID,
        value: walletValue,
      });
      console.log('buyWood',result);
    } catch (error) {
      console.log(error);
    }
  },

  shipWood: async function () {
    const { shipWood } = this.supplyChain.methods;

    try {
      const result = await shipWood(
        this.upc,
      ).send({
        from: this.metamaskAccountID,
      });
      console.log('shipWood',result);
    } catch (error) {
      console.log(error);
    }
  },

  receiveWood: async function () {
    const { receiveWood } = this.supplyChain.methods;

    try {
      const result = await receiveWood(
        this.upc,
      ).send({
        from: this.metamaskAccountID,
      });
      console.log('receiveWood',result);
    } catch (error) {
      console.log(error);
    }
  },

  purchaseWood: async function () {
    const { purchaseWood } = this.supplyChain.methods;

    try {
      const result = await purchaseWood(
        this.upc,
      ).send({
        from: this.metamaskAccountID,
      });
      console.log('purchaseWood',result);
    } catch (error) {
      console.log(error);
    }
  },

  fetchWoodInfoBufferOne: async function () {
    App.upc = $('#upc').val();
    console.log('upc',App.upc);
    const { fetchWoodInfoBufferOne } = this.supplyChain.methods;

    try {
      const result = await fetchWoodInfoBufferOne(
        this.upc,
      ).call({
        from: this.metamaskAccountID,
      });
      console.log('fetchWoodInfoBufferOne',result);
    } catch (error) {
      console.log(error);
    }
  },

  fetchWoodInfoBufferTwo: async function () {
    App.upc = $('#upc').val();
    console.log('upc',App.upc);
    const { fetchWoodInfoBufferOne } = this.supplyChain.methods;

    try {
      const result = await fetchWoodInfoBufferOne(
        this.upc,
      ).call({
        from: this.metamaskAccountID,
      });
      console.log('fetchWoodInfoBufferOne',result);
    } catch (error) {
      console.log(error);
    }
  },

  fetchEvents: function () {
    const supplyChainEvents = this.supplyChain.events;
    supplyChainEvents.allEvents()
    .on('data', (data) => {
      $("#ftc-events").append('<li>' + data.event + ' - ' + data.transactionHash + '</li>');
    })
    .on('changed', (event) => {
      console.log("changed", event);
    })
    .on('error', console.error);
  }
};

window.App = App;

window.addEventListener("load", function() {
  App.readForm();

  if (window.ethereum) {
    // use MetaMask's provider
    App.web3 = new Web3(window.ethereum);
    window.ethereum.enable(); // get permission to access accounts
  } else {
    console.warn(
      "No web3 detected. Falling back to http://127.0.0.1:8545. You should remove this fallback when you deploy live",
    );
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    App.web3 = new Web3(
      new Web3.providers.HttpProvider("http://127.0.0.1:8545"),
    );
  }

  App.start();
});