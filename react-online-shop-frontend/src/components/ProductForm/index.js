import React from 'react';
import FormErrors from '../FormErrors';

export default function ProductForm({ createProduct, updateProductParams, title, description, price, errors }) {

  function handleChange(e) {
    const input = e.target;
    updateProductParams({
      [input.name]: input.value,
    })
  }

  function handleSubmit(event) {
    event.preventDefault();
    createProduct();
  }

  return(
    <form onSubmit={ handleSubmit }>
      <div>
        <label htmlFor='title'>Title</label>
        <input type='text' name='title' value={title} onChange={handleChange} />
        <FormErrors forField="title" errors={errors} />
      </div>
      <div>
        <label htmlFor='description'>Description</label>
        <textarea type='text' name='description' value={description} onChange={handleChange} />
        <FormErrors forField="description" errors={errors} />
      </div>
      <div>
        <label htmlFor='price'>Price</label>
        <input type='number' name='price' value={price} onChange={handleChange} />
        <FormErrors forField="price" errors={errors} />
      </div>
      <div>
        <input type='submit' value='Create Product'/>
      </div>
    </form>
  )
}
