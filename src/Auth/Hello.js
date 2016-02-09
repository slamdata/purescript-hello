// module Auth.Hello

function credentialsArrayToObject(array) {
  var credentials = {};
  array.forEach(function (obj) {
    credentials[obj.network] = obj.id;
  });

  return credentials;
}

exports._init = function (credentialsArray) {
  return function (options) {
    return function () {
      var credentials = credentialsArrayToObject(credentialsArray);
      return hello.init(credentials, options);
    };
  };
};

exports._login = function (network) {
  return function (options) {
    return function (onSuccess) {
      return function (onError) {
        return function () {
          hello.login(network, options).then(onSuccess, function (err) {
            return onError(new Error(err.error.message))();
          });
        };
      };
    };
  };
};

exports._logout = function (network) {
  return function (options) {
    return function (onSuccess) {
      return function (onError) {
        return function () {
          hello.logout(network, options).then(onSuccess, function (err) {
            return onError(new Error(err.error.message))();
          });
        };
      };
    };
  };
};

exports._getAuthResponse = function (network) {
  return function (nothing) {
    return function (just) {
      return function () {
        var resp = hello.getAuthResponse(network);
        if (resp == null) {
          return nothing;
        } else {
          return just(resp);
        }
      };
    };
  };
};

exports._api = function (network) {
  return function (path) {
    return function (method) {
      return function (request) {
        return function (options) {
          return function (onSuccess) {
            return function (onFailure) {
              return function () {
                hello(network).api(path,method,request,options).then(function (resp) {
                  return onSuccess(resp)();
                }, function (err) {
                  return onError(new Error(err.error.message))();
                });
              };
            };
          };
        };
      };
    };
  };
};

exports._subscribe = function (event) {
  return function (callback) {
    return function () {
      var f = callback;

      hello.on(event, f);
      return { token: f, event: event };
    };
  };
};

exports.unsubscribe = function (subscription) {
  return function () {
    return hello.off(subscription.event, subscription.token);
  };
};
