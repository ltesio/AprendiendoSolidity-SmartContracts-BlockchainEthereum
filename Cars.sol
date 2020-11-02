pragma solidity ^0.5.0;

contract Cars{

    address owner; //Declarar una address
    uint256 price; //Declarar un entero
    uint256[] identifier; //Declarar un array
    mapping(address => Car) cars; //Declarar un diccionario
    //Declarar una estructura
    struct Car{
        uint256 id;
        string marca;
        uint32 caballos;
        uint32 kilometros;
    }
    //Modificador
    modifier priceFilter(uint256 _price){
        require(_price == price); //El precio a pagar debe coincidir con el precio ingresado en el constructor.
        _;
    }
    //constructor: Solo se ejecuta una sola vez cuando hago el Deploy del contrato - Inicializa el contrato.
    constructor(uint256 _price) public{
        owner = msg.sender;
        price = _price;
    }
    //Registrar en un diccionario los Autos vendidos
    function addCars(uint256 _id, string memory _marca, uint32 _caballos, uint32 _kilometros) public priceFilter(msg.value) payable {
        //Escribir un array
        identifier.push(_id); 
        //Escribir un diccionario
        cars[msg.sender].id = _id;
        cars[msg.sender].marca = _marca;
        cars[msg.sender].caballos = _caballos;
        cars[msg.sender].kilometros = _kilometros;
    }
    //Ver la cantidad de Autos registrados o vendidos
    function getIdentifiers() external view returns(uint256){
        return identifier.length; //Cantidad de registros en un array
    }
    //Ver el detalle del Auto asociado a mi address
    function getCars() external view returns(string memory _marca, uint32 _caballos, uint32 _kilometros){
        //Devolver multiples valores en una funcion
        _marca = cars[msg.sender].marca;
        _caballos = cars[msg.sender].caballos;
        _kilometros = cars[msg.sender].kilometros;
        return (_marca, _caballos, _kilometros);
    }
    
}
