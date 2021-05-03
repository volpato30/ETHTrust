# ETHTrust

## How to contribute

### Test Environment

ETHTrust uses [Waffle](https://getwaffle.io/) to compile and test smart contracts. Waffle is a library for writing and testing smart contracts.

1. Install waffle
   ```
   yarn add --dev ethereum-waffle
   ```

2. Compile the contract
   ```
   yarn build
   ```

3. Tests in waffle are written using Mocha alongside with Chai. You can use a different test environment, but Waffle matchers only work with chai. Run:
   ```
   yarn add --dev mocha chai
   ```

4. Run your Tests:
   ```
   yarn test
   ```
