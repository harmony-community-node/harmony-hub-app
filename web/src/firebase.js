import firebase from 'firebase';

var firebaseConfig = {
  apiKey: 'AIzaSyBbwiU1hnRpaWmviOtfUDMa7uAd_LSFBic',
  authDomain: 'harmonyhubapp-c0044.firebaseapp.com',
  databaseURL: 'https://harmonyhubapp-c0044.firebaseio.com',
  projectId: 'harmonyhubapp-c0044',
  storageBucket: 'harmonyhubapp-c0044.appspot.com',
  messagingSenderId: '4920664565',
  appId: '1:4920664565:web:26ddf5aaddc945798980bc',
  measurementId: 'G-5Y68PLJ67R',
};

firebase.initializeApp(firebaseConfig);
firebase.analytics();

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

export default firebase;
