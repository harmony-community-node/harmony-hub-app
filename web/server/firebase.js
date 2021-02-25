const firebase = require('firebase');

var firebaseConfig = {
  apiKey: 'xxxxxxxxxxxxxx',
  authDomain: 'harmonyhubapp-c0044.firebaseapp.com',
  databaseURL: 'https://harmonyhubapp-c0044.firebaseio.com',
  projectId: 'harmonyhubapp-c0044',
  storageBucket: 'harmonyhubapp-c0044.appspot.com',
  messagingSenderId: 'xxxxxxx',
  appId: 'xxxxxxxx',
  measurementId: 'xxxxx',
};

firebase.initializeApp(firebaseConfig);

firebase
  .firestore()
  .enablePersistence()
  .catch((err) => {
    if (err.code === 'failed-precondition') {
      console.log('presistance failed');
    } else if (err.code == 'unimplemented') {
      console.log('persistance is not availaible');
    }
  });

module.exports = firebase;
