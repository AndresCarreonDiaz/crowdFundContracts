// SPDX-License-Identifier: GPL-3.0
 pragma solidity >=0.7.0 <0.9.0;
 
 contract CrowdFund{
     //Aqui creamos nuestras variables
     bool isFundable;
     uint Goal; 
     uint256 totalFunded;
     address owner;
     uint256 requiredFunds;
     
     //Inicializamoslos valores, hay que recordar que el constructor se ejecuta solo una vez cuando se crea el contrato
     constructor(){
         Goal = 1;
         owner = msg.sender;
         totalFunded = 0;
         isFundable = true;
     }
     //No te  preocupes por esto,luego loaprenderemos. El modifier permite cambiar el comppoprtamiento de funciones, ene ste caso solo queria asegurarme que solo el creador del contrato pudiera mover el Goal
     modifier onlyOwner{
         require(msg.sender == owner, "You need to be the owner from this contract to change the goal");
         _;
     }
     //Creamos el evento el cual va a necesitar quien lo hizo y en este caso  preferia que cambie la meta de fndeo
     event changeGoal(
         address editor,
         uint256 Goal
         );
         
     //Aqui ponemos la meta a recaudar,solamente el que iniciaiza el contrato puede cambiar este valor
     function setGoal(uint goal) public onlyOwner {
         Goal = goal;
         emit changeGoal(msg.sender, goal);
     }
     
     function viewGoal() public view returns(uint256) {
         return Goal;
     }
     //Creamos el evento para notificar a los demas que el autor decidio cerrar el fondeo  temporalmente
     event changeState(
         address editor,
         bool change);
         
     function changeProjectState(bool change)public onlyOwner{
         require(isFundable != change, "Can not change the state with the actual state");
         isFundable = change;
         emit changeState(msg.sender, change);
     }
     //Aqui inicia la funcion para fondear el proyecto
     function fundproject() public payable {
         //Primero evaluamos si el owner del contrato mantiene abiertas las donaciones (tal vez necesita reevaluar algo)
         require(isFundable, "Owner has decided to stop this fundraising for a while. Stay tuned");
         //Comprobamos que el total que se ha fondeado sea menor a la meta
         require(totalFunded < Goal, "Goal already achieved so you are  not able to fund this anymore");
         //Despues nos aeguramos que la persona mande un minimo,en este caso arriba de 0
         require(msg.value != uint(0), "Please add some funds to  contribuite to Platzi project");
         //Comprobamos que el valor que quiere fondear no exceda con a meta que tenemos
         require(totalFunded + msg.value <= Goal,"unable to add more funds, check amount remaining for our goal");
         //Actualizamos el total que se ha fondeado al contrato
         totalFunded += msg.value;
     }
     //Esta funcion nos sirve para que lla persona pueda ver cuanto se necesita para alcanzar la meta, asi no tendra que estar adivinando cuanto depositar maximo
     function viewRemaining() public view returns(uint256){
         uint256 remainingFunds = Goal - totalFunded;
         return remainingFunds;
     }
     
     
 }