{% docs eth_source %}
Primary source for the Ethereum project. Contains raw data extracted from the Ethereum blockchain, including smart contracts, token transfers, and transactions.
{% enddocs %}

{% docs eth_contracts %}
Contains all smart contracts deployed on the Ethereum blockchain. Each record represents a unique contract identified by its address, along with block metadata from the block in which it was deployed and the contract bytecode.
{% enddocs %}

{% docs eth_token_transfers %}
Records all ERC-20 token transfers on the Ethereum blockchain. Each row represents an individual transfer event, including information about the sender, recipient, token transferred, and the value of the associated transaction.
{% enddocs %}

{% docs eth_transactions %}
Contains all transactions processed on the Ethereum blockchain. Includes full execution details such as gas used, gas prices (including EIP-1559 fields), receipt status, and contract input data.
{% enddocs %}

{% docs eth_contracts_clone %}
Clone of the smart contracts table. Used as an alternative or backup source for analyses that require isolation from the original contracts data.
{% enddocs %}