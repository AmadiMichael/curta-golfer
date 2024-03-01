// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {ICourse} from "../interfaces/ICourse.sol";

interface FactorialLike {
    function perform(uint256 input) external pure returns (uint256 output);
}

contract Factorial is ICourse {
    /// @inheritdoc ICourse
    function name() external pure returns (string memory) {
        return "Factorial";
    }

    /// @inheritdoc ICourse
    function run(address target, uint256 seed) external view returns (uint32 usedGas) {
        /// @solidity memory-safe-assembly
        assembly {
            function verifyReturns(target_, input_, output_) {
                mstore(0x00, 0xd097bc0d) // `perform(uint256)`.
                mstore(0x20, input_)
                let success_ := staticcall(gas(), target_, 0x1c, 0x24, 0x00, 0x20)
                success_ := and(gt(returndatasize(), 0x1f), success_)
                success_ := and(eq(mload(0x00), output_), success_)
                if iszero(success_) {
                    mstore(0x00, 0x62cebecf) // `IncorrectSolution()`.
                    revert(0x1c, 0x04)
                }
            }

            function verifyReverts(target_, input_) {
                mstore(0x00, 0xd097bc0d) // `perform(uint256)`.
                mstore(0x20, input_)
                if staticcall(gas(), target_, 0x1c, 0x24, 0x00, 0x00) {
                    mstore(0x00, 0x62cebecf) // `IncorrectSolution()`.
                    revert(0x1c, 0x04)
                }
            }

            // From https://github.com/Vectorized/solady/blob/main/src/utils/LibPRNG.sol.
            function shuffle(a_, seed_) -> _nextSeed {
                let n_ := mload(a_)
                let w_ := not(0)
                mstore(0x00, seed_)
                let r_ := keccak256(0x00, 0x20)
                if n_ {
                    for { a_ := add(a_, 0x20) } 1 {} {
                        r_ :=
                            mulmod(
                                r_,
                                0x100000000000000000000000000000051,
                                0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff43
                            )
                        {
                            let j_ := add(a_, shl(5, mod(and(shr(64, r_), 0xffffffff), n_)))
                            n_ := add(n_, w_)
                            if iszero(n_) { break }

                            let i_ := add(a_, shl(5, n_))
                            let t := mload(i_)
                            mstore(i_, mload(j_))
                            mstore(j_, t)
                        }

                        {
                            let j_ := add(a_, shl(5, mod(and(shr(32, r_), 0xffffffff), n_)))
                            n_ := add(n_, w_)
                            if iszero(n_) { break }

                            let i_ := add(a_, shl(5, n_))
                            let t := mload(i_)
                            mstore(i_, mload(j_))
                            mstore(j_, t)
                        }
                    }
                }
                mstore(0x20, seed_)
                _nextSeed := keccak256(0x00, 0x40)
            }

            function mallocUint256Array(length_) -> _result {
                _result := mload(0x40)
                mstore(_result, length_)
                mstore(0x40, add(add(_result, 0x20), shl(5, length_)))
            }

            function mallocRange(from_, to_) -> _result {
                let length_ := sub(to_, from_)
                _result := mallocUint256Array(length_)
                let o_ := add(_result, 0x20)
                for { let i_ := 0 } iszero(eq(i_, length_)) { i_ := add(i_, 1) } { mstore(add(o_, shl(5, i_)), i_) }
            }

            function testRange(target_, solutions_, from_, to_, seed_) -> _nextSeed {
                let length_ := sub(to_, from_)
                let indices_ := mallocRange(from_, to_)
                _nextSeed := shuffle(indices_, seed_)
                let indicesOffset_ := add(indices_, 0x20)
                let solutionsOffset_ := add(solutions_, 0x20)
                for { let i_ := 0 } iszero(eq(i_, length_)) { i_ := add(i_, 1) } {
                    let input_ := mload(add(indicesOffset_, shl(5, i_)))
                    let output_ := mload(add(solutionsOffset_, shl(5, input_)))
                    verifyReturns(target_, input_, output_)
                }
            }

            let preGas := gas()
            let m := mload(0x40)

            let solutions := mallocUint256Array(58)
            let solution := 1
            let solutionsOffset := add(solutions, 0x20)
            for { let j := 0 } 1 {} {
                mstore(add(solutionsOffset, shl(5, j)), solution)
                j := add(j, 1)
                solution := mul(solution, j)
                if eq(j, 58) { break }
            }

            seed := testRange(target, solutions, 0, 58, seed)
            seed := testRange(target, solutions, 0, 16, seed)

            for { let j := 58 } iszero(eq(j, 70)) { j := add(j, 1) } {
                verifyReverts(target, j)
                verifyReverts(target, shl(128, j))
                verifyReverts(target, shl(248, j))
            }

            seed := testRange(target, solutions, 0, 8, seed)
            seed := testRange(target, solutions, 0, 32, seed)

            calldatacopy(m, 0x00, shl(8, extcodesize(target)))

            usedGas := sub(preGas, gas())
        }
    }
}
