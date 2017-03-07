import request from 'superagent';
import axios from 'axios';

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
  getScoreAsync: async function(text) {
    const requestScore = await axios.get('/api/afinn', {
      params: {
        text: sluglify(text)
      }
    });
    const {data} = await Promise.resolve(requestScore);
    return data
  },
  searchTwits: async function(search) {
    const requestTweets = await axios.get('/api/twitter', {
      params: {
        search: search
      }
    });
    const {data} = await Promise.resolve(requestTweets);
    const tweets = data.map((tweet) => (
      Object.assign(tweet, {url: `https://twitter.com/${tweet.user.screen_name}/status/${tweet.id_str}`})
    ));
    return tweets;
  },
  getTweetHtml: async function(url) {
    const requestTweet = await axios.get('/api/twitter/' + encodeURIComponent(url));
    const {data} = await Promise.resolve(requestTweet);
    const response = JSON.parse(data.body);
    const index = response.html.indexOf('<script');
    const html = response.html.slice(0, index);
    return html;
  }
};

const sluglify = text => text.replace(/ /g, '-').replace(/[^\w\s!?-]/g,'');

