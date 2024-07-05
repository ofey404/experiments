export default function Home() {
  return (
    <div className="container mx-auto my-10 p-10 border">
      <nav className="navbar border">
        <div className="container flex flex-wrap justify-between items-center mx-auto">
          <a href="#" className="flex items-center">
            <span className="self-center text-xl font-semibold whitespace-nowrap">SaaS Console</span>
          </a>
          <div className="flex md:hidden">
            <button type="button" className="btn" aria-expanded="false">
              Features
              <svg className="w-4 h-4 ml-2" aria-hidden="true" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 9l-7 7-7-7"></path>
              </svg>
            </button>
            <div className="hidden z-50 my-4 text-base list-none bg-white rounded divide-y divide-gray-100 shadow" id="dropdown">
              <ul className="py-1" aria-labelledby="dropdownButton">
                <li>
                  <a href="#" className="block py-2 px-4 text-sm">Feature 1</a>
                </li>
                <li>
                  <a href="#" className="block py-2 px-4 text-sm">Feature 2</a>
                </li>
                <li>
                  <a href="#" className="block py-2 px-4 text-sm">Feature 3</a>
                </li>
                <li>
                  <a href="#" className="block py-2 px-4 text-sm">Feature 4</a>
                </li>
              </ul>
            </div>
          </div>
          <div className="hidden justify-between items-center w-full md:flex md:w-auto" id="mobile-menu-2">
            <ul className="flex flex-col mt-4 md:flex-row md:space-x-8 md:mt-0 md:text-sm md:font-medium">
              <li>
                <a href="#" className="block py-2 pr-4 pl-3 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:p-0">Home</a>
              </li>
              <li>
                <a href="#" className="block py-2 pr-4 pl-3 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:p-0">Dashboard</a>
              </li>
            </ul>
          </div>
          <div className="flex items-center">
            <button type="button" className="btn">
              <span className="mr-2">User Profile</span>
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5.121 17.804A9 9 0 1112 21a9 9 0 01-6.879-3.196zM12 12a3 3 0 100-6 3 3 0 000 6z"></path>
              </svg>
            </button>
          </div>
        </div>
      </nav>
      <div className="flex">
        <aside className="hidden md:block w-1/4 p-4 border-r">
          <h2 className="text-lg font-semibold mb-4">Features</h2>
          <ul className="space-y-2">
            <li>
              <button className="w-full text-left p-2 rounded hover:bg-blue-600">
                Feature 1
              </button>
            </li>
            <li>
              <button className="w-full text-left p-2 rounded hover:bg-blue-600">
                Feature 2
              </button>
            </li>
            <li>
              <button className="w-full text-left p-2 rounded hover:bg-blue-600">
                Feature 3
              </button>
            </li>
            <li>
              <button className="w-full text-left p-2 rounded hover:bg-blue-600">
                Feature 4
              </button>
            </li>
          </ul>
        </aside>
        <main className="w-full md:w-3/4 p-4">
          <nav className="flex mb-4" aria-label="Breadcrumb">
            <ol className="inline-flex items-center space-x-1 md:space-x-3">
              <li>
                <div className="flex items-center">
                  <a href="#" className="ml-1 text-sm font-medium text-gray-700 hover:text-blue-600 md:ml-2">Dashboard</a>
                </div>
              </li>
              <li>
                <div className="flex items-center">
                  {renderArrowIcon()}
                  <a href="#" className="ml-1 text-sm font-medium text-gray-700 hover:text-blue-600 md:ml-2">Feature</a>
                </div>
              </li>
            </ol>
          </nav>
          {/* Main content goes here */}
        </main>
      </div>
    </div>
  );
}

function renderArrowIcon() {
  return (
    <svg className="w-6 h-6 text-gray-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
      <path fillRule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clipRule="evenodd"></path>
    </svg>
  );
}