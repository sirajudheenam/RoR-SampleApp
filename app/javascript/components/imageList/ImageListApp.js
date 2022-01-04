import React from 'react';
import SearchInput from './SearchInput';
import ImageList from './ImageList';
import axios from 'axios';

// const ImageListApp = () => {
class ImageListApp extends React.Component {
  // First way to solve this reference problem
  constructor() {
    super()
    this.state = { images: [] }
    this.onSearchSubmit = this.onSearchSubmit.bind(this);
  }

  async onSearchSubmit(entry) {
    const response = await axios.get(`https://pixabay.com/api/?key=24924244-a01a1cb63ce6107a22356821e&q=${entry}&image_type=photo`)
    this.setState({images:response.data.hits})
  }

  // Second way to solve this reference problem
  // (this) reference problem as earlier
  // arrow function can also solve it.
  // state = { images: [] }
  //  onSearchSubmit = async (entry) => {
  //   const response = await axios.get(`https://pixabay.com/api/?key=24924244-a01a1cb63ce6107a22356821e&q=${entry}&image_type=photo`)
  //   this.setState({images:response.data.hits})
  // }


  // <SearchInput onSearchSubmit={this.onSearchSubmit} />
  // onSearchSubmit is the props of SearchInput
  // which is assigned with the function onSearchSubmit
  // function onFormSubmit of SearchInput Class will call it with
  // input value (this.state.entry)
  render() {
    return(
      <div className="ui container" style={{marginTop: '40px'}}>
        <SearchInput onSearchSubmit={this.onSearchSubmit}/>
        We have {this.state.images.length} images
        <ImageList images={this.state.images} />
      </div>
    )
  }
}

export default ImageListApp;
