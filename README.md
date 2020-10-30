# Blockchain Ethereum - Smart Contracts - Aprendiendo Solidity
Vas a encontrar varios ejemplos de contratos inteligentes desarrollados en Solidity para la Blockchain de Ethereum. Cada linea de código esta explicada en español y a modo educativo.

## Solidity

Documentación: [Solidity en Español](https://solidity-es.readthedocs.io/es/latest/)


## Mis Smart Contracts

**Bank.sol**

En este contrato vas a encontrar la funcionalidad basica de una cuenta bancaria. El que hace el Deploy, se convierte en el dueño del contrato.
Las funciones desarrolladas permiten:
1) Ver el balance del contrato.
2) Agregar dinero al contrato.
3) Extraer dinero del contrato
4) Modificar el dueño del contrato.

Conceptos aprendidos:
- *modifier*: Como crear un modificador y como utilizarlo. Su objetivo es crear restricciones de seguridad en las funciones.
- *payable*: Permite que el contrato reciba DINERO (ether). Solo se usa en funciones que necesiten escribir sobre la blockchain.
- *view*: Solo se usa en funciones que solo necesiten leer sobre la blockchain.

