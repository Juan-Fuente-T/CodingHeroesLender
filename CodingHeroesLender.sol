// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;
 
// 1. Tener un token ERC20 que vamos a dar prestado a los usuarios cuando depositen su NFT ✅
// 2. Borrow() -> funcion que me permitira pedir prestado
//   - 2.1 --> Transferir el NFT del usuario al contrato ✅
//   - 2.2 --> Valorar el NFT: utilizaremos chainlink ✅
//   - 2.3 --> Calcular la cantidad de tokens ERC20 que le devolveremos al usuario ✅
 
// 3. Repay() -> devolver el NFT al usuario y que el usuario devuelva los tokens prestados
 
// 4. Liquidate() ->
 
import {ERC20} from "https://github.com/transmissions11/solmate/blob/main/src/tokens/ERC20.sol";
import {ERC721, IERC721} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import {IERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
 
 
interface ITokenDeuda {
    function mint(address user, uint256 amount) external;
}
 
 
interface IAggregator {
    function latestRoundData()
        external
        view
        returns (
            uint80 roundId, // identificador de la ronda
            int256 answer, // respuesta del agregador (en este caso, el precio floor del NFT) <-- el único que me interesa
            uint256 startedAt, // cuando empezó la ronda
            uint256 updatedAt, // cuando se actualizó la ronda
            uint80 answeredInRound // identificador de la ronda en el que la respuesta se añadió
        );
}
 
contract Token is ERC20 {
    error OnlyCodingHeroesLender();
 
    address public immutable codingHeroesLender;
 
    constructor(address _codingHeroesLender)
        ERC20("CodingHeroesToken", "CHT", 18)
    {
        codingHeroesLender = _codingHeroesLender;
    }
 
    modifier onlyCodingHeroesLender() {
        if (msg.sender != codingHeroesLender) revert OnlyCodingHeroesLender();
        _;
    }
 
    function mint(address user, uint256 amount)
        external
        onlyCodingHeroesLender
    {
        _mint(user, amount);
    }
}
 
contract NFT is ERC721 {
    constructor() ERC721("FlashToken", "CR7") {}
 
    function mint(uint256 tokenId) external {
        _mint(msg.sender, tokenId);
    }
}
 
contract CodingHeroesLender {
    /// Error
    error NotOwner();
    error YouAlreadyHaveDebt();
    error NoDebt();
 
    /// Variable que guarda nuestro contrato del NFT
    address public immutable contratoNFT;
 
    address public token;
 
    address owner;
 
    uint256 LTV = 50 * 10 ** 16;
 
    /// Variable que guarda la dirección del agregador de Chainlink del floor price de Moonbirds
    IAggregator public immutable chainlinkPriceFeed;
 
    uint256 public price;
 
    mapping(address => uint256) deuda;
    mapping(address => uint256) colateral;
 
    modifier OnlyOwner {
        if(msg.sender != owner) revert NotOwner();
        _;
    }
 
    constructor(address _contratoNFT, address _chainlinkPriceFeed) {
        owner = msg.sender;
        contratoNFT = _contratoNFT;
        chainlinkPriceFeed = IAggregator(_chainlinkPriceFeed);
    }
 
    function setToken(address _token) external OnlyOwner {
        token = _token;
    }
 
    function borrow(uint256 tokenId) external {
        /// Verificar que el usuario es el dueño del NFT
        if (msg.sender != IERC721(contratoNFT).ownerOf(tokenId)) {
            revert NotOwner();
        }
 
        if(deuda[msg.sender] > 0) revert YouAlreadyHaveDebt();
 
        /// Transferir el NFT del usuario a este contrato
        IERC721(contratoNFT).transferFrom(msg.sender, address(this), tokenId);
 
        /// Pedir el precio del NFT a chainlink
        (, int256 nftPrice, , , ) = chainlinkPriceFeed.latestRoundData();
 
        price = uint256(nftPrice);
 
        // LOAN TO VALUE = el porcentage que puedes pedir de deuda sobre el valor de tu colateral
        // LTV = 50% -> 10 ETH ( 5 ETH )
 
        // Crear X tokens como deuda puede tomar el usuario y enviárselo
        uint256 loanAmount = (price * LTV) / 10 ** 18;
 
        deuda[msg.sender] += loanAmount;
        colateral[msg.sender] = tokenId;
 
        ITokenDeuda(token).mint(msg.sender, loanAmount);