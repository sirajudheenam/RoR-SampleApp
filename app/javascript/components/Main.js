import React from "react";
import Header from "./api/Header";
import Body from "./api/Body";

import "./Main.css";

class Main extends React.Component {
  render() {
      return (
          <div >
              <Header />
              <Body />
          </div>
      )
  }
}

export default Main;
