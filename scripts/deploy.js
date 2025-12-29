const hre = require("hardhat");

async function main() {
    // Get the contract factory
    const PullPaymentVault = await hre.ethers.getContractFactory(
        "PullPaymentVault"
    );

    // Deploy the contract
    const vault = await PullPaymentVault.deploy();

    // Wait until deployment is complete
    await vault.waitForDeployment();

    // Log deployed address
    console.log(
        "PullPaymentVault deployed to:",
        await vault.getAddress()
    );
}

// Standard Hardhat error handling
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
