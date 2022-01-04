import React from 'react';
import ReactDOM from 'react-router-dom';
import Navbar from './Navbar';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import Home from './Home';
import About from './About';
import Contact from './Contact';
import Card from './Card';
import BlogCommentApp from './blog/BlogCommentApp';
import HemisphereApp from './hemisphere/HemisphereApp';
import ImageListApp from './imageList/ImageListApp';
import ClockApp from './ClockApp';


const App = () => {
	return(
		<Router>
			<div className="App">
				<Navbar />
					<Route exact path='/react/home' component={Home} />
					<Route path='/react/about' component={About} />
					<Route path='/react/contact' component={Contact} />
					<Route path='/react/:user' component={Card} />
					<Route path='/react/blog' component={BlogCommentApp} />
					<Route path='/react/hemisphere' component={HemisphereApp} />
					<Route path='/react/imagelist' component={ImageListApp} />
					<Route path='/react/clock' component={ClockApp} />
			</div>
		</Router>
		)
};

ReactDOM.render(
		<App />,
	document.querySelector('#react')
);

// export default App;
