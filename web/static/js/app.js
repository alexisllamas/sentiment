// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import 'phoenix_html'
import 'purecss'

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import Vue from 'vue';
import api from './api';

const app = new Vue({
  el: '#app',
  data: {
    message: '',
    score: '',
    search: '',
    comparative: '',
    showScore: false,
    html: '',
    scoreTweets: [],
    showStats: false,
    positiveTweets: 0,
    negativeTweets: 0,
    totalScore: 0,
    average: 0,
    tweets: []
  },
  methods: {
    getScore: function (event) {
      if (event) event.preventDefault()
      api.getScore(this.message).then(({score, comparative}) => {
        this.score = score;
        this.comparative = comparative;
        this.showScore = true;
      });
    },
    allTweets: function() {
      if (event) event.preventDefault()
      this.html = this.tweets.map(tweet => tweet.tweetHtml).join('');
    },
    negativeTweets: function() {
      this.html = this.tweets.filter(tweet => tweet.score < 0).map(tweet => tweet.tweetHtml).join('');
    },
    positiveTweets: function() {
      this.html = this.tweets.filter(tweet => tweet.score > 0).map(tweet => tweet.tweetHtml).join('');
    },
    searchTwits: async function() {
      const {twttr} = window;
      this.html = '';
      this.showStats = false;
      this.tweets = [];
      if (event) event.preventDefault();
      const tweets = await api.searchTwits(this.search);
      let scoreTweets = [];
      let tweetsArray = [];
      const self = this;
      const getCal = (score) => score > 0 ? 'positive <i class="fa fa-thumbs-up" aria-hidden="true"></i>' : (score < 0 ? 'negative <i class="fa fa-thumbs-down" aria-hidden="true"></i>' : 'neutro');
      const promises = tweets.map((tweet) => (
        new Promise(async function(resolve, reject) {
          const tweetResponse = await api.getTweetHtml(tweet.url);
          const {score} = await api.getScoreAsync(tweet.text);
          scoreTweets = [...scoreTweets, score];
          const html = `<div class="pure-g">
            <div class="pure-u-2-3">${tweetResponse}</div>
            <div class="pure-u-1-3">
              <p>Score: ${score}</p>
              <p>${getCal(score)}</p>
            </div>
          </div>`;
          tweetsArray = [...tweetsArray, {
            tweetHtml: html,
            score: score
          }];
          self.html = self.html + html;
          resolve();
        })
      ));
      const responses = await Promise.all(promises);
      this.positiveTweets = scoreTweets.filter(score => score > 0).length;
      this.negativeTweets = scoreTweets.filter(score => score < 0).length;
      this.totalScore = scoreTweets.reduce((prev, next) => prev + next, 0);
      this.average = this.totalScore / scoreTweets.length;
      this.showStats = true;
      twttr.widgets.load();
    }
  }
});
