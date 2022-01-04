import React from "react";
import PropTypes from "prop-types";

class Item extends React.Component {
  constructor(props) {
    super(props);
    console.log("constructor");
    console.log(props);
    this.state =  { editable: false };
    this.handleEdit = this.handleEdit.bind(this);
  };

  handleEdit() {
    console.log(this);
      if(this.state.editable) {
          var name = this.refs.name.value;
          var id = this.props.item.id;
          var description = this.refs.description.value;
          var item = {id: id , name: name , description: description};
          this.props.handleUpdate(item);

      }
      this.setState({ editable: !this.state.editable })
  }

  render() {
      var name = this.state.editable ? <input type='text' ref='name' defaultValue={this.props.item.name} /> : <h3>{this.props.item.name}</h3>;
      var description = this.state.editable ? <input type='text' ref='description' defaultValue={this.props.item.description} />: <p>{this.props.item.description}</p>;
      return (
          <div className="item">
            <table className="table table-striped">
            <thead>
              <tr>
                <td> {name}</td>
                <td> {description} </td>
                <td> <button onClick={this.handleEdit} className="btn btn-primary"> {this.state.editable ? 'Submit' : 'Edit' } </button> </td>
                <td> <button onClick={this.props.handleDelete} className="btn btn-secondary">Delete</button> </td>
              </tr>
            </thead>
            </table>
          </div>
      )
  }
}

Item.propTypes = {
  id: PropTypes.number,
  name: PropTypes.string,
  description:PropTypes.string
};

Item.defaultProps = {
  item: {
    id: 1,
    name: "MyName",
    description: "My Name description"
  }
};
export default Item;
