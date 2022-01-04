import React from "react"
import PropTypes from "prop-types"
class MiniPost extends React.Component {
  render () {
    return (
      <React.Fragment>
        Title: {this.props.title}
        Published: {this.props.published}
        Published By: {this.props.publishedBy}
      </React.Fragment>
    );
  }
}

MiniPost.propTypes = {
  title: PropTypes.string,
  published: PropTypes.bool,
  publishedBy: PropTypes.string
};
export default MiniPost
