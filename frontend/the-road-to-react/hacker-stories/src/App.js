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

const initialStories = [
  {
    title: 'React',
    url: 'https://reactjs.org/',
    author: 'Jordan Walke',
    num_comments: 3,
    points: 4,
    objectID: 0,
  },
  {
    title: 'Redux',
    url: 'https://redux.js.org/',
    author: 'Dan Abramov, Andrew Clark',
    num_comments: 2,
    points: 5,
    objectID: 1,
  },
];

const getAsyncStories = () =>
  new Promise((resolve) => {
    // throw new Error('Error thrown in getAsyncStories()');
    // mimic a timeout
    setTimeout(() => resolve({ data: { stories: initialStories } }), 500);
  });

const App = () => {
  const title = 'React';

  // asynchronously fetch stories from API
  const [stories, setStories] = React.useState([]);
  const [isLoading, setIsLoading] = React.useState(false);
  const [error, setError] = React.useState('');

  // scroll to bottom of page, make it easier to see new stories
  React.useEffect(() => window.scrollTo(0, document.body.scrollHeight));

  // get stories from API
  React.useEffect(() => {
    setIsLoading(true);

    getAsyncStories()
      .then((result) => {
        setStories(result.data.stories);
        setIsLoading(false);
      })
      .catch((err) => setError(err.toString()));
  }, []);

  const [searchTerm, setSearchTerm] = useSemiPersistentState('search', '');

  const handleSearch = (event) => {
    console.log(event.target.value);

    setSearchTerm(event.target.value);
  };

  const searchedStories = stories.filter((story) => {
    return story.title.toLowerCase().includes(searchTerm.toLowerCase());
  });
  const handleRemoveStory = (item) => {
    const newStories = stories.filter(
      (story) => item.objectID !== story.objectID
    );
    setStories(newStories);
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

        {isLoading ? (
          <p>Loading ...</p>
        ) : (
          <List list={searchedStories} onRemoveItem={handleRemoveStory} />
        )}
        {error !== '' && <p>Something went wrong, error: {error}</p>}
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
