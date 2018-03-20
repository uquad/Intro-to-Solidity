pragma solidity ^0.4.19;


contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    //mapping to map zombie Id to the address it belongs
    mapping (uint => address) public zombieToOwner;
    //mapping to keep track of how many zombies an address has
    mapping (address => uint) ownerZombieCount;



    Zombie[] public zombies;

    function createRandomZombie(string _name) public {
        //proceed only if an address does not have a zombie
        require(ownerZombieCount[msg.sender]==0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id]=msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(id, _name, _dna);
    }





}
