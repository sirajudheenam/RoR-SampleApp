import React from "react"
import PropTypes from "prop-types"
class Post extends React.Component {
  render () {
    return (
      <React.Fragment>
        Title: {this.props.title}
        Published: {this.props.published}
      </React.Fragment>
    );
  }
}

Post.propTypes = {
  title: PropTypes.string,
  published: PropTypes.bool
};
export default Post
