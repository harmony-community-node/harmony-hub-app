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
    maxWidth: 345,
  },
  media: {
    height: 140,
  },
});

// GET https://api.twitter.com/1.1/statuses/show.json?id=1332158601465458688&tim_user=true&include_entities=false

export default function MediaCard({ state }) {
  const classes = useStyles();
  return (
    <Card className={classes.root}>
      <CardActionArea>
        <CardMedia
          data-sizes="auto"
          data-src={state.profilePicUrl}
          className={classes.media}
          image={state.profilePicUrl}
          title="Contemplative Reptile"
          component="img"
        />
        <CardContent>
          <Typography gutterBottom variant="h5" component="h2">
            {state.userName}
          </Typography>
          <Typography gutterBottom variant="body1" component="h2">
            @{state.userId}
          </Typography>
          <Typography gutterBottom variant="body1" component="h5">
            {state.created_at}
          </Typography>
          <Typography variant="body2" color="textSecondary" component="p">
            {state.tweetText}
          </Typography>
        </CardContent>
      </CardActionArea>
      <CardActions>
        <Button size="small" color="primary">
          <a href={state.url} target="_blank">
            See More
          </a>
        </Button>
      </CardActions>
    </Card>
  );
}
