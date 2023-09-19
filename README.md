#Coding Heroes Lender
####Loan and NFT Collateral Contract
This contract implements a lending and NFT collateralization system. It allows users to take loans using their NFTs as collateral and later repay the loans to retrieve their NFTs. It also uses a Chainlink oracle to determine the value of the NFTs.

##Features
The contract provides the following features:

- Loan Creation: Users can take loans using their NFTs as collateral.

- Loan Repayment: Users can repay loans to retrieve their NFTs.

- Liquidation: The contract owner can liquidate a position if necessary.

##Usage
###Loan Creation
To take a loan, follow these steps:

- Ensure you are the owner of the NFT you want to use as collateral.

- Call the borrow(uint256 tokenId) function, providing the ID of the NFT you want to use as collateral. This will lock the NFT as collateral and allow you to take a loan.

###Loan Repayment
To repay a loan, follow these steps:

- Call the repay(uint256 amount) function, providing the amount you want to pay towards your debt. This will reduce your debt, and if you pay it in full, it will return your NFT.

###Liquidation
The liquidation function can only be called by the contract owner and is used to liquidate a position if necessary.

###Token Emission
When a user uses an NFT as collateral to request a loan, the contract issues our own tokens (FlashToken, CR7) to the user based on the value of the NFT. These tokens represent the debt that the user has incurred with the contract. Users can use these tokens to pay off their debt or perform other operations within the system.

It is important to note that these tokens have no financial value and cannot be traded on the market. Users should be aware of the financial implications when applying for loans and managing tokens issued by the contract.

##Contributions
Contributions are welcome. If you wish to contribute to this contract or report issues, you can do so through pull requests or issue reports in this repository.

##License
This contract is distributed under the GNU General Public License (GPL-3.0).

####Feel free to make any additional modifications or adjustments as needed.




