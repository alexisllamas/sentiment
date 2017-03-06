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
  }
};

const sluglify = text => text.replace(/ /g, '-');
