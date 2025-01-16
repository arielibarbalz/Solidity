// SPDX-License-Identifier: MIT
pragma solidity >0.8.0 < 0.9.0;

/* Contrato 1 de entradas:

 1) Una estructura Person que contenga Id, Nombre y Cantidad.

 2) Un Mapeao desde el address del dueño de la entrada apuntando a la estructura Person en que la variable se llame cliente.

 3) Si el cliente adquiere más de 2 entradas adquiere una entrada de lotería que estará en otro contrato (contrato 2).

 4) Si el owner del contrato quiere puede comprar entradas asignandoselas a distintas personas (en batch) pero no participarán del sorteo.

 5) Permitir cambiar la primera letra del nombre de tu persona por mayuscula si está en minuscula.

 6) Si una función que se llame en este contrato no existe deberá llamar al contrato de loteria y buscar la misma función (ej: ver el ganador de la lotería)
 */

 contract Ticket {

    struct Person{
    uint256 id;
    uint256 cantidad;
    string nombre;
    }
    uint256 public constant price = 1*10**18;
    uint256 public id;
    address owner;
    constructor() payable{
        owwner = msg.sender;
    } 
    // 2) 

    mapping (address => Person) public  cliente;
    function getLoteryTicket() public {
        
    }

    // 3)
    function comprarEntradas(string calldata _name) external payable{
          require(price <= msg.value, "no alcanza");
          uint256 _cantidad = msg.value / price; // 19/10 = 1 | 1 
          uint256 _devolucion = msg.value & price; // devuelve el resto
        require(_devolucion<msg.value, "No te vamos a devolver mas");
        cliente[msg.sender].id = id;
        cliente[msg.sender].cantidad = _cantidad;
        cliente[msg.sender].nombre = _name;
        id++;
        if (__cantidad > 2){
            getLoteryTicket();
        }
        //msg.sender, devolucion
        payable (msg.sender).transfer(_devolucion);
    }
    // 4)
    function asignEntrada(address[] calldata _addr, Person[] calldata amigos) external {
        require(msg.sender == owner, "Usted no es el owner");
        for(uint256 i; i < _addr.lenght; i++)
        {
            cliente[_addr[i]].cantidad = amigos[i].cantidad;
            cliente
        }
    }
}

