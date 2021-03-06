import React from 'react';
const tagToText = (node) => {
  let tag = document.createElement('div');
  tag.innerHTML = node;
  node = tag.innerText;
  return node;
};
const shortenText = (text, startingPoint, maxLength) => {
  return text.length > maxLength ? text.slice(startingPoint, maxLength) : text;
};
function Card(props) {
  return (
    <div className="cardHolder">
      <div className="card">
        <img
          src={props.post.thumbnail}
          className="card-img-top post-thumbnail"
          onError={(e) =>
            (e.target.src =
              'https://cdn-images-1.medium.com/max/483/1*hazuDJPEx9w1g7olSrbt8g@2x.png')
          }
          alt={props.post.title}
        ></img>
        <div className="card-body">
          <h5 className="card-title post-title">
            {props.post.title.replace('&amp;', '&')}
          </h5>
          <p className="card-text post-preview">
            {'...' +
              shortenText(tagToText(props.post.content), 60, 200) +
              '...'}
          </p>
          <a href={props.post.link} className="btn btn-link-grey">
            Read this article on Medium.com
          </a>
        </div>
      </div>
    </div>
  );
}
export default Card;
