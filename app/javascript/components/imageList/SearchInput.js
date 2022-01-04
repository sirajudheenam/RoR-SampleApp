import React from 'react';

class SearchInput extends React.Component {
  // constructor() {
  //   super();
  //   // explicit binding (of this) is needed, if onFormSubmit is a normal function
  //   this.onFormSubmit = this.onFormSubmit.bind(this);
  // }
  state = {entry: ''}
  // onInputChange(event) {
  //   console.log(event.target.value)
  // }
  // <input onChange={this.onInputChange} />
  // <input onChange={(event) => console.log(event.target.value)} />

  // onFormSubmit(event) {
  //   event.preventDefault();
  //   // bind this with function onFormSubmit on constructor else below won't work
  //   // else convert the function onFormSubmit into an arrow function
  //   console.log(this.state.entry);
  //   // Calling from ImageListApp (parent class) to SearchInput (child class)
  //   this.props.onSearchSubmit(this.state.entry);
  // }

  onFormSubmit = (event) => {
    event.preventDefault()
    // console.log(this)
    // bind this with function onFormSubmit on constructor else below won't work
    // else convert the function to arrow function
    // so converted the function onFormSubmit into an arrow function
    // constructor can be removed now
    // Calling from ImageListApp (parent class) to SearchInput (child class)
    // by calling the method of the parent component
    this.props.onSearchSubmit(this.state.entry)

  }

  render() {
    return(
      <div className="ui segment">
        <form onSubmit={this.onFormSubmit} className="ui form">
          <div className="field">
            <div className="ui icon massive input">
              <input
                id="searchText"
                type="text"
                placeholder="Search..."
                onChange={(event) => this.setState({entry:event.target.value})}
                value={this.state.entry}
                />
              <i className="search icon"></i>
            </div>
          </div>
        </form>
      </div>
    )
  }
}

export default SearchInput;
