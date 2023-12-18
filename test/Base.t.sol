// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {Test} from "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

contract BaseTest is Test {
    function deploy(string memory filename) internal returns (address huff_contract) {
        huff_contract = HuffDeployer.config().with_evm_version("paris").deploy(filename);
    }
}
