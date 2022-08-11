//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GroupAdmin{
    // 0x919b81cdeba0376a3949fc362aab3fde700a2118c084972392f9455a2ec29c89
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant SUPERUSER = keccak256(abi.encodePacked("SUPERUSER"));
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));


    mapping(bytes32 => mapping(address => bool)) internal user;

    event UserAdded(bytes32  indexed _role, address indexed _addr, string indexed _reason );
    event UserRemoved(bytes32 indexed _role, address indexed _addr, string indexed _reason);

    constructor(){
        _grantRole(SUPERUSER, msg.sender);
    }

    modifier onlyAdmin(bytes32 _role){
        require(user[_role][msg.sender], "Unauthorized user");
        _;
    }

    function _grantRole(bytes32 _role, address _user) internal{
        user[_role][_user] = true;
    }

    function addUser(bytes32 _role, address _user, string calldata _reason) external onlyAdmin(SUPERUSER) {
        user[_role][_user] = true;
        emit UserAdded(_role, _user, _reason);

    }

    function removeUser(bytes32 _role, address _user, string calldata _reason) external onlyAdmin(SUPERUSER){
        user[_role][_user] = false;
        emit UserRemoved(_role, _user, _reason);
    
    }
}
