import React from 'react';

export default function MediaCard({ tweets }) {
  console.log(tweets);
  return (
    <>
      {tweets.map((value, index) => {
        console.log(value.url);
        return (
          <blockquote className="twitter-tweet" data-conversation="none">
            <p lang="und" dir="ltr">
              <a href={`${value.url}?ref_src=twsrc%5Etfw`}>{value.url}</a>
            </p>
            &mdash; Rachit Anand (@RacSri25){' '}
            <a href={`${value.url}?ref_src=twsrc%5Etfw`}>November 24, 2020</a>
          </blockquote>
        );
      })}

      <blockquote className="twitter-tweet" data-conversation="none">
        <p lang="und" dir="ltr">
          <a href="https://twitter.com/leo_hao/status/1331439239586672640?ref_src=twsrc%5Etfw">
            https://twitter.com/leo_hao/status/1331439239586672640?ref_src=twsrc%5Etfw
          </a>
        </p>
        &mdash; Rachit Anand (@RacSri25){' '}
        <a href="https://twitter.com/leo_hao/status/1331439239586672640?ref_src=twsrc%5Etfw?ref_src=twsrc%5Etfw">
          November 24, 2020
        </a>
      </blockquote>
    </>
  );
}
