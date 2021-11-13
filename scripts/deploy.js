async function main() {
    const [deployer] = await ethers.getSigners()
    console.log("Deploying contract with the account", deployer.address)
    
    const crowdfund = await ethers.getContractFactory("CrowdFund")
    const crowdfundCampaign =await crowdfund.deploy()
    console.log("Actual Goal", (await crowdfundCampaign.viewGoal()).toString())
    console.log("Contract address:", crowdfundCampaign.address)
}

main()
    .then(()=>process.exit(0))
    .catch((error)=>{
        console.log(error)
        process.exit(1)
    })