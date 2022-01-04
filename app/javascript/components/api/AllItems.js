import React from "react"
import PropTypes from "prop-types"
import Item from './Item'

class AllItems extends React.Component {
  constructor(props) {
    super(props);
    console.log("AllItems");
    console.log(props);
    this.handleDelete = this.handleDelete.bind(this);
    this.onUpdate = this.onUpdate.bind(this);
  };

  handleDelete(id) {
      this.props.handleDelete(id);
  };

  onUpdate(item) {
      this.props.onUpdate(item);
  };


  render() {
          var items= this.props.items.map((item) => {
              return (
                  <div key={item.id}>
                      <Item item={item}
                            handleDelete={this.handleDelete.bind(this, item.id)}
                            handleUpdate={this.onUpdate}/>
                  </div>
              )
          });
      return(
          <div>
            {items}
          </div>
      )
  }
}

export default AllItems;
