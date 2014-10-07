'use strict';

var Twit = require('twit');

var T = new Twit({
    consumer_key:         'KTJsDCW16m4FmzODN66apbM3s'
  , consumer_secret:      'Q0MYQEMRoRei7MtRf3CDAFeBy0nxKLIvzhVvHFjrB5YKHXi2UC'
  , access_token:         '322847841-mBxkxDQBoFj7wYDsGmu8GPGQiC2fRT9xP4cGbaWv'
  , access_token_secret:  'boDX6qJw4SIOnwBUqDJ2aIwt2mcb1L3tGXx0UgASlT6mT'
});

T.get('search/tweets', { q: 'banana since:2011-11-11', count: 100 }, function(err, data, response) {
  console.log(data);
});
