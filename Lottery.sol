pragma solidity ^0.5.0;

contract Lottery {
    address internal owner;
    uint256 internal num;
    uint256 public numWinner; //Numero Ganador
    uint256 public price; //Precio
    bool public game; //Juego
    address public winner; //Ganador
    uint256 public initialInvestment; //Inversion Inicial
    //constructor: Inicializar contrato con el Precio de la apuesta y el Numero Ganador.
    constructor(uint256 _price, uint256 _numWinner) public payable {
        owner = msg.sender;
        num = 0;
        numWinner = _numWinner;
        price = _price;
        game = true;
        initialInvestment = msg.value;
    }
    //Verificar si el Numero elegido por el Apostador coincide con el Numero Ganador.
    function comprobarAcierto(uint256 _num) private view returns(bool) {
        if(_num == numWinner) {
            return true;
        } else {
            return false;
        }
    }
    //Generar Numero Aleatorio de 0 a 9.
    function numeroRandom() private view returns(uint256) {
        //Variables Globales:
        //now: fecha de minado del bloque. (Variable Global de BLOQUE).
        //msg.sender: Address de quien esta haciendo la transaccion. (Variable Global de TRANSACCION).
        //uint256(): Permite castear tipos de datos. En este caso convierte un numero tipo hash a tipo uint256.
        return uint256( keccak256( abi.encode(now, msg.sender, num) ) ) % 10;
    }
    //El Usuario paga por su Apuesta y se sortea Automaticamente para ver si Gana o no.
    function participar() external payable returns(bool result, uint256 number) {
        require(game == true); //El juego debe estar Activo.
        require(msg.value == price); //Verificar que se esta pagando por la Apuesta.
        uint256 numUser = numeroRandom(); //Eligo un Numero Random para el Usuario Apostador.
        bool acierto = comprobarAcierto(numUser); //Verifico si el Numero Random coincide con el Numero Ganador.
        //if: Es usado para establecer condiciones.
        if(acierto == true) {
            game = false; //Desactivo Juego
            msg.sender.transfer( initialInvestment + ( num * (price/2) ) ); //Transfiero a la Address del Usuario Ganador el Premio.
            winner = msg.sender; //Guardo el Ganador
            result = true;
            number = numUser; //Guardo el Numero Random que le toco al usuario.
        } else {
            num++;
            result = false;
            number = numUser;
        }
        return (result,number);
    }
    //Ver el Monto del Premio por el cual estoy participando.
    function verPremio() public view returns(uint256) {
        if(game == true) {
            return initialInvestment + ( num * (price/2) );
        } else {
            return 0;
        }
    }
    //Retirar dinero del contrato.
    //transfer: Permite transferir una cantidad de DINERO a una Address indicada.
    function retirarFondosContrato() external returns(uint256) {
        require(msg.sender == owner); //Verifico que sea el Owner del Contrato.
        require(game == false); //Verifico que el juego este desactivado.
        uint256 quantity = address(this).balance;
        msg.sender.transfer(quantity); //Transfiero a la Address del Owner del Contrato
        return quantity; //Muestro la cntidad retirada.
    }
}
