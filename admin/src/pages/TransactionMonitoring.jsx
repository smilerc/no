import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import './styles/TransactionMonitoring.css';

const TransactionMonitoring = () => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      setLoading(true);
      const response = await fetch('/api/v1/transactionmonitoring');
      if (!response.ok) {
        throw new Error('Failed to fetch data');
      }
      const result = await response.json();
      setData(result);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="transactionmonitoring-loading">
        <div className="spinner">Loading...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="transactionmonitoring-error">
        <h2>Error</h2>
        <p>{error}</p>
        <button onClick={fetchData}>Try Again</button>
      </div>
    );
  }

  return (
    <div className="transactionmonitoring-page">
      <div className="page-header">
        <h1>TransactionMonitoring</h1>
        <button 
          className="btn-primary"
          onClick={() => navigate('/transactionmonitoring/new')}
        >
          Add New
        </button>
      </div>
      
      <div className="page-content">
        {data.length > 0 ? (
          <div className="data-grid">
            {data.map((item, index) => (
              <div key={item.id || index} className="data-item">
                <h3>{item.name || item.title}</h3>
                <p>{item.description || item.status}</p>
                <div className="item-actions">
                  <button onClick={() => navigate(`/transactionmonitoring/${item.id}`)}>
                    View
                  </button>
                  <button onClick={() => navigate(`/transactionmonitoring/${item.id}/edit`)}>
                    Edit
                  </button>
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="empty-state">
            <h3>No data available</h3>
            <p>Get started by adding your first item.</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default TransactionMonitoring;
