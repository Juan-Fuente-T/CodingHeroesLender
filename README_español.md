# Coding Heroes Lender
#### Contrato de Préstamos y Colateralización de NFT

Este contrato implementa un sistema de préstamos y colateralización de NFT. Permite a los usuarios tomar préstamos utilizando sus NFT como colateral y luego pagar los préstamos para recuperar sus NFT. También utiliza un oráculo de Chainlink para determinar el valor de los NFT.

## Características
El contrato proporciona las siguientes características:

- Creación de Préstamos: Los usuarios pueden tomar préstamos utilizando sus NFT como colateral.

- Reembolso de Préstamos: Los usuarios pueden pagar préstamos para recuperar sus NFT.

- Liquidación: El propietario del contrato puede liquidar una posición si es necesario.

## Uso
### Creación de Préstamos

Para tomar un préstamo, siga estos pasos:

- Asegúrese de ser el propietario del NFT que desea utilizar como colateral.

- Llame a la función borrow(uint256 tokenId), proporcionando el ID del NFT que desea utilizar como colateral. Esto bloqueará el NFT como colateral y le permitirá tomar un préstamo.

### Reembolso de Préstamos

Para pagar un préstamo, siga estos pasos:

- Llame a la función repay(uint256 amount), proporcionando la cantidad que desea pagar hacia su deuda. Esto reducirá su deuda, y si la paga en su totalidad, le devolverá su NFT.

### Liquidación

La función de liquidación solo puede ser llamada por el propietario del contrato y se utiliza para liquidar una posición si es necesario.

### Emisión de Tokens

Cuando un usuario utiliza un NFT como colateral para solicitar un préstamo, el contrato emite nuestros propios tokens (FlashToken, CR7) al usuario en función del valor del NFT. Estos tokens representan la deuda que el usuario ha contraído con el contrato. Los usuarios pueden utilizar estos tokens para pagar su deuda u realizar otras operaciones dentro del sistema.

Es importante tener en cuenta que estos tokens no tienen valor financiero y no pueden ser intercambiados en el mercado. Los usuarios deben estar conscientes de las implicaciones financieras al solicitar préstamos y gestionar los tokens emitidos por el contrato.

## Contribuciones

Las contribuciones son bienvenidas. Si desea contribuir a este contrato o informar problemas, puede hacerlo a través de solicitudes de extracción (pull requests) o informes de problemas (issue reports) en este repositorio.

## Licencia

Este contrato se distribuye bajo la Licencia Pública General de GNU (GPL-3.0).

#### Siéntase libre de realizar cualquier modificación adicional o ajustes según sea necesario.




