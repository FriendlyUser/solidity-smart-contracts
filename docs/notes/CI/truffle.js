module.exports = {
  migrations_directory: "./migrations",
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    circleCI: {
      host: "0.0.0.0",
      port: 8545,
      network_id: "*" // Match any network id
    },
    gitlabCI: {
      host: "trufflesuite-ganache-cli"
      port: 8545,
      network_id: "*" // Match any network id
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 500
    }
  } 
};