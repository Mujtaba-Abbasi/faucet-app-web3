/** @format */

import Web3 from "web3";

const loadContract = async (name, provider) => {
  const res = await fetch(`/contracts/${name}.json`);
  const artifact = await res.json();

  const web3 = new Web3(provider);
  const deployedContract = new web3.eth.Contract(
    artifact.abi,
    artifact.networks[Object.keys(artifact.networks)[0]].address
  );
  return deployedContract;
};

export default loadContract;
