import React from 'react';

function getInputText() {
	return 'Enter eMail Address';
}
const Form = () => {
	// const buttonText = 'Click me !';
	const buttonProps = { text: 'Click me !', bgColor: 'red', color: 'white'}
	const inputValue = "enter valid email";
	const inputStyle = { backgroundColor: 'yellow', color: 'black' }
	return(
		<div>
			<h1> Sample Form</h1>
			<label htmlFor="email" className="label"> { getInputText() } </label>
			<input type="text" id="email" defaultValue={inputValue} style={inputStyle}></input>
			<button style={{ backgroundColor: `${ buttonProps.bgColor }`, color: `${ buttonProps.color }` }}>
			{ buttonProps.text }
			</button>
		</div>
		)
};

export default Form;
