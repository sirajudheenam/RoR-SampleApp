import React from 'react';
import { Link, NavLink, withRouter } from 'react-router-dom';

import './Navbar.css'
// Link & NavLink pretty much same
// except NavLink adds class=active when clicked on link.
// This is useful to style the links if active
const Navbar = (props) => {
  return(
    <nav className='ui raised very padded segment'>
      <a className="ui teal inverted segment">Gloria</a>
      <div className='ui right floated header'>
        <button className="ui button"><Link to='/'>Home</Link></button>
        <button className="ui button"><Link to='/about'>About</Link></button>
        <button className="ui button"><Link to='/contact'>Contact</Link></button>
        <button className="ui button"><NavLink to='/blog'>Blog</NavLink></button>
        <button className="ui button"><NavLink to='/hemisphere'>Hemisphere</NavLink></button>
        <button className="ui button"><NavLink to='/imagelist'>Imagelist</NavLink></button>
        <button className="ui button"><NavLink to='/templates'>Templates</NavLink></button>
      </div>
    </nav>
  )
}

export default withRouter(Navbar);
