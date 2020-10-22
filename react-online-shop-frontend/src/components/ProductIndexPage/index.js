import React, { Component } from 'react';
import productsData from '../../data/products';
import ProductDetails  from '../ProductDetails';
import { Link } from 'react-router-dom';
import './index.css'

class ProductIndexPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      products: productsData
    }
    this.deleteProduct = this.deleteProduct.bind(this);
  }

  deleteProduct(id) {
    this.setState((state) => {
      return {
        products: state.products.filter((product) => {
          return product.id !== id;
        })
      }
    })
  }

  render() {
    return(
      <main className='page'>
        { this.state.products.map((product) => {
          return(
            <div>
                <div className='product'>
                  <Link style={{ textDecoration: 'none' }} key={product.id} to={`/products/${product.id}`}>
                  <ProductDetails {...product} deleteProduct={this.deleteProduct}/>
                  </Link>
                </div>
              </div>
          )
        })}
      </main>
    )
  }
}

export default ProductIndexPage