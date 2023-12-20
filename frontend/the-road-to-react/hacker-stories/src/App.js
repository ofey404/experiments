import logo from './logo.svg';
import React from 'react';
import axios from 'axios';
import styles from './App.module.css';

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

  const [searchTerm, setSearchTerm] = useSemiPersistentState('search', '');
  const [url, setUrl] = React.useState(`${API_ENDPOINT}${searchTerm}`);

  const handleSearchInput = (event) => {
    setSearchTerm(event.target.value);
  };
  const handleSearchSubmit = (event) => {
    setUrl(`${API_ENDPOINT}${searchTerm}`);

    // prevent page reload, which is the browser's default behavior
    event.preventDefault();
  };

  // get stories from API
  const handleFetchStories = React.useCallback(async () => {
    dispatchStories({ type: 'STORIES_FETCH_INIT' });

    try {
      const result = await axios.get(url);
      dispatchStories({
        type: 'STORIES_FETCH_SUCCESS',
        payload: result.data.hits,
      });
    } catch (err) {
      dispatchStories({ type: 'STORIES_FETCH_FAILURE' })(err.toString());
    }
  }, [url]);

  React.useEffect(() => {
    handleFetchStories();
  }, [handleFetchStories]);

  const handleRemoveStory = (item) => {
    dispatchStories({
      type: 'REMOVE_STORY',
      payload: item,
    });
  };

  return (
    <div className="App">
      {/* css module's benefit: mismatch would become javascript errors */}
      <div className={styles.container}>
        <h1 className={styles.headlinePrimary}>My Hacker Stories</h1>

        <SearchForm
          searchTerm={searchTerm}
          onSearchInput={handleSearchInput}
          onSearchSubmit={handleSearchSubmit}
        />
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
      <label htmlFor={id} className={styles.label}>
        {children}
      </label>
      &nbsp;
      <input
        id={id}
        autoFocus={autoFocus}
        type={type}
        value={value}
        onChange={onChange}
        className={styles.input}
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
    <div className={styles.item} key={item.objectID}>
      <span style={{ width: '40%' }}>
        <a href={item.url}>{item.title}</a>
      </span>
      &nbsp;
      <span style={{ width: '30%' }}>{item.author}</span>
      &nbsp;
      <span style={{ width: '10%' }}>{item.points}</span>
      &nbsp;
      <span style={{ width: '10%' }}>{item.num_comments}</span>
      &nbsp;
      <span style={{ width: '10%' }}>
        <button
          className={`${styles.button} ${styles.buttonSmall}`}
          type="button"
          onClick={() => onRemoveItem(item)}
        >
          Dismiss
        </button>
      </span>
    </div>
  );
};

const SearchForm = ({ searchTerm, onSearchInput, onSearchSubmit }) => (
  <form onSubmit={onSearchSubmit} className={styles.searchForm}>
    <InputWithLabel
      id="search"
      value={searchTerm}
      onChange={onSearchInput}
      autoFocus
    >
      <strong>Filter:</strong>
    </InputWithLabel>
    <button
      type="submit"
      className={`${styles.button} ${styles.buttonLarge}`}
      disabled={!searchTerm}
    >
      Submit
    </button>
  </form>
);

export default App;
