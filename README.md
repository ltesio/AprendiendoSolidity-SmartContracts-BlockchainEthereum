# Blockchain Ethereum - Smart Contracts - Aprendiendo Solidity
Vas a encontrar varios ejemplos de contratos inteligentes desarrollados en Solidity para la Blockchain de Ethereum. Cada línea de código esta explicada en español y a modo educativo.

### Herramientas
**Solidity**

Lenguaje de programación utilizado para codear los contratos inteligentes. Documentación: [Solidity en Español](https://solidity-es.readthedocs.io/es/latest/)

**Remix**

Herramienta utilizada para codear, compilar, hacer el deploy de los contratos y el testing de los mismos. [Remix Ethereum](https://remix.ethereum.org/)



### Mis Smart Contracts
**Bank.sol**

En este contrato vas a encontrar la funcionalidad básica de una cuenta bancaria. El que hace el Deploy, se convierte en el dueño del contrato.
Las funciones desarrolladas permiten:
1) Ver el balance del contrato.
2) Agregar dinero al contrato.
3) Extraer dinero del contrato
4) Modificar el dueño del contrato.

Conceptos aprendidos:
- *modifier*: Como crear un modificador y como utilizarlo. Su objetivo es crear restricciones de seguridad en las funciones.
- *payable*: Permite que el contrato reciba DINERO (ether). Solo se usa en funciones que necesiten escribir sobre la blockchain.
- *view*: Solo se usa en funciones que solo necesiten leer sobre la blockchain.
- *require*: Validaciones. La misma debe cumplirse para que continúe la ejecución del código. Caso contrario finaliza la función.

------------------------------------
**Cars.sol**

En este contrato vas a encontrar la funcionalidad básica de una concesionaria de autos.
Las funciones desarrolladas permiten:
1) Anotar los autos que fueron vendidos y a quien.
2) Ver la cantidad total de autos vendidos por la concesionaria.
3) Ver los detalles técnicos de un auto, a partir de la address del dueño.

Conceptos aprendidos:
- *external*: Se accede desde afuera del contrato, pero consume menos gas que public.
- *public*: Se accede desde afuera del contrato.
- *internal*: Se accede desde el mismo contrato y por herencia del mismo.
- *private*: Solo se accede desde el mismo contrato.
- *returns*: Como retornar uno o múltiples valores en una función.
- *array, dictionary, struct*: Como declarar arreglos, diccionarios y estructuras de datos. Y como escribir y leer los mismos.

------------------------------------
**Lottery.sol**

En este contrato vas a encontrar la funcionalidad básica de un juego de Lotería. 
Las funciones desarrolladas permiten:
1) Participar del sorteo. El apostador paga el valor de la apuesta, se le asigna un valor semi-aleatorio y se verifica si es Ganador o no.
2) Ver el premio acumulado por el cual participa el apostador.
3) Retirar los fondos acumulados del contrato de las comisiones, solo si sos el dueño del mismo.

Conceptos aprendidos:
- *transfer*: Permite transferir una cantidad de DINERO a una Address indicada.
- *if*: Es usado para establecer condiciones.
- *now*: Fecha de minado del bloque. (Variable Global de BLOQUE).
- *msg.sender*: Address de quien está haciendo la transacción. (Variable Global de TRANSACCION).
- *uint256()*: Permite castear tipos de datos. En este caso convierte un numero tipo hash a tipo uint256.

------------------------------------
**MyToken.sol**

En este contrato vas a encontrar la funcionalidad básica para crear nuestro propio Token Estándar de Ethereum (ERC-20). 
Las funciones desarrolladas permiten:
1) Crear nuestro propio Token.
2) Transferir estos Tokens.
3) Autorizar a otras Personas (address) a transferir una cierta cantidad de Tokens.
4) Personas (address) Autorizadas pueden transferir estos Tokens.
5) Visualizar balance actual de cada Address.

Conceptos aprendidos:
- *event*: Definición de Eventos de la blockchain de Ethereum.
- *emit*: Llamada a Eventos de la blockchain de Ethereum.
- *Transfer*: Transferir tokens.
- *Approval*: Autorizar a una Address transferir mis Tokens.


