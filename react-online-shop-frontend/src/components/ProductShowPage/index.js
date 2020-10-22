import React, { Component } from 'react'
import ProductDetails from '../ProductDetails';
import ReviewList from '../ReviewList';
import { Product } from '../../requests';
import './index.css'

class ProductShowPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      product: {}
    }
    this.deleteReview = this.deleteReview.bind(this);
  }

  componentDidMount() {
    Product.one(this.props.match.params.id).then((product) => {
      this.setState((state) => {
        return {
          product
        }
      })
    })
  }

  deleteReview(id) {
    this.setState((state) => {
      return {
        product: {
          ...state.product,
          reviews: state.product.reviews.filter((r) => {
            return r.id !== id;
          })
        }
      }
    })
  }

  render() {
    const { id, title, description, created_at, seller, reviews, sale_price } = this.state.product;
    console.log(this.state.product);
    return (
      <main className='page-showpage'>
        {
          id ? 
          <ProductDetails 
            id={id}
            title={title}
            price={sale_price}
            description={description}
            created_at={created_at}
            seller={seller}
          /> :
          <div>Product is loading...</div>
        }
        <ReviewList reviews={reviews} deleteReview={this.deleteReview}/>
      </main>
    )
  }
}


export default ProductShowPage