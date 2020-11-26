import React, { useEffect } from 'react';

export default function MediaCard({ tweets }) {
  console.log(tweets);

  useEffect(() => {
    window.twttr.widgets.load();
  });
  return (
    <>
      <div className="grid">
        {tweets.map((value, index) => {
          console.log(value.url);
          return (
            <blockquote
              className="twitter-tweet"
              data-conversation="none"
              data-width="300"
            >
              <p lang="und" dir="ltr">
                <a href={`${value.url}?ref_src=twsrc%5Etfw`}>
                  {value.userName}
                </a>
              </p>
              &mdash;
            </blockquote>
          );
        })}
      </div>
    </>
  );
}
