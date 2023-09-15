// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
 
// 1. Tener un token ERC20 que vamos a dar prestado a los usuarios cuando depositen su NFT
// 2. Borrow() -> funcion que me permitira pedir prestado
//   2.1 --> Transferir el NFT del usuario al contrato
//   2.2 --> Valorar el NFT: utilizaremos chainlink
//   2.3 --> Calcular la cantidad de tokens ERC20 que le devolveremos al usuario
 
// 3. Repay() -> devolver el NFT al usuario y que el usuario devuelva los tokens prestados
 
// 4. Liquidate() -> 
 
 
import {ERC20} from "https://github.com/transmissions11/solmate/blob/main/src/tokens/ERC20.sol";
import {ERC721} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
 
contract Token is ERC20 {
 
    error OnlyCodingHeroesLender();
 
    address public immutable codingHeroesLender;
 
    constructor(address _codingHeroesLender) ERC20("CodingHeroesToken", "CHT", 18) {
        codingHeroesLender = _codingHeroesLender;
    }
 
 
    modifier onlyCodingHeroesLender() {
        if(msg.sender != codingHeroesLender) revert OnlyCodingHeroesLender();
        _;
    }
 
 
    function mint(address user, uint256 amount) external onlyCodingHeroesLender {
        _mint(user, amount);
    }
 
}
 
 
contract NFT is ERC721 {
 
    constructor() ERC721("FlashToken", "CR7") {
 
    }
 
    function mint(uint256 tokenId) external {
        _mint(msg.sender, tokenId);
    }
 
}