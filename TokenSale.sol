pragma solidity ^0.5.0;
//Smart Contract ERC-20 - Vender mi Token

//Con la INTERFACE estamos declarando otro Smart Contract, el cual vamos a invocar y utilizar dentro de este.
interface MyToken{
    //Se debe declarar el nombre de la funcion, paramentros de entrada y valores retornados del contrato MyToken.
    function decimals() external view returns(uint8);
    function balanceOf(address _address) external view returns(uint256);
    function transfer(address _to, uint256 _value) external returns (bool success);
}

contract TokenSale{
    address owner; //Dueño.
    uint256 price; //Precio.
    MyToken myTokenContract; //Declaramos una varible de tipo Contrato: MyToken.
    uint256 tokensSold; //Cantidad de tokens vendidos.
    
    //Evento de VENTA del Token.
    event Sold(address buyer, uint256 amount);
    
    //Constructor - Inicializo Contrato.
    constructor(uint256 _price, address _addressContract) public {
        owner = msg.sender;
        price = _price;
        myTokenContract = MyToken(_addressContract); //Invocamos e inicializamos otro Smart Contract pasando la Address del Contrato.
    }
    
    //Para Multiplicar y evitar errores de OverFlow y UnderFlow.
    function mul(uint256 a, uint256 b) internal pure returns(uint256){
        if (a == 0){
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b);
        return c;
    }
    
    //Vender Token.
    function sell(uint256 _numTokens) public payable{
        //Validamos que el Cliente nos esta Pagando por todos los Tokens que quiere Comprar.
        require(msg.value == mul(price,_numTokens));
        //Convertimos la Cantidad de Token a Comprar en los Decimales correctos que entiende el Contrato ERC-20.
        uint256 scaledAmount = mul(_numTokens, uint256(10) ** myTokenContract.decimals()); //con esto: miTokenContract.decimals() --> invoco a la funcion decimals() del contrato importado.
        //Validamos que el Contrato Actual que esta vendiendo tenga disponible los Token que se quieren comprar.
        require(myTokenContract.balanceOf(address(this)) >= scaledAmount); //con address(this) --> hago referencia a la Address dueño de este contrato actual.
        tokensSold += _numTokens; //Contabilizo tokens vendidos.
        //Validamos que se puedan transferir los Tokens sin problemas.
        require(myTokenContract.transfer(msg.sender,scaledAmount));
        emit Sold(msg.sender, _numTokens); //Contretamos Venta y transferencia de los mismos.
    }
    
    //Finalizar Venta.
    function endSold() public{
        require(msg.sender == owner); //Solo el dueño del contrato puede finalizar la venta del token.
        //Transferimos todos los tokens no vendidos del Contrato TokenSale al Contrato principal MyToken.
        require(myTokenContract.transfer(owner, myTokenContract.balanceOf(address(this)))); 
        msg.sender.transfer(address(this).balance); //Transferir saldo en Ether al dueño.
    }
    
}
