import React, { useState, useEffect } from 'react';
import Card from './card';
import axios from 'axios';
import CircularProgress from '@material-ui/core/CircularProgress';

export default function TwitterWrapper() {
  const [Youtube, updateYoutube] = useState([]);
  const [loader, setLoader] = useState(true);

  useEffect(() => {
    const init = async () => {
      const result = await axios.get(
        'https://www.googleapis.com/youtube/v3/search?key=AIzaSyCYMCMmAMeTZ-Et0txHOj-3bU0G0ATRbMc&channelId=UCDfuhS7xu69IhK5AJSyiF0g&part=snippet,id&order=date&maxResults=20'
      );
      const data = result.data.items;
      updateYoutube(data);
      setLoader(false);
      console.log(data);
    };
    setLoader(true);
    init();
  }, []);

  return (
    <div className="mediumWrap">
      {loader && <CircularProgress />}
      {!loader &&
        Youtube.length > 0 &&
        Youtube.map((value, index) => {
          return <Card state={value} />;
        })}
    </div>
  );
}
