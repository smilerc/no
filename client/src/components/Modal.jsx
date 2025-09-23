import React, { useState } from 'react';
import PropTypes from 'prop-types';
import './styles/Modal.css';

const Modal = ({ 
  data = [], 
  onSelect, 
  onUpdate, 
  loading = false,
  className = ''
}) => {
  const [selectedItem, setSelectedItem] = useState(null);
  const [isEditing, setIsEditing] = useState(false);

  const handleSelect = (item) => {
    setSelectedItem(item);
    if (onSelect) {
      onSelect(item);
    }
  };

  const handleUpdate = (updatedItem) => {
    if (onUpdate) {
      onUpdate(updatedItem);
    }
    setIsEditing(false);
    setSelectedItem(updatedItem);
  };

  if (loading) {
    return (
      <div className={`modal loading ${className}`}>
        <div className="spinner">Loading...</div>
      </div>
    );
  }

  return (
    <div className={`modal ${className}`}>
      <div className="component-header">
        <h2>Modal</h2>
        {selectedItem && (
          <div className="selected-info">
            Selected: {selectedItem.name || selectedItem.id}
          </div>
        )}
      </div>

      <div className="component-content">
        {data.length > 0 ? (
          <div className="items-list">
            {data.map((item, index) => (
              <div
                key={item.id || index}
                className={`list-item ${selectedItem?.id === item.id ? 'selected' : ''}`}
                onClick={() => handleSelect(item)}
              >
                <div className="item-content">
                  <div className="item-title">
                    {item.name || item.title || `Item ${index + 1}`}
                  </div>
                  <div className="item-meta">
                    {item.status && <span className="status">{item.status}</span>}
                    {item.amount && <span className="amount">${item.amount}</span>}
                  </div>
                </div>
                <div className="item-actions">
                  <button
                    className="btn-edit"
                    onClick={(e) => {
                      e.stopPropagation();
                      setIsEditing(true);
                    }}
                  >
                    Edit
                  </button>
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="empty-state">
            <p>No items to display</p>
          </div>
        )}
      </div>

      {isEditing && selectedItem && (
        <div className="edit-modal">
          <div className="modal-content">
            <h3>Edit {selectedItem.name || 'Item'}</h3>
            <form onSubmit={(e) => {
              e.preventDefault();
              handleUpdate(selectedItem);
            }}>
              <div className="form-group">
                <label>Name:</label>
                <input
                  type="text"
                  value={selectedItem.name || ''}
                  onChange={(e) => setSelectedItem({
                    ...selectedItem,
                    name: e.target.value
                  })}
                />
              </div>
              <div className="form-actions">
                <button type="submit" className="btn-save">Save</button>
                <button 
                  type="button" 
                  className="btn-cancel"
                  onClick={() => setIsEditing(false)}
                >
                  Cancel
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};

Modal.propTypes = {
  data: PropTypes.array,
  onSelect: PropTypes.func,
  onUpdate: PropTypes.func,
  loading: PropTypes.bool,
  className: PropTypes.string
};

export default Modal;
