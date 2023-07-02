/** @format */

const [web3Api, setWeb3Api] = useState({
  provider: null,
  web3: null,
});

useEffect(() => {
  let provider = null;
  const loadProvider = async () => {
    if (window.ethereum) {
      provider = window.ethereum;
      try {
        await provider.request({ method: "eth_requestAccounts" });
      } catch (error) {
        console.log(error.message);
      }
    } else if (window.web3) {
      provider = window.web3.currentProvider;
    } else if (!process.env.production) {
      provider = new Web3.providers.HttpProvider("http://127.0.0.1:7545");
    }

    setWeb3Api({
      web3: new Web3(provider),
      provider: provider,
    });
  };

  loadProvider();
}, []);

useEffect(() => {
  debugger;
  const getAccount = async () => {
    const accounts = await web3Api.web3.eth.getAccounts();
    setAccount(accounts[0]);
  };

  web3Api.web3 && getAccount();
}, [web3Api.web3]);
