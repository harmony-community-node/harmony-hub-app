import React, { useState, useEffect } from 'react';
import Card from './card';
import firebase from '../../firebase';
import axios from 'axios';

export default function TwitterWrapper() {
  const [Tweets, updateTweets] = useState([]);

  const TwitterIds = () => {
    firebase
      .firestore()
      .collection('twitter_accounts')
      .onSnapshot(async (snapshot) => {
        let query = 'q=';
        snapshot.docs.forEach(async (doc, idx, array) => {
          let items = doc.data();
          if (items.name == '$ONE') {
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
            `https://api.twitter.com/1.1/search/tweets.json?${query}&count=50&result_type=recent`,
          headers: {
            Authorization: `Bearer ${process.env.REACT_APP_BEARERKEY}`,
          },
        });
        data = data.data.statuses.map((value) => {
          console.log(value);
          const entry = {
            userName: value['user']['name'],
            tweetText: value['text'],
            tweetId: value['id_str'],
            userId: value['user']['screen_name'],
            created_at: value['created_at'],
            url: `https://twitter.com/${value['user']['screen_name']}/status/${value['id_str']}`,
            profilePicUrl: value['user']['profile_image_url_https'].replace(
              /_normal\./,
              '.'
            ),
          };
          return entry;
        });
        updateTweets(data);
      });
  };

  useEffect(() => {
    TwitterIds();
  }, []);

  console.log(Tweets);
  return (
    <div className="flexTweet">
      {Tweets.length > 0 &&
        Tweets.map((value, index) => {
          return <Card state={value} />;
        })}
    </div>
  );
}
