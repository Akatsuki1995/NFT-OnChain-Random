module.exports = async ({
    getNamedAccounts,
    deployments,
    getChainId
}) => {
    const DECIMALS = '18'
    const INITIAL_PRICE = '200000000000000000000'
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()
    const chainId = await getChainId()
    // If we are on a local development network, we need to deploy mocks!
    if (chainId == 31337) {
        log("Local network detected! Deploying mocks...")
        const LinkToken = await deploy('LinkToken', { from: deployer, log: true })
        const VRFCoordinatorMock = await deploy('VRFCoordinatorMock',{
            from: deployer,
            logs: true,
            args: [LinkToken.address]
        })
        log("Mocks deployed!")
    }
}
module.exports.tags = ['all', 'rsvg', 'svg']