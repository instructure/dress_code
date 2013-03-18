;(function() {
  var items = document.querySelectorAll('#nav a');
  var docs = document.getElementById('docs');
  var articles = [].slice.call(docs.querySelectorAll('article'), 0);
  var tops;

  var setTops = function() {
    tops = articles.map(function(header) {
      return header.offsetTop;
    });
    setTimeout(setTops, 1000);
  };

  var setAnchor = function() {
    var top = docs.scrollTop + (docs.offsetHeight / 2);
    var inView;
    for (var i = 0; i < tops.length; i += 1) {
      if (tops[i] >= top) break;
    }
    setCurrent(i - 1);
  };

  var setCurrent = (function() {
    var current;
    return function(index) {
      var item = items[index];
      if (current) current.setAttribute('class', '');
      item.setAttribute('class', 'active');
      current = item;
      var article = articles[index];
      var id = article.getAttribute('id');
      article.setAttribute('id', '');
      location.hash = item.hash
      article.setAttribute('id', id);
    }
  })();

  var throttle = function(func, wait) {
    var context, args, timeout, throttling, more;
    var whenDone = debounce(function(){ more = throttling = false; }, wait);
    return function() {
      context = this; args = arguments;
      var later = function() {
        timeout = null;
        if (more) func.apply(context, args);
        whenDone();
      };
      if (!timeout) timeout = setTimeout(later, wait);
      if (throttling) {
        more = true;
      } else {
        func.apply(context, args);
      }
      whenDone();
      throttling = true;
    };
  };

  var debounce = function(func, wait) {
    var timeout;
    return function() {
      var context = this, args = arguments;
      var later = function() {
        timeout = null;
        func.apply(context, args);
      };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  };

  setTops();
  docs.addEventListener('scroll', throttle(setAnchor, 100));

})();

