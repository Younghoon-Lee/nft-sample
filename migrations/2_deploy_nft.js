const CoolSaurusKid = artifacts.require("CoolSaurusKid");

module.exports = function(deployer) {
  deployer.deploy(
    CoolSaurusKid,
      "DAYEON",
      "DY"
      );
};
