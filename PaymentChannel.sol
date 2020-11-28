pragma solidity >=0.4.21 <0.6.0;

//Canal de pago
contract PaymentChannel{
    address owner; //Dueño del contrato.
    mapping(uint256 => bool) usedNonces; //Registro de pagos realizados y pendientes.
    
    //Constructor - Inicializo Contrato.
    constructor() public payable {
        owner = msg.sender;
    }
    
    //Añadir dinero al contrato.
    function moreMoney() public payable {
        require(msg.sender == owner); //Solo el dueño del contrato puede enviar dinero a este Contrato.
    }
    
    //Reclamar un pago pendiente. - Parametros: Cantidad , NONCE, Firma.
    function claimPayment(uint256 _amount, uint256 _nonce, bytes memory _sig) public { 
        //Comprobar que este pago no haya sido utilizado antes.
        require(!usedNonces[_nonce], "El pago fue usado.");
        usedNonces[_nonce] = true;
        
        //Recrear el hash del pago.
        bytes32 hash = keccak256(abi.encodePacked(msg.sender, _amount, _nonce, address(this))); //Debemos respetar el orden de los parametros
        hash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash)); //Se hace hash con ese mensaje para diferenciar un mensaje de una transacción.
        
        //Comprobar la firma del pago.
        require(recoverSigner(hash, _sig) == owner);
        
        //Enviar pago.
        msg.sender.transfer(_amount);
    }
    
    //Dividimos la Firma en 3 partes. Dos variables de 32 bytes cada uno y una Tercera con el resto.
    function splitSignature(bytes memory _sig) internal pure returns(uint8,bytes32,bytes32){
        require(_sig.length == 65);
        
        uint8 v;
        bytes32 r;
        bytes32 s;
        
        assembly{
            r := mload(add(_sig,32))
            s := mload(add(_sig,64))
            v := byte(0,mload(add(_sig,96)))
        }
        
        return (v, r, s);
    }
    
    //Con el HASH o Mensaje + la Firma => Address Public.
    function recoverSigner(bytes32 _message, bytes memory _sig) internal pure returns(address){
        uint8 v;
        bytes32 r;
        bytes32 s;
        
        (v, r, s) = splitSignature(_sig);
        
        return ecrecover(_message, v, r, s); //Devuelve una Address Pública de quien firmo este mensaje.
    }
    
    //Obtener el balance del contrato
     function getBalance() view public returns(uint256) {
        return address(this).balance;
    }
    
}
