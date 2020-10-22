import React from 'react'
import StarRating from '../StarRating';

function ReviewDetails({ id, rating, body, created_at, reviewer, deleteReview }) {
  const fullName = reviewer ? reviewer.full_name : 'N/A';

  function handleClick() {
    deleteReview(id);
  }

  return(
    <div>
      <h4>{ body }</h4>
      <StarRating max={5} rating={rating}/>
    </div>
  )
}

export default ReviewDetails