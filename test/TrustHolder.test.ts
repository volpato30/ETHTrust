import {expect, use} from 'chai';
import {Contract} from 'ethers';
import {deployContract, MockProvider, solidity} from 'ethereum-waffle';
import TrustHolder from '../build/TrustHolder.json';

use(solidity);

describe('TrustHolder', () => {
  const [wallet, walletTo] = new MockProvider().getWallets();
  let token: Contract;

  beforeEach(async () => {
    token = await deployContract(wallet, TrustHolder, []);
  });

  // TODO: Add tests here
});
