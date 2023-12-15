import logo from './logo.svg';
import React from 'react';
import './App.css';

const useSemiPersistentState = (key, initialState) => {
  const [searchTerm, setSearchTerm] = React.useState(
    localStorage.getItem(key) || initialState
  );

  // track dependencies and trigger side effect.
  React.useEffect(() => {
    localStorage.setItem(key, searchTerm);
  }, [searchTerm, key]);
  return [searchTerm, setSearchTerm];
};

const storiesReducer = (state, action) => {
  switch (action.type) {
    case 'STORIES_FETCH_INIT':
      return {
        ...state,
        isLoading: true,
        isError: false,
      };
    case 'STORIES_FETCH_SUCCESS':
      return {
        ...state,
        isLoading: false,
        isError: false,
        data: action.payload,
      };
    case 'STORIES_FETCH_FAILURE':
      return {
        ...state,
        isLoading: false,
        isError: true,
      };
    case 'REMOVE_STORY':
      return {
        ...state,
        data: state.data.filter(
          (story) => action.payload.objectID !== story.objectID
        ),
      };
    default:
      throw new Error();
  }
};

const API_ENDPOINT = 'https://hn.algolia.com/api/v1/search?query=';

const App = () => {
  const title = 'React';

  // asynchronously fetch stories from API
  const [stories, dispatchStories] = React.useReducer(storiesReducer, {
    data: [],
    isLoading: false,
    isError: false,
  });

  // scroll to bottom of page, make it easier to see new stories
  React.useEffect(() => window.scrollTo(0, document.body.scrollHeight));

  const [searchTerm, setSearchTerm] = useSemiPersistentState('search', '');
  // get stories from API
  const handleFetchStories = React.useCallback(() => {
    if (!searchTerm) return;

    dispatchStories({ type: 'STORIES_FETCH_INIT' });

    fetch(`${API_ENDPOINT}${searchTerm}`)
      .then((response) => response.json())
      .then((result) => {
        dispatchStories({
          type: 'STORIES_FETCH_SUCCESS',
          payload: result.hits,
        });
      })
      .catch((err) =>
        dispatchStories({ type: 'STORIES_FETCH_FAILURE' })(err.toString())
      );
  }, [searchTerm]);

  React.useEffect(() => {
    handleFetchStories();
  }, [handleFetchStories]);

  const handleSearch = (event) => {
    console.log(event.target.value);

    setSearchTerm(event.target.value);
  };

  const handleRemoveStory = (item) => {
    dispatchStories({
      type: 'REMOVE_STORY',
      payload: item,
    });
  };

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React, Hello {title}
        </a>
      </header>
      <div>
        <h1>My Hacker Stories</h1>

        <InputWithLabel
          id="search"
          value={searchTerm}
          onChange={handleSearch}
          autoFocus
        >
          <strong>Filter:</strong>
        </InputWithLabel>

        <hr />

        {stories.isLoading ? (
          <p>Loading ...</p>
        ) : (
          <List list={stories.data} onRemoveItem={handleRemoveStory} />
        )}
        {stories.isError !== '' && <p>Something went wrong...</p>}
      </div>
    </div>
  );
};

const InputWithLabel = ({
  id,
  value,
  type = 'text',
  onChange,
  children,
  autoFocus,
}) => {
  return (
    <>
      <label htmlFor={id}>{children}</label>
      &nbsp;
      <input
        id={id}
        autoFocus={autoFocus}
        type={type}
        value={value}
        onChange={onChange}
      />
    </>
  );
};

const List = ({ list, onRemoveItem }) => {
  return (
    <>
      {list.map((item) => (
        <Item key={item.objectID} item={item} onRemoveItem={onRemoveItem} />
      ))}
    </>
  );
};

const Item = ({ item, onRemoveItem }) => {
  return (
    <div key={item.objectID}>
      <span>
        <a href={item.url}>{item.title}</a>
      </span>
      &nbsp;
      <span>{item.author}</span>
      &nbsp;
      <span>{item.points}</span>
      &nbsp;
      <span>{item.num_comments}</span>
      &nbsp;
      <span>
        <button type="button" onClick={() => onRemoveItem(item)}>
          Dismiss
        </button>
      </span>
    </div>
  );
};

export default App;
