import React from 'react';
import NorthernPic from '../../images/hemisphere/NorthernHemisphere.jpg';
import SouthernPic from '../../images/hemisphere/SouthernHemisphere.jpg';
import './Hemisphere.css'
const hemisphereConfig = {
  Northern: {
    text: 'it is northern hemisphere',
    picture: NorthernPic
  },
  Southern: {
    text: 'it is southern hemisphere',
    picture: SouthernPic
  }
};
// const HemisphereDisplay = (props) => {
// console.log(props.latitude)
const HemisphereDisplay = ({ latitude }) => {
  const hemisphere = latitude > 0 ? 'Northern' : 'Southern';
  // const picture = latitude > 0 ? NorthernPic : SouthernPic
  const { text, picture } = hemisphereConfig[hemisphere]
  return(
    <div className={hemisphere}>
      <div className="ui raised container segment">
        <div className="image">
          <img src={ picture } alt="Hemisphere" />
        </div>
        <div className="ui teal bottom attached label">
          <h1>{ text }</h1>
        </div>
      </div>
    </div>
  )
}

export default HemisphereDisplay;
