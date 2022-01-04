const initialState = {
  cards: [
    { id: 1, title: 'Wafiqah', location: 'Madurai, India', body: 'First daughter'},
    { id: 2, title: 'Tishya', location: 'Surabaya, Indonesia', body: 'Second daughter'},
    { id: 3, title: 'Femida', location: 'Berlin, Germany', body: 'Third daughter'},
    { id: 4, title: 'Farzana', location: 'Chennai, India', body: 'Fourth daughter'}
  ]
}

const rootReducer = (state = initialState, action) => {
  return state;
}

export default rootReducer;
