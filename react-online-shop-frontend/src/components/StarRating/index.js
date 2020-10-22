import React from 'react';
import Star from '../Star';

function StarRating({ max, rating }) {
  const stars = []
  for(let i = 0; i < max; i++) {
    if (i < rating) {
      stars.push(
        <Star key={i} style={{color: 'yellow', width: '25px'}}/>
      )
    } else {
      stars.push(
        <Star key={i} style={{width: '25px', color: 'lightgrey'}}/>
      )
    }
  }
  return(
    <div>
      { stars }
    </div>
  )
}

export default StarRating
