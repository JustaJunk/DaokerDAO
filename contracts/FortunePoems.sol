//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract FortunePoems is ERC1155 {
    string private greeting;

    constructor(string memory uri_) ERC1155(uri_) {}

    function draw(bytes calldata ask) external payable {
        uint256 poemId = (block.timestamp ^
            uint160(_msgSender()) ^
            uint256(_convertBytesToBytes32(ask))) % 60;
        _mint(_msgSender(), poemId, 1, ask);
    }

    function _convertBytesToBytes32(bytes calldata input)
        private
        pure
        returns (bytes32 output)
    {
        for (uint8 i = 0; i < 32; i++) {
            output |= bytes32(input[i] & 0xFF) >> (i * 8);
        }
    }
}
