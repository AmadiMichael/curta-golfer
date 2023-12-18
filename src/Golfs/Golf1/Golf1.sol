// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

/// Challenge website: https://www.curta.wtf/golf/1

import {ICourse} from "../interfaces/ICourse.sol";
import {FixedPointMathLib, LibPRNG} from "solady/Milady.sol";

uint8 constant INPUT_SIZE = 10;

interface Log10Like {
    function perform(uint256[INPUT_SIZE] calldata) external pure returns (uint256[INPUT_SIZE] calldata);
}

contract Log10 is ICourse {
    using LibPRNG for *;

    // -------------------------------------------------------------------------
    // Functions
    // -------------------------------------------------------------------------

    /// @inheritdoc ICourse
    function name() external pure returns (string memory) {
        return "Log10";
    }

    /// @inheritdoc ICourse
    function run(address _target, uint256 _seed) external view returns (uint32) {
        // Generate inputs
        LibPRNG.PRNG memory prng;
        prng.seed(_seed);

        uint256[INPUT_SIZE] memory inputs;
        for (uint8 i; i < INPUT_SIZE;) {
            inputs[i] = prng.next();

            unchecked {
                i++;
            }
        }

        uint256 preGas = gasleft();
        uint256[INPUT_SIZE] memory outputs = Log10Like(_target).perform(inputs);
        uint256 usedGas;
        unchecked {
            usedGas = preGas - gasleft();
        }

        bytes32 a;
        assembly {
            a := outputs
        }

        _verify(inputs, outputs);

        return uint32(usedGas);
    }

    function _verify(uint256[INPUT_SIZE] memory _inputs, uint256[INPUT_SIZE] memory _outputs) internal pure {
        for (uint8 i; i < INPUT_SIZE; i++) {
            uint256 input = _inputs[i];
            uint256 output = _outputs[i];

            uint256 expected = FixedPointMathLib.log10(input);
            if (output != expected) revert IncorrectSolution();
        }
    }
}
