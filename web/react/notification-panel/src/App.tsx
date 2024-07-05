import React from 'react';
import logo from './logo.svg';
import './App.css';

const initialNotifications = [
  { content: 'Notification 1', timestamp: 1688208000, status: 'unread' },
  { content: 'Notification 2', timestamp: 1688211600, status: 'unread' },
  { content: 'Notification 3', timestamp: 1688215200, status: 'unread' },
  { content: 'Notification 4', timestamp: 1688218800, status: 'unread' },
  { content: 'Notification 5', timestamp: 1688222400, status: 'unread' },
];

function App() {
  const [isNotificationOpen, setIsNotificationOpen] = React.useState(false);
  const [notifications, setNotifications] = React.useState(initialNotifications);

  const toggleNotification = () => {
    setIsNotificationOpen(!isNotificationOpen);
    if (!isNotificationOpen) {
      markAllAsRead();
    }
  };

  const addMoreNotifications = () => {
    const newNotifications = [];
    const currentTimestamp = Math.floor(Date.now() / 1000);
    for (let i = 1; i <= 5; i++) {
      newNotifications.push({
        content: `Notification ${notifications.length + i}`,
        timestamp: currentTimestamp + i * 60,
        status: 'read'
      });
    }
    setNotifications([...notifications, ...newNotifications]);
  };

  const markAllAsRead = () => {
    const updatedNotifications = notifications.map(notification => ({
      ...notification,
      status: 'read'
    }));
    setNotifications(updatedNotifications);
  };

  const formatTimestamp = (timestamp: number) => {
    const date = new Date(timestamp * 1000);
    return date.toISOString().replace('T', ' ').substring(0, 19);
  };

  const hasUnreadNotifications = notifications.some(notification => notification.status === 'unread');

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
            className="text-white focus:outline-none relative"
            onClick={toggleNotification}
          >
            Notifications
            {hasUnreadNotifications && (
              <span className="absolute top-0 right-0 inline-block w-2 h-2 bg-red-600 rounded-full"></span>
            )}
          </button>
        </div>
      </nav>
      <div
        className={`fixed top-0 right-0 bottom-0 bg-white shadow-lg z-20 transform ${isNotificationOpen ? 'translate-x-0' : 'translate-x-full'
          } transition-transform duration-300 ease-in-out`}
        onClick={(e) => e.stopPropagation()}
      >
        <div className="p-4 h-full flex flex-col">
          <h2 className="text-xl font-bold mb-4">Notifications</h2>
          <ul className="flex-grow overflow-y-auto">
            {notifications.map((notification, index) => (
              <li key={index} className="px-4 py-2 text-gray-800 hover:bg-gray-200">
                <div>{notification.content}</div>
                <div className="text-sm text-gray-500">{formatTimestamp(notification.timestamp)}</div>
              </li>
            ))}
            <li className="px-4 py-2 text-center text-gray-800 hover:bg-gray-200">
              <button
                className="w-full"
                onClick={addMoreNotifications}
              >
                More Notifications
              </button>
            </li>
          </ul>
        </div>
      </div>
      <div
        className={`fixed inset-0 z-10 ${isNotificationOpen ? 'block' : 'hidden'}`}
        onClick={() => setIsNotificationOpen(false)}
      ></div>
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
