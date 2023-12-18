// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {console2} from "forge-std/Test.sol";
import {BaseTest} from "./Base.t.sol";
import {Log10} from "src/Golfs/Golf1/Golf1.sol";

contract Golf1Test is BaseTest {
    address myPerformer;

    function setUp() external {
        myPerformer = deploy("Solutions/Golf1/Log10");
    }

    function test_passGolf() external {
        Log10 log10 = new Log10();
        // Log10 log10 = Log10(0x4aaF440F20500920ada629C1bC43Afb8ccD7DF52); // for testing on a fork
        uint32 gasUsed = log10.run(myPerformer, uint256(keccak256(abi.encode(uint256(1)))));

        console2.log("Gas used", gasUsed);
    }
}
