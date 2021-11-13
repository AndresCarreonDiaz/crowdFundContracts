const { expect } =  require("chai");

describe("Crowd Funding contract", function(){
    it("deployment should assign at least 1 as a goal and funding available", async function(){
        const [owner] = await ethers.getSigners()
        const CrowdFund = await ethers.getContractFactory("CrowdFund");
        const crowdfundCampaign = await CrowdFund.deploy()
        const actualGoal = await crowdfundCampaign.viewGoal()
        console.log(actualGoal)
        expect(await crowdfundCampaign.viewGoal()).to.equal(actualGoal)
    })
    it("should set the right owner", async function(){
        const [owner] = await ethers.getSigners()
        const CrowdFund = await ethers.getContractFactory("CrowdFund");
        const crowdfundCampaign = await CrowdFund.deploy()
        console.log(crowdfundCampaign.owner)
        expect(await crowdfundCampaign.owner).to.equal(owner.address)
    })
})