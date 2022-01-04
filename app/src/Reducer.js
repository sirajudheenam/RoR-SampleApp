import { createStore } =  'Redux';

const initialState = {
  todos: [],
  posts: []
}

function reducer(state = initialState, action) {
  if (action.type === 'ADD_TODO') {
    return {
      todos: [...state.todos, action.payload ]
    }
  }
}

const store = createStore(reducer);

store.subscribe( () => {
  console.log('state updated');
  console.log(store.getState());
});
addTodoAction = {type: 'ADD_TODO', payload: 'learn redux' };

store.dispatch(addTodoAction)
