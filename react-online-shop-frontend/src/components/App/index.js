import React, { useState, useEffect } from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import ProductIndexPage from '../ProductIndexPage';
import ProductShowPage from '../ProductShowPage';
import NewProductPage from '../NewProductPage'
import SignInPage from '../SignInPage'
import NavBar from '../NavBar';
import AuthRoute from '../AuthRoute';
import { Session, User } from '../../requests';
import './index.css'
import Home from '../Home/index'

function App() {
  const [currentUser, setCurrentUser] = useState(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    getCurrentUser();
  }, [])

  function getCurrentUser() {
    User.current().then(user => {
      if (user.id) {
        setCurrentUser(user)
      }
      setIsLoading(false)
    })
  }

  function destroySession() {
    Session.destroy().then(() => setCurrentUser(null));
  }

  return isLoading ? <main>Loading...</main> : (
    <BrowserRouter>
      <NavBar currentUser={currentUser} destroySession={destroySession} />
      <Switch>
        <Route 
          path='/login' 
          exact 
          render={routeProps => (
            <SignInPage {...routeProps} getCurrentUser={getCurrentUser} />
          )}
        />
        <Route 
          path='/home' 
          component={ Home }
        />
        <AuthRoute 
          isAuthenticated={currentUser}
          path='/products' 
          exact 
          component={ ProductIndexPage }
        />
        <AuthRoute 
          isAuthenticated={currentUser}
          path='/products/new' 
          exact
          component={ NewProductPage } 
        />
        <AuthRoute 
          isAuthenticated={currentUser}
          path='/products/:id' 
          component={ ProductShowPage } 
        />
      </Switch>
    </BrowserRouter>
  )
}

export default App
