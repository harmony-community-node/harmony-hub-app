import React, { useState } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';

const useStyles = makeStyles({
  root: {
    maxWidth: 370,
  },
  media: {
    height: 60,
    width: 60,
  },
});

// GET https://api.twitter.com/1.1/statuses/show.json?id=1332158601465458688&tim_user=true&include_entities=false

export default function MediaCard({ state }) {
  const classes = useStyles();
  return (
    <Card className={classes.root}>
      <a href={state.url} className="anchor" target="_blank">
        <CardActionArea>
          <div style={{ display: 'flex', justifyContent: 'space-around' }}>
            <CardMedia
              data-sizes="auto"
              data-src={state.profilePicUrl}
              className={classes.media}
              image={state.profilePicUrl}
              title="Contemplative Reptile"
              component="img"
            />
            <div>
              <Typography gutterBottom variant="h6" component="h3">
                {state.userName}
              </Typography>
              <br />
              <Typography gutterBottom variant="body2" component="h6">
                @{state.userId} {state.created_at}
              </Typography>
            </div>
          </div>
          <CardContent>
            <Typography variant="body2" color="textSecondary" component="p">
              {state.tweetText}
            </Typography>
          </CardContent>
        </CardActionArea>
      </a>
    </Card>
  );
}
