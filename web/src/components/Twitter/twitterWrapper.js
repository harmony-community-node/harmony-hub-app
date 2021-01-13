import React, { useState, useEffect } from 'react';
import Card from './card';
import firebase from '../../firebase';
import axios from 'axios';
import CircularProgress from '@material-ui/core/CircularProgress';
import moment from 'moment-js';

export default function TwitterWrapper() {
  const [Tweets, updateTweets] = useState([]);
  const [loader, setLoader] = useState(true);

  const TwitterIds = () => {
    setLoader(true);
    firebase
      .firestore()
      .collection('twitter_accounts')
      .onSnapshot(async (snapshot) => {
        let query = 'q=';
        snapshot.docs.forEach(async (doc, idx, array) => {
          let items = doc.data();
          if (items.name === '$ONE') {
            console.log('fdasjknaskd');
            query += `from:ONE`;
            console.log(query);
          } else {
            if (idx === array.length - 1) {
              query += `from:${items.handle}`;
            } else {
              query += `from:${items.handle}+OR+`;
            }
          }
        });
        const proxyurl = 'https://cors-anywhere.herokuapp.com/';
        let data = await axios({
          url:
            proxyurl +
            `https://api.twitter.com/1.1/search/tweets.json?${query}&count=200&result_type=recent`,
          headers: {
            Authorization: `Bearer ${process.env.REACT_APP_BEARERKEY}`,
          },
        });

        console.log('looks at this', data.data.statuses);
        data = data.data.statuses
          .filter((value) => {
            if (value.in_reply_to_status_id === null) {
              return true;
            } else {
              return false;
            }
          })
          .map((value) => {
            const split = value['created_at'].split(' ');
            const date =
              split[1] +
              ' ' +
              split[2] +
              ' ' +
              split[3].substring(0, 5) +
              ' ' +
              split[5];
            console.log(date);

            const entry = {
              userName: value['user']['name'],
              tweetText: value['text'],
              tweetId: value['id_str'],
              userId: value['user']['screen_name'],
              created_at: date,
              url: `https://twitter.com/${value['user']['screen_name']}/status/${value['id_str']}`,
              profilePicUrl: value['user']['profile_image_url_https'].replace(
                /_normal\./,
                '.'
              ),
            };
            return entry;
          });
        updateTweets(data);
        setLoader(false);
      });
  };

  useEffect(() => {
    TwitterIds();
  }, []);

  console.log(Tweets);
  return (
    <div className="flexTweet">
      {loader && <CircularProgress />}
      {!loader &&
        Tweets.length > 0 &&
        Tweets.map((value, index) => {
          return <Card state={value} />;
        })}
    </div>
  );
}
