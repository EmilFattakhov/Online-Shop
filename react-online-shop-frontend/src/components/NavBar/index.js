import React from 'react';
import { NavLink } from 'react-router-dom';
import './index.css'

function NavBar({ currentUser, destroySession }) {

  const handleSignOut = event => {
    event.preventDefault();
    destroySession();
  }

  return(
    <nav className='navbar'>
      <div className='container-split'>
        <div></div>
        <div className='links'>
          <NavLink style={{ textDecoration: 'none' }} to='/home'><h1>Home</h1></NavLink>
          <NavLink style={{ textDecoration: 'none' }} to='/products'><h1>View All Products</h1></NavLink>
          {currentUser ? (
          <>
          <NavLink style={{ textDecoration: 'none' }} to='/products/new'><h1>Sell Your Product</h1></NavLink>
          <span><h2>Welcome, {currentUser.full_name}</h2></span>
          <a href="#" onClick={handleSignOut}><h1>Sign Out</h1></a>
          </>
        ) : (
        <NavLink style={{ textDecoration: 'none' }} to='/login'><h1>Sign In</h1></NavLink>
        )}
        </div>
      </div>
      
    </nav>
  )
}

export default NavBar
