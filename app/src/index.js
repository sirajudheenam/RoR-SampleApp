import React from 'react';
import ReactDOM from 'react-dom';
import ClockApp from './components/clock/ClockApp';
import App from './App';

import { createStore } from 'redux';
import { Provider } from  'react-redux';

import rootReducer from './reducers/rootReducer'

const store = createStore(rootReducer);

ReactDOM.render(
	<Provider store={store} >
		<App />
	</Provider>,
	document.querySelector('#root')
);
