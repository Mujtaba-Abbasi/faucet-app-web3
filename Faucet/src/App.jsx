import './App.css'
import React, { useEffect, useState, useCallback } from 'react';
import Web3 from 'web3'
import detectEthereumProvider from '@metamask/detect-provider'
import loadContract from './utils/loadContract.js';

function App() {
  const [web3Api, setWeb3Api] = useState({
    isProviderLoaded: false,
    provider: null,
    web3: null,
    contract: null
  })

  const [balance, setBalance] = useState(null)
  const [account, setAccount] = useState(null);
  const [reload, setReload] = useState(false)

  const reloadEffect = useCallback(() => setReload(!reload), [reload]);

  const setAccountListener = (provider) => {
    provider.on('accountsChanged', (accounts) => setAccount(accounts[0]));
  }
  useEffect(() => {
    const loadProvider = async () => {
      const provider = await detectEthereumProvider();

      if (provider) {
        const contract = await loadContract("Faucet", provider);
        setAccountListener(provider)
        setWeb3Api({
          web3: new Web3(provider),
          provider: provider,
          isProviderLoaded: true,
          contract: contract
        });
      } else {
        setWeb3Api({ ...web3Api, isProviderLoaded: true });
        console.error("Please, install Metamask.");
      }
    }

    loadProvider();
  }, [])


  useEffect(() => {
    const getAccount = async () => {
      const accounts = await web3Api.web3.eth.getAccounts();
      setAccount(accounts[0])
    }

    web3Api.web3 && getAccount()
  }, [web3Api.web3])

  useEffect(() => {
    const loadBalance = async () => {
      if (!web3Api.contract) return;
      const { contract, web3 } = web3Api;
      let balance = await web3.eth.getBalance(contract._address);
      balance = web3.utils.fromWei(balance, "ether");
      setBalance(balance);
    }

    web3Api.contract && loadBalance();

    loadBalance();
  }, [web3Api, reload]);

  const addFunds = useCallback(async () => {
    const { contract, web3 } = web3Api;
    await contract.methods.addFunds().send({
      value: web3.utils.toWei("1", "ether"),
      from: account,
    })
    reloadEffect();
  }, [web3Api, account, reloadEffect])


  const widthdrawFunds = async () => {
    const { contract, web3 } = web3Api;
    const value = web3.utils.toWei("0.1", "ether");
    await contract.methods.withdraw(value).send({
      from: account,
    })
    reloadEffect();

  }

  return (
    <>
      <div className="faucet-wrapper">
        <div className="faucet">

          {web3Api.isProviderLoaded ?

            <div className='is-flex is-align-item-center'>
              <strong className="mb-3 is-align-self-center" style={{ color: "white" }}>Account : </strong>
              {
                account
                  ? (
                    <h1 className='ml-3'>
                      {account}
                    </h1>
                  )
                  : !web3Api.provider ? (
                    <>
                      <div className='notification is-size-10 is-light is-rounded ml-3 is-warning'>Wallet is not Detected!
                        <a target='_blank' href='https://docs.metamask.io' className='ml-2'>Install Metamask</a>
                      </div>
                    </>
                  ) : (
                    <button
                      className="button ml-4 is-small is-responsible"
                      onClick={async () => {
                        await web3Api.provider.request({ method: "eth_requestAccounts" });
                      }
                      }>
                      Connect Wallet
                    </button>
                  )
              }
            </div>
            : <h1>Looking for the provider!</h1>
          }



          <div className="balance-view is-size-2 mb-4 ">
            Current Balance: <strong style={{ color: 'whitesmoke' }}>{balance}</strong> ETH
          </div>
          <button
            disabled={!account}
            className="is-link button mr-4 is-normal is-responsible"
            onClick={addFunds}
          >
            Donate 1 eth
          </button>

          <button
            disabled={!account}
            className="is-primary is-light button is-normal is-responsible"
            onClick={widthdrawFunds}>
            Withdraw
          </button>
          {!account && (
            <h1 className='mt-3'>Connect the Wallet first!</h1>
          )}
        </div>
      </div>
    </>
  )
}

export default App

      // * with metamask we have access to the window.ethereum & to window.web3
      // * metamask injects a global API into our website
      // * this allows websites to request users, accounts, read data to the blockchain
      // * sign messages and transactions


/*
  * window.ethereum = newer versions of Metamask
  * window.web3 = legacy version of web3

*/