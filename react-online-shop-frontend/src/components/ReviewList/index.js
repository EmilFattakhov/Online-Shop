import React from 'react';
import ReviewDetails from '../ReviewDetails';

function ReviewList({ reviews, deleteReview }) {
  return(
    <ul className="list">
      { reviews && reviews.map(review => {
        return(
          <li key={review.id}><ReviewDetails { ...review } deleteReview={deleteReview}/></li>
        )
      })}
    </ul>
  )
}
export default ReviewList;