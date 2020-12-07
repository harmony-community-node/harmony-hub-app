import React, { memo, useEffect, useState } from 'react';
import Card from './card';
import axios from 'axios';
import firebase from '../../firebase';
import Grid from '@material-ui/core/Grid';
import { makeStyles } from '@material-ui/core/styles';
import Paper from '@material-ui/core/Paper';

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
  },
  paper: {
    textAlign: 'center',
    color: theme.palette.text.secondary,
  },
}));

export default function CardWrapper() {
  //     Feed.load('https://medium.com/feed/@gupadhyaya', function(err, rss){
  //     console.log(JSON.stringify(rss, null, 3));
  // });

  const classes = useStyles();
  const [posts, updatePosts] = useState([]);

  useEffect(() => {
    const fetch = async () => {
      const list = await firebase
        .firestore()
        .collection('medium_accounts')
        .get();
      const final = list.docs.map(async (value) => {
        const memory = value.data();
        return new Promise((resolve, reject) => {
          const data = axios({
            url: 'https://api.rss2json.com/v1/api.json',
            method: 'GET',
            dataType: 'json',
            params: {
              rss_url: `https://medium.com/feed/@${memory.handle}`,
              api_key: 'y4dwd67lyurloc6qcmhyeagshi6xqpk9uveembgu',
              count: 2,
            },
          });
          resolve(data);
        });
      });
      const finall = await Promise.all(final);
      updatePosts(finall);
    };
    fetch();
  }, []);

  return (
    <div className="mediumWrap">
      <Grid container spacing={3}>
        {posts.length > 0 &&
          posts.map((value, index) => {
            const individual = value.data.items;
            return individual.map((value, index) => {
              return (
                <Grid item xs={3}>
                  <Paper className={classes.paper}>
                    <Card key={index} post={value} />{' '}
                  </Paper>
                </Grid>
              );
            });
          })}
      </Grid>
    </div>
  );
}
