import React from 'react';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux'
// import Modal from './Modal';

// const Contact = ({ cards }) => {
const Contact = (props) => {
  // setTimeout( () => {
  //   props.history.push('/about')
  // }, 2000 )
  return(
    <div
      className="ui raised very padded text container segment"
      style={{ marginTop: '80px' }}
    >
      <Link to={`/${card.title}`}className="ui header">{card.title}</Link>
      <h4>{card.location}</h4>
      <p>{card.body}</p>
    </div>
  )

  const mapStateToProps = (state) => {
    return {
      cards: state.cards
    }
}
export default connect(mapStateToProps)(Contact);

// react-router-dom 5 major version
// const Contact = ({ cards }) => {
//   return(
//     <div>
//       {
//         cards.map(card => {
//         return (
//                 <div
//                   className="ui raised very padded text container segment"
//                   style={{ marginTop: '80px' }}
//                   key={card.id}
//                 >
//                   <Link to={`/${card.title}`}className="ui header">{card.title}</Link>
//                   <h4>{card.location}</h4>
//                   <p>{card.body}</p>
//                 </div>
//               )
//       })
//     }
//     </div>
//   )
// }
//
// export default Contact;
