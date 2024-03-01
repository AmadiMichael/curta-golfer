// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {console2} from "forge-std/Test.sol";
import {BaseTest} from "./Base.t.sol";
import {Factorial} from "src/Golfs/Golf2/Golf2.sol";

contract Golf2Test is BaseTest {
    address myPerformer;

    function setUp() external {
        myPerformer = deploy("Solutions/Golf2/Factorial");
    }

    function test_passGolf() external {
        Factorial factorial = new Factorial(); // for testing on a fork
        // Factorial factorial = Factorial(0xb6D865a33675ec0d9BE122528DA25C6a3b1C4828); // for testing on a fork
        uint32 gasUsed = factorial.run(myPerformer, 0);

        console2.log("Gas used", gasUsed);
    }
}
