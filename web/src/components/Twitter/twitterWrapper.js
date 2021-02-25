import React, { useState, useEffect } from 'react';
import Card from './card';
import firebase from '../../firebase';
import axios from 'axios';
import CircularProgress from '@material-ui/core/CircularProgress';
import moment from 'moment-js';

export default function TwitterWrapper() {
  const [Tweets, updateTweets] = useState([]);
  const [loader, setLoader] = useState(true);

  const TwitterIds = async () => {
    setLoader(true);
    const data = await axios.get(`${process.env.REACT_APP_BACKEND}/twitter`);

    console.log(data);
    let dataFinal = [...data.data.data, ...data.data.data2]
      // .filter((value) => {
      //   if (value.in_reply_to_status_id === null) {
      //     return true;
      //   } else {
      //     return false;
      //   }
      // })
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
      })
      .sort((a, b) => {
        return new Date(b.created_at) - new Date(a.created_at);
      });
    updateTweets(dataFinal);
    setLoader(false);
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
