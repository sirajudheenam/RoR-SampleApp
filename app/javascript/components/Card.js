import React from 'react';

class Card extends React.Component {

  componentDidMount() {
    // let user = this.props.match.params.user;
    console.log(this.props.name, this.props.age );
  }

  render() {
    return(
      <div className="ui raised very padded text container segment"
        style={{ marginTop: '80px' }} >
        <h3 className="ui header">Card</h3>
      </div>
    )
  }
}

export default Card;
