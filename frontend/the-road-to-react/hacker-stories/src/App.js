import logo from './logo.svg';
import React from 'react';
import './App.css';

const App = () => {
  const title = 'React';

  const stories = [
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

  const [searchTerm, setSearchTerm] = React.useState('');
  const handleSearch = event => {
      console.log(event.target.value)
      setSearchTerm(event.target.value)
  }

  const searchedStories = stories.filter(story => {
    return story.title.toLowerCase().includes(searchTerm.toLowerCase())
  })

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

        <Search onSearch={handleSearch}/>

        <hr />

        <List list={searchedStories} />
      </div>
    </div>
  );
}

const Search = props => {
  return (
      <div>
          <label htmlFor='search'>Search: </label>
          <input id='search' type='text' onChange={props.onSearch} />
      </div>
  )
}

const List = props => {
  return (
    <div>
      {props.list.map(function (item) {
        return (
          <div key={item.objectID}>
            <span>
              <a href={item.url}>{item.title}</a>
            </span>
            <span> {item.author}</span>
            <span> {item.points}</span>
            <span> {item.num_comments}</span>
          </div>
        );
      })}
    </div>
  );
}

export default App;
