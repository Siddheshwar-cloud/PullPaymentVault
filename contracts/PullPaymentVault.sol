// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PullPaymentVault {
    mapping(address => uint256) public balances;

    event PaymentRecorded(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Record a payment for a user
    function recoedPayment(address _user) external payable {
        require(_user != address(0), "Invalid User");
        require(msg.value > 0, "No Eth sent");

        balances[_user] += msg.value;
        emit PaymentRecorded(_user, msg.value);
    }

    // user pulls their Own funds
    function Withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Nothing to Withdraw");

        // Effects
        balances[msg.sender] = 0;

        // Interaction
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Eth transfer failed");

        emit Withdrawn(msg.sender, amount);
    }
}
