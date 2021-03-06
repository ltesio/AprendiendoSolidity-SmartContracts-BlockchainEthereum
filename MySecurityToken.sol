pragma solidity ^0.5.0;
//Smart Contract ERC-20
//Security Token: Son como acciones de las empresas y reparten dividendos.

contract MySecurityToken{
    
  string public name; //Nombre del Token.
  string public symbol; //Simbolo del Token.
  uint8 public decimals; //Cantidad de decimales de nuestro Token.
  uint256 public totalSupply; //Cantidad máxima de Token.
  mapping(address => uint256) public balanceOf; //lleva la asociacion del Balance para cada Address.
  mapping(address => mapping(address => uint256)) public allowance; //lleva la asociacion de Personas Autorizadas y que Token estan Autorizados a Manejar de los cuales NO SON Propietarios.
  
  //Security Token: Dividendos---------------------------------------------------------------------------
  uint256 dividendPerToken; //Dividendo por Token Acumulado del Smart Contract (Total)
  mapping(address => uint256) dividendBalanceOf; //Dividendo Acumulados por Address - La misma se vuelve 0 cuando se liquidan los dividendos.
  mapping(address => uint256) dividendCreditedTo; //Contabilizo los dividendos que ya me fueron repartidos y estan en -dividendBalanceOf- como pendientes de liquidacion.
  
  //Actualizar Dividendos
  function update(address _address) internal { //
      uint256 debit = dividendPerToken - dividendCreditedTo[_address]; //dividendo por token que le corresponde a esta address.
      dividendBalanceOf[_address] += balanceOf[_address] * debit; //multiplico al balance actual de mi address, los dividendos que me corresponden cobrar.
      dividendCreditedTo[_address] = dividendPerToken; //actualizo que ya tengo en pendientes de liquidar los nuevos dividendos repartidos.
  }
  
  //Pago de dividendos. Liquidacion de los dividendos.
  function withdraw() public{
      update(msg.sender); //actualizamos los dividendos que nos corresponden.
      uint256 amountDividend = dividendBalanceOf[msg.sender]; //cantidad de dividendos que estan pendiente de liquidar y el mismo es el total a retirar a mi address.
      dividendBalanceOf[msg.sender] = 0; //actualizo en cerro los dividendos de mi address.
      msg.sender.transfer(amountDividend); //hago la trasferencia de los dividendos a mi address.
  }
  
  //Depositamos Tokens a repartir como dividendos.
  function deposit() public payable {
      dividendPerToken += msg.value * totalSupply; //Actualizamos el dividendo por token.
  }
  //-------------------------------------------------------------------------------------------------------
  
  //Constructor
  constructor() public {
      name = "MyToken";
      symbol = "MT";
      decimals = 18;
      totalSupply = 1000000 * (uint256(10) ** decimals);
      balanceOf[msg.sender] = totalSupply; //anoto todos los Token para la Address que deploya el contrato.
  }
  
  //Definimos un Evento.
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
  
  //Transferir valor de una direccion a otra.
  function transfer(address _to, uint256 _value) public returns (bool success){
      require(balanceOf[msg.sender] >= _value); //valida que el saldo de la Address sea mayor o igual que el _value a tranferir.
      balanceOf[msg.sender] -= _value; //anoto el _value que resto de la Address actual (from).
      balanceOf[_to] += _value; //anoto el _value que sumo a la Address que estoy transfiriendo (to).
      emit Transfer(msg.sender, _to, _value); //Transferir.
      return true;
  }
  
  //Dueño de Tokens Autoriza a otra Persona a manitular cierta cantdad de sus Tokens.
  function approve(address _spender, uint256 _value) public returns (bool success){
      allowance[msg.sender][_spender] = _value; //anoto la Persona que estoy Autorizando (_spender) y que cantidad de Tokens Autorizados.
      emit Approval(msg.sender, _spender, _value); //Autorizar.
      return true;
  }
  
  //Trasferir Tokens Autorizados por el dueño.
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
      require(balanceOf[_from] >= _value); //Comprobar que el dueño tiene esos Tokens que quiere transferir.
      require(allowance[_from][msg.sender] >= _value); //Comprobar si la Persona que invoca esta Transaccion, esta Autorzado a manejar esta cantidad de Token de esta Persona (dueño de los tokens).
      balanceOf[_from] -= _value; //anoto el _value que resto de la Address actual (from).
      balanceOf[_to] += _value; //anoto el _value que sumo a la Address que estoy transfiriendo (to).
      allowance[_from][msg.sender] -= _value; //anoto la resta en la cantidad de Tokens Autorizados.
      emit Transfer(_from, _to, _value); //Transferir.
      return true;
  }
    
}
