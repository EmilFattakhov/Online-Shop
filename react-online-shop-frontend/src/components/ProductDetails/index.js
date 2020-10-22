import React from 'react';
import './index.css'

function ProductDetails({ id, title, description, price, created_at, seller, deleteProduct }) {
  let sellerName = seller ? seller.full_name : '';

  function handleDelete() {
    deleteProduct(id);
  }

  return(
    <>
    <div className='products-details-container'>
      <div className='products-details'>
        <div>
        <h2>Product: { title }</h2>
        <p>Price: { price }$</p>
        <p>Description: { description }</p>
        <p>Sold by: { sellerName }</p>
        <br></br>
        </div>
      </div>
    </div>
    
    </>
  )
}

export default ProductDetails
