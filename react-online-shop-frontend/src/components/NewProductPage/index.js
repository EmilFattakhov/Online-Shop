import React, { useState } from 'react';
import ProductForm from '../ProductForm';
import { Product } from '../../requests';

function NewProductPage(props) {
  const [productParams, setProductParams] = useState({
    title: '',
    description: '',
    price: '',
  });
  const [errors, setErrors] = useState([]);

  function updateProductParams(params) {
    setProductParams(state => {
      return {
        ...state,
        ...params,
      }
    });
  }

  function createProduct() {
    Product.create(productParams).then(({id, errors}) => {
      if (id) {
        props.history.push(`/products/${id}`);
      } else {
        setErrors(errors);
      }
    })
  }

  const { title, description, price } = productParams;
  return(
    <main>
      <h1> Product New Page</h1>
      <ProductForm 
        createProduct={ createProduct }
        updateProductParams={ updateProductParams }
        title={title}
        description={description}
        price={price}
        errors={errors}
      />
    </main>
  )
}

export default NewProductPage
