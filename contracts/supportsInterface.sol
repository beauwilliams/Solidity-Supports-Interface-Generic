// SPDX-License-Identifier: MIT
// Author: beauwilliams
pragma solidity 0.8.7;

// A generic, pure implementation to check if a token is a 721 or 1155.
// Extendable to many interface types through the ID hash of an interface.


// Openzeppelin IERC721/1151 interface, which is inhereted from IERC165 uses view instead of pure.
// You will need to override OZ to create a pure implementation if you wish like this example.
interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external pure returns (bool);
}


abstract contract SupportsERC {
    // We can hardcode these variables into our contracts to save gas.
    // However, this force us to use view functions.
    // Intsead of pure ones which uphold a side effect free invariant.
    // bytes4 private constant INTERFACE_ID_ERC721 = 0x80ac58cd;
    // bytes4 private constant INTERFACE_ID_ERC1155 = 0xd9b67a26;

    function supportsERC(address nftAddress, bytes4 interfaceId) external pure returns (bool) {
        return IERC165(nftAddress).supportsInterface(interfaceId);
    }
}

contract MyContract is SupportsERC {}
