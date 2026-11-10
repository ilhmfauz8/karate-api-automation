function fn() {
  karate.configure('logging', {
    report: 'debug',
    console: 'trace',
    pretty: true
  });

  function shellQuote(value) {
    return "'" + String(value).replace(/'/g, "'\"'\"'") + "'";
  }

  function toCurl(request, body) {
    var command = 'curl --request ' + request.method + ' ' + shellQuote(request.url);
    var contentTypes = request.headers['Content-Type'];
    var contentType = contentTypes && contentTypes[0];
    var accepts = request.headers['Accept'];
    var accept = accepts && accepts[0];

    if (contentType) {
      command += ' \\\n  --header ' + shellQuote('Content-Type: ' + contentType);
    }
    if (accept) {
      command += ' --header ' + shellQuote('Accept: ' + accept);
    }
    if (body) {
      command += ' \\\n  --data-raw ' + shellQuote(JSON.stringify(body));
    }

    return command;
  }

  return {
    baseUrl: 'https://petstore3.swagger.io/api/v3',
    bookingBaseUrl: 'https://restful-booker.herokuapp.com',
    toCurl: toCurl
  };
}
