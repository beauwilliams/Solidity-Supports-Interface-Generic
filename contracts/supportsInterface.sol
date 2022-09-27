// SPDX-License-Identifier: MIT
// Author: beauwilliams
pragma solidity 0.8.7;

// A generic, pure implementation to check if a contract/token supports an interface.
// Such as being able to verify 'this token is an ERC721'
// Extendable to any custom interface addressed the ID of an interface, calculated using below example.


// Most IERC721/1151 interface, which inherit from IERC165 uses view instead of pure.
// You will need to override them to create a pure implementation if you wish like this example.
interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external pure returns (bool);
}

//Example interface, we will generate an interface ID for. This can be your own contract interface.
interface ExampleInterface {
    function hello() external;
    function world() external;
}

//There may be a generic implementation of this function for all interfaces. Ideas? ;)
//This function will return an interface ID. I.e 0x80ac58cd == IERC721
abstract contract InterfaceIdGenerator {
  function calcInterfaceId() external pure returns (bytes4) {
    return ExampleInterface.hello.selector ^ ExampleInterface.world.selector;
  }
}

abstract contract SupportsERC {
    // We can hardcode these variables into our contracts to save gas.
    // However, this force us to use view functions.
    // Instead of pure ones which uphold a side effect free invariant.
    // bytes4 private constant INTERFACE_ID_ERC721 = 0x80ac58cd;
    // bytes4 private constant INTERFACE_ID_ERC1155 = 0xd9b67a26;

    //@return: true if a contract supports an interface
    function supportsERC(address addr, bytes4 interfaceId) external pure returns (bool) {
        return IERC165(addr).supportsInterface(interfaceId);
    }
}

//Our base implementation contract for purpose of this example
contract MyContract is SupportsERC, InterfaceIdGenerator {

  //Here is the easy generic way to get an interface type using the solidity builtin.
  function getExampleInterfaceType() external pure returns (bytes4) {
    return type(ExampleInterface).interfaceId;
  }
}
