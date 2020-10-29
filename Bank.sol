pragma solidity ^0.5.0;

contract Bank{
    
    address owner;
    
    //payable: permite que el contrato reciba DINERO (ether)
    constructor() payable public {
        owner = msg.sender;
    }
    //modifier: permite crear modificadores de FUNCIONES propios
    modifier onlyOwner {
        require(msg.sender == owner); //si la direccion que esta invocando la funcion soy yo (el dueño) --puedo continuar, sino se cancela. 
        _; //esta linea va si o si para que continue la ejecucion de la funcion.
    }
    //modificar el dueño del contrato. 
    //onlyOwner: Solo el dueño actual puede hacerlo.
    function newOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
    //ver el dueño del contrato
    //view: solo permite lectura
    function getOwner() view public returns(address) { 
        return owner;
    }
    //ver el balance de la address del contrato
    function getBalance() view public returns(uint256) {
        return address(this).balance;
    }
    //agregar DINERO al la address del contrato
    function incrementBalance(uint256 amount) payable public {
        require(msg.value == amount);
    }
    //retirar DINERO de la address del contrato
    function withdrawBalance() public onlyOwner {
        msg.sender.transfer(address(this).balance); //extraccion del dinero
    }
    
}
