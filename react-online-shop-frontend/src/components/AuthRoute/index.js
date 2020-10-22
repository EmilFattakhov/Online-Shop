import React from 'react';
import { Route, Redirect } from 'react-router-dom';

function AuthRoute({ isAuthenticated, component, ...routeProps }) {
  
  return isAuthenticated ? (
    <Route {...routeProps} component={component} />
  ) : (
    <Redirect to="/login" />
  )
}

export default AuthRoute;
