import './App.css';
import Navigation from './components/navigation';
import Twitter from './components/Twitter/twitterWrapper';
import firebase from './firebase';

function App() {
  return (
    <div className="App" style={{ height: '100vh', overflow: 'scroll' }}>
      <div style={{ display: 'flex', justifyContent: 'space-around' }}>
        <div>
          <img
            src="harmony-logo-horizontal-full-color.svg"
            width="50%"
            height="100%"
          />
        </div>
        <div>
          <img
            src="1200px-Download_on_the_App_Store_Badge.svg.png"
            width="20%"
            height="70%"
          />
          <img src="en_badge_web_generic.png" width="20%" height="100%" />
        </div>
      </div>
      <div style={{ display: 'flex', height: '100%' }}>
        <div style={{ width: '20%', overflow: 'scroll' }}>
          <Twitter />
        </div>
        <Navigation />
        <div>
          <iframe
            id="tgw_5fe0fbb683ba8839128b456c"
            frameBorder="0"
            scrolling="no"
            horizontalscrolling="no"
            verticalscrolling="no"
            width="120%"
            height="100%"
            async
            src="https://tgwidget.com/channel/v2.0/?id=5fe0fbb683ba8839128b456c"
          ></iframe>
        </div>
      </div>
    </div>
  );
}

export default App;
