import request from 'superagent';

export default {
  getScore(text) {
    return new Promise((resolve, reject) => {
      request
        .get('/api/afinn')
        .query({text: sluglify(text)})
        .set('Accept', 'application/json')
        .end((err, {body}) => {
          const {score, comparative} = body;
          const comparativeFormated = comparative ? parseFloat(comparative.toFixed(4)) : 'error';
          resolve({score: score, comparative: comparativeFormated});
        });
    });
  },
  searchTwits(search) {
    return new Promise((resolve, reject) => {
      request
        .get('/api/twitter')
        .query({search: search})
        .set('Accept', 'application/json')
        .end((err, {body}) => {
          const tweets = body.map((tweet) => (
            Object.assign(tweet, {url: `https://twitter.com/${tweet.user.screen_name}/status/${tweet.id_str}`})
          ));
          resolve(tweets);
        });
    });
  },
  getTweetHtml(url) {
    return new Promise((resolve, reject) => {
      request
        .get('api/twitter/' + encodeURIComponent(url))
        .end((err, {body}) => {
          console.log(body);
          resolve(body);
        });
    });
  }
};

const sluglify = text => text.replace(/ /g, '-');
