// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

import {console2} from "forge-std/Test.sol";
import {BaseTest} from "./Base.t.sol";
import {Factorial} from "src/Golfs/Golf2/Golf2.sol";

contract Golf2Test is BaseTest {
    address myPerformer;

    function setUp() external {
        myPerformer = deploy("Solutions/Golf2/Factorial");

        // console2.logBytes(type(FactorialSolution).creationCode);
    }

    function test_passGolf() external {
        console2.logBytes(myPerformer.code);

        // vm.etch(
        //     myPerformer,
        //     hex"6004356001811161001257600159525934f35b603a81106100205760006000fd5b6027025600000000000000000000000000000000000000000000000000000000000000000000000000000000005b600259525934f3000000000000000000000000000000000000000000000000000000000000005b600659525934f3000000000000000000000000000000000000000000000000000000000000005b601859525934f3000000000000000000000000000000000000000000000000000000000000005b607859525934f3000000000000000000000000000000000000000000000000000000000000005b6102d059525934f30000000000000000000000000000000000000000000000000000000000005b6113b059525934f30000000000000000000000000000000000000000000000000000000000005b619d8059525934f30000000000000000000000000000000000000000000000000000000000005b6205898059525934f300000000000000000000000000000000000000000000000000000000005b62375f0059525934f300000000000000000000000000000000000000000000000000000000005b630261150059525934f3000000000000000000000000000000000000000000000000000000005b631c8cfc0059525934f3000000000000000000000000000000000000000000000000000000005b64017328cc0059525934f30000000000000000000000000000000000000000000000000000005b64144c3b280059525934f30000000000000000000000000000000000000000000000000000005b6501307777580059525934f300000000000000000000000000000000000000000000000000005b6513077775800059525934f300000000000000000000000000000000000000000000000000005b6601437eeecd800059525934f3000000000000000000000000000000000000000000000000005b6616beecca73000059525934f3000000000000000000000000000000000000000000000000005b6701b02b930689000059525934f30000000000000000000000000000000000000000000000005b6721c3677c82b4000059525934f30000000000000000000000000000000000000000000000005b6802c5077d36b8c4000059525934f300000000000000000000000000000000000000000000005b683ceea4c2b3e0d8000059525934f300000000000000000000000000000000000000000000005b69057970cd7e293368000059525934f3000000000000000000000000000000000000000000005b6983629343d3dcd1c0000059525934f3000000000000000000000000000000000000000000005b6a0cd4a0619fb0907bc0000059525934f30000000000000000000000000000000000000000005b6b014d9849ea37eeac9180000059525934f300000000000000000000000000000000000000005b6b232f0fcbb3e62c335880000059525934f300000000000000000000000000000000000000005b6c03d925ba47ad2cd59dae00000059525934f3000000000000000000000000000000000000005b6c6f99461a1e9e1432dcb600000059525934f3000000000000000000000000000000000000005b6d0d13f6370f96865df5dd5400000059525934f30000000000000000000000000000000000005b6e01956ad0aae33a4560c5cd2c00000059525934f300000000000000000000000000000000005b6e32ad5a155c6748ac18b9a58000000059525934f300000000000000000000000000000000005b6f0688589cc0e9505e2f2fee558000000059525934f3000000000000000000000000000000005b6fde1bc4d19efcac82445da75b0000000059525934f3000000000000000000000000000000005b701e5dcbe8a8bc8b95cf58cde1710000000059525934f30000000000000000000000000000005b71044530acb7ba83a111287cf3b3e40000000059525934f300000000000000000000000000005b719e0008f68df506477ada0f38fff40000000059525934f300000000000000000000000000005b721774015499125eee9c3c5e4275fe380000000059525934f3000000000000000000000000005b730392ac33e351cc7659cd325c1ff9ba880000000059525934f30000000000000000000000005b738eeae81b84c7f27e080fde64ff0525400000000059525934f30000000000000000000000005b7416e39f2c684405d62f4a8a9e2cd7d2f7400000000059525934f300000000000000000000005b7503c1581d491b28f523c23abdf35b689c90800000000059525934f3000000000000000000005b75a179cceb478fe12d019fdde7e05a924c45800000000059525934f3000000000000000000005b761bc0ef38704cbab3bc477a23da8f91251bf2000000000059525934f30000000000000000005b7704e0ea0cebbd7cd1981890784d6b3c8385e98a000000000059525934f300000000000000005b77e06a0e525c0c6da95469f59de944dfa20ff6cc000000000059525934f300000000000000005b78293378a11ee64822167f7417fdd3a50ec0ee4f74000000000059525934f3000000000000005b7907b9a69e35cb2d866437e5c47f97aef2c42caee5c0000000000059525934f30000000000005b7a017a88e4484be3b6b92eb2fa9c6c087c778c8d79f9c0000000000059525934f300000000005b7a49eebc961ed279b02b1ef4f28d19a84f5973a1d2c780000000000059525934f300000000005b7b0eba8f91e823ee3e18972acc521c1c87ced2093cfdbe80000000000059525934f3000000005b7c02fde529a3274c649cfeb4b180adb5cb9602a9e0638ab200000000000059525934f30000005b7c9e90719ec722d0d480bb68bfa3f6a3260e8d2b749bb6da00000000000059525934f30000005b7d217277f77e01580cd32788186c96066a0711c72a98d891fc00000000000059525934f300005b7e072f97c62c1249eac15d7e3d3f543b60c784d1ca26d6875d2400000000000059525934f3005b7f0192693359a4002b5a4c739d65da6cfd2ba50de4387eed9c5fe000000000000059525934f35b7f59996c6ef58409a71b05be0bada2445eb7c017d09442e7d158e000000000000059525934f3"
        // );

        Factorial factorial = new Factorial(); // for testing on a fork
        // Factorial factorial = Factorial(0xb6D865a33675ec0d9BE122528DA25C6a3b1C4828); // for testing on a fork
        uint32 gasUsed = factorial.run(myPerformer, 0);

        console2.log("Gas used", gasUsed);
    }
}