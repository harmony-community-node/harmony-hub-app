import './App.css';
import Navigation from './components/navigation';
import Twitter from './components/Twitter/twitterWrapper';
import firebase from './firebase';
import Divider from '@material-ui/core/Divider';
import { useState } from 'react';

function App() {
  const [mobile, setMobile] = useState(window.innerWidth > window.innerHeight);
  console.log(mobile, window.width, window.height);

  return (
    <div className="App" style={{ height: '100vh', overflow: 'scroll' }}>
      {mobile && (
        <>
          <div style={{ display: 'flex', justifyContent: 'space-around' }}>
            <div>
              <img
                src="harmony-logo-horizontal-ful-color.svg"
                width="50%"
                height="100%"
              />
            </div>
            <Divider orientation="vertical" />
            <div>
              {' '}
              <a
                href="https://apps.apple.com/us/app/harmony-hub-app/id1526055095"
                target="_blank"
              >
                <img
                  src="1200px-Download_on_the_App_Store_Badge.svg.png"
                  width="20%"
                  height="70%"
                />
              </a>
              <a
                href="https://play.google.com/store/apps/details?id=com.one.harmonyhub"
                target="_blank"
              >
                <img src="en_badge_web_generic.png" width="20%" height="100%" />
              </a>
            </div>
          </div>
          <Divider />
          <div style={{ display: 'flex', height: '100%' }}>
            <div style={{ width: '20%', overflow: 'scroll' }}>
              <br />
              <br />
              <Twitter />
            </div>
            <Navigation />

            <div>
              <iframe
                id="tgw_5fff3a4583ba882b538b4569"
                frameborder="0"
                scrolling="no"
                horizontalscrolling="no"
                verticalscrolling="no"
                width="100%"
                height="100%"
                async
                src="https://tgwidget.com/widget/?id=5fff3a4583ba882b538b4569"
              ></iframe>
            </div>
          </div>{' '}
        </>
      )}
      {!mobile && (
        <>
          <div
            style={{
              display: 'flex',
              flexDirection: 'column',
              justifyContent: 'center',
            }}
          >
            <br />
            <br />
            <br />
            <div>
              <a
                href="https://apps.apple.com/us/app/harmony-hub-app/id1526055095"
                target="_blank"
              >
                <img
                  src="1200px-Download_on_the_App_Store_Badge.svg.png"
                  width="70%"
                  height="70%"
                />
              </a>
            </div>
            <div>
              <a
                href="https://play.google.com/store/apps/details?id=com.one.harmonyhub"
                target="_blank"
              >
                <img src="en_badge_web_generic.png" width="80%" height="100%" />
              </a>
            </div>
          </div>
        </>
      )}
    </div>
  );
}

export default App;
