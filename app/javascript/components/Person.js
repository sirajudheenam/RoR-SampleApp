import React from "react"
import PropTypes from "prop-types"
class Person extends React.Component {
  render () {
    return (
      <React.Fragment>
        Name: {this.props.name}
      </React.Fragment>
    );
  }
}

Person.propTypes = {
  name: PropTypes.node
};
export default Person
