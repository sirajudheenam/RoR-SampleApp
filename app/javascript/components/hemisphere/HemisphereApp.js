import React from 'react';
import ReactDOM from 'react-dom';
import HemisphereDisplay from './HemisphereDisplay';
// const App = () => {
// 	window.navigator.geolocation.getCurrentPosition(
// 		(position) => console.log(position),
// 		(error) => console.log(error)
// 	);
// 	return(
// 		<div>
// 			You are in Nothern Hemispehere
// 		</div>
// 	)
// }

class HemispehereApp extends React.Component {

	// constructor(props) {
	// 	super(props);
	//
	// 	// one time set up
	// 	this.state = { latitude: null, errorMessage: '' }
	// }

	state = { latitude: null, errorMessage: '' }

	componentDidMount() {
		// Place to do data loading

		// console.log('componentDidMount');
		window.navigator.geolocation.getCurrentPosition(
			(position) => {
				this.setState({latitude: position.coords.latitude	})
			},
			(error) => {
				this.setState({ errorMessage: error.message})
			}
		);
	}
	componentDidUpdate() {
		// Place to do more data loading when state/prop change

		console.log('componentDidUpdate');
	}
	componentWillUnmount() {
		// Place to cleanup

		console.log('componentWillUnmount');
	}
	render() {
		if (this.state.errorMessage && !this.state.latitude) {
		 	return	<div>{ this.state.errorMessage }</div>
		}
		if (!this.state.errorMessage && this.state.latitude) {
			return <div> <HemisphereDisplay latitude={this.state.latitude} /> </div>
		}
		if (!this.state.errorMessage && !this.state.latitude) {
			return <div>Loading...</div>
		}
	}
}

export default HemispehereApp;
