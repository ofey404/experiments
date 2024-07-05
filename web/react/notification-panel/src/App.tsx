import React from 'react';
import logo from './logo.svg';
import './App.css';

const initialNotifications = [
  { content: 'Notification 1', timestamp: 1688208000 },
  { content: 'Notification 2', timestamp: 1688211600 },
  { content: 'Notification 3', timestamp: 1688215200 },
  { content: 'Notification 4', timestamp: 1688218800 },
  { content: 'Notification 5', timestamp: 1688222400 },
];

function App() {
  const [isNotificationOpen, setIsNotificationOpen] = React.useState(true);
  const [notifications, setNotifications] = React.useState(initialNotifications);

  const toggleNotification = () => {
    setIsNotificationOpen(!isNotificationOpen);
  };

  const addMoreNotifications = () => {
    const newNotifications = [];
    const currentTimestamp = Math.floor(Date.now() / 1000);
    for (let i = 1; i <= 5; i++) {
      newNotifications.push({
        content: `Notification ${notifications.length + i}`,
        timestamp: currentTimestamp + i * 60
      });
    }
    setNotifications([...notifications, ...newNotifications]);
  };

  const formatTimestamp = (timestamp: number) => {
    const date = new Date(timestamp * 1000);
    return date.toISOString().replace('T', ' ').substring(0, 19);
  };

  return (
    <div className="App flex flex-col min-h-screen">
      <nav className="bg-gray-800 p-4 flex justify-between">
        <ul className="flex space-x-4">
          <li>
            <a href="#" className="text-white">Home</a>
          </li>
          <li>
            <a href="#" className="text-white">About</a>
          </li>
          <li>
            <a href="#" className="text-white">Contact</a>
          </li>
        </ul>
        <div className="relative">
          <button
            className="text-white focus:outline-none"
            onClick={toggleNotification}
          >
            Notifications
          </button>
          {isNotificationOpen && (
            <div className="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg z-20 max-h-96 overflow-y-auto">
              <ul className="py-1">
                {notifications.map((notification, index) => (
                  <li key={index} className="px-4 py-2 text-gray-800 hover:bg-gray-200">
                    <div>{notification.content}</div>
                    <div className="text-sm text-gray-500">{formatTimestamp(notification.timestamp)}</div>
                  </li>
                ))}
              </ul>
              <button
                className="w-full px-4 py-2 text-center text-gray-800 hover:bg-gray-200"
                onClick={addMoreNotifications}
              >
                More Notifications
              </button>
            </div>
          )}
        </div>
      </nav>
      <div className="flex-grow flex items-center justify-center">
        <div className="text-center">
          <img src={logo} className="App-logo mx-auto" alt="logo" />
          <h1 className="text-3xl font-bold">
            Click Notification button on the top left to see notifications
          </h1>
        </div>
      </div>
    </div>
  );
}

export default App;
