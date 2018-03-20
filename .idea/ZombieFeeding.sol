pragma solidity ^0.4.19;

import "./ZombieContract.sol";

contract ZombieFeeding {



  function feedAndMultiply(uint _zombieId,uint _targetDna) public{
      //make sure user can access only his zombie
      require(msg.sender == zombieToOwner[_zombieId]);
      Zombie storage myZombie = zombies[_zombieId];

      //make new Dna from host and zombie and use that to create new zombie
      _targetDna = _targetDna % dnaModulus;
      uint newDna = (myZombie.dna + _targetDna) / 2;
      _createZombie("NoName", newDna);


  }


}
