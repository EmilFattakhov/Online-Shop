import React from 'react';

function FormErrors({errors = [], forField}) {
  return (
    <ul style={{ color: 'red' }}>
      {
        errors
          .filter(error => error.field === forField)
          .map((error, index) => (
            <li key={index}>
              {error.message}
            </li>    
          ))
      }
    </ul>
  )
}

export default FormErrors;
