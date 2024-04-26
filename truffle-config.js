module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 9545, // Default port for Ganache; adjust if using a different port
      network_id: "*", // Connect to any network
    },
  },
  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.20", // Fetch exact version from solc-bin
      settings: {
        optimizer: {
          enabled: true,
          runs: 200, // Optimize for how many times you intend to run the code
        },
      },
    },
  },
};
