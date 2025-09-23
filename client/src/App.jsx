import React from 'react';
import './styles/App.css';

function App() {
  return (
    <div className="app">
      <div className="component-header">
        <h2>FluxPay Platform</h2>
        <p>Cryptocurrency Payment Processing</p>
      </div>

      <div className="component-content">
        <div className="welcome-section">
          <h3>Welcome to FluxPay</h3>
          <p>Your secure cryptocurrency payment gateway is ready.</p>
        </div>
        
        <div className="features-grid">
          <div className="feature-card">
            <h4>Multi-Currency Support</h4>
            <p>Bitcoin, Ethereum, USDT and more</p>
          </div>
          
          <div className="feature-card">
            <h4>Real-time Processing</h4>
            <p>Instant payment confirmations</p>
          </div>
          
          <div className="feature-card">
            <h4>Secure Transactions</h4>
            <p>Enterprise-grade security</p>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
