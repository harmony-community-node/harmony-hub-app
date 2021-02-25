const express = require('express');
const axios = require('axios');
const firebase = require('./firebase');
require('dotenv').config();
const cors = require('cors');
const app = express();

app.use(cors());

app.use(express.static('public'));

app.get('/twitter', async (req, res) => {
  firebase
    .firestore()
    .collection('twitter_accounts')
    .onSnapshot(async (snapshot) => {
      let query = 'q=';
      snapshot.docs.forEach(async (doc, idx, array) => {
        let items = doc.data();
        if (items.name === '$ONE') {
          // query += `from:harmony ONE OR ONE`;
        } else {
          if (idx === array.length - 1) {
            query += `from:${items.handle}`;
          } else {
            query += `from:${items.handle}+OR+`;
          }
        }
      });

      let data = await axios({
        url: `https://api.twitter.com/1.1/search/tweets.json?${query}  AND -filter:retweets AND -filter:replies&count=800&result_type=recent&exclude_replies=true`,
        headers: {
          Authorization: `Bearer ${process.env.REACT_APP_BEARERKEY}`,
        },
      });

      let data2 = await axios({
        url: `https://api.twitter.com/1.1/search/tweets.json?q=harmony $ONE OR #ONE&count=50&result_type=recent&exclude_replies=true`,
        headers: {
          Authorization: `Bearer ${process.env.REACT_APP_BEARERKEY}`,
        },
      });

      res.send({
        data: data.data.statuses,
        data2: data2.data.statuses,
      });
    });
});

app.listen(4500);
