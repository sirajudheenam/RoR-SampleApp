import React from 'react';
import './Modal.css'
const About = () => {
  return(
    <div>
      {
        // <div className="wrapper">
        //   <div className="modal">
        //     <div className="modal-content">
        //       <h3>I am a modal </h3>
        //     </div>
        //   </div>
        // </div>
      }
      <div
        className='ui raised very padded text container segment'
        style={{ marginTop: '80px' }}
      >
        <h3 className='ui header'>About</h3>
        <p>lorum uo quem deserunt praetermissum, anim mentitum e imitarentur, quorum mandaremus
        iis dolore fore sed incididunt anim anim o enim. Enim relinqueret pariatur
        summis vidisse. Tempor sed commodo de sunt, et noster legam aute fabulas, ex
        nostrud exquisitaque, quo duis fabulas exquisitaque.</p>
      </div>
    </div>
  )
}
export default About;
