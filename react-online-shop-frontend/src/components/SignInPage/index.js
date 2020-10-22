import React, { Component } from 'react';
import { Session } from '../../requests';

class SignInPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      error: null,
    }
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(event) {
    event.preventDefault();
    const { currentTarget } = event;
    const formData = new FormData(currentTarget);

    Session.create({
      email: formData.get('email'),
      password: formData.get('password'),
    }).then(data => {
      const { getCurrentUser, history } = this.props;
      if (data.status === 404) {
        this.setState({
          error: "Wrong email or password",
        });
      } else {
        getCurrentUser();
        history.push('/');
      }
    });
  }

  render() {
    const { error } = this.state;
    return(
      <main>
        <h1>Sign In</h1>
        <p>{error}</p>
        <form onSubmit={this.handleSubmit} >
          <div>
            <label htmlFor="email">Email</label>
            <input type="email" name="email" id="email" />
          </div>
          <div>
            <label htmlFor="password">Password</label>
            <input type="password" name="password" id="password" />
          </div>
          <input type="submit" value="Sign In" />
        </form>
      </main>
    )
  }
}

export default SignInPage
