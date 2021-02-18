(this.webpackJsonpweb = this.webpackJsonpweb || []).push([
  [6],
  {
    208: function (t, e, n) {
      'use strict';
      n.r(e),
        n.d(e, 'default', function () {
          return b;
        });
      var r = n(27),
        a = n.n(r),
        c = n(43),
        s = n(22),
        o = n(4),
        i = n(2),
        u = function (t) {
          var e = document.createElement('div');
          return (e.innerHTML = t), (t = e.innerText);
        };
      var l = function (t) {
          return Object(o.jsx)('div', {
            className: 'cardHolder',
            children: Object(o.jsxs)('div', {
              className: 'card',
              children: [
                Object(o.jsx)('img', {
                  src: t.post.thumbnail,
                  className: 'card-img-top post-thumbnail',
                  onError: function (t) {
                    return (t.target.src =
                      'https://cdn-images-1.medium.com/max/483/1*hazuDJPEx9w1g7olSrbt8g@2x.png');
                  },
                  alt: t.post.title,
                }),
                Object(o.jsxs)('div', {
                  className: 'card-body',
                  children: [
                    Object(o.jsx)('h5', {
                      className: 'card-title post-title',
                      children: t.post.title.replace('&amp;', '&'),
                    }),
                    Object(o.jsx)('p', {
                      className: 'card-text post-preview',
                      children:
                        '...' +
                        ((e = u(t.post.content)),
                        (n = 60),
                        (r = 200),
                        (e.length > r ? e.slice(n, r) : e) + '...'),
                    }),
                    Object(o.jsx)('a', {
                      href: t.post.link,
                      className: 'btn btn-link-grey',
                      children: 'Read this article on Medium.com',
                    }),
                  ],
                }),
              ],
            }),
          });
          var e, n, r;
        },
        p = n(47),
        d = n.n(p),
        m = n(44),
        f = n(144),
        h = Object(f.a)(function (t) {
          return {
            root: { flexGrow: 1 },
            paper: { textAlign: 'center', color: t.palette.text.secondary },
          };
        });
      function b() {
        h();
        var t = Object(i.useState)([]),
          e = Object(s.a)(t, 2),
          n = e[0],
          r = e[1];
        return (
          Object(i.useEffect)(function () {
            (function () {
              var t = Object(c.a)(
                a.a.mark(function t() {
                  var e, n, s, o, i;
                  return a.a.wrap(function (t) {
                    for (;;)
                      switch ((t.prev = t.next)) {
                        case 0:
                          return (
                            (t.next = 2),
                            m.a.firestore().collection('medium_accounts').get()
                          );
                        case 2:
                          return (
                            (e = t.sent),
                            (n = e.docs.map(
                              (function () {
                                var t = Object(c.a)(
                                  a.a.mark(function t(e) {
                                    var n;
                                    return a.a.wrap(function (t) {
                                      for (;;)
                                        switch ((t.prev = t.next)) {
                                          case 0:
                                            return (
                                              (n = e.data()),
                                              t.abrupt(
                                                'return',
                                                new Promise(function (t, e) {
                                                  try {
                                                    t(
                                                      d()({
                                                        url:
                                                          'https://api.rss2json.com/v1/api.json',
                                                        method: 'GET',
                                                        dataType: 'json',
                                                        params: {
                                                          rss_url: 'https://medium.com/feed/@'.concat(
                                                            n.handle
                                                          ),
                                                          api_key:
                                                            'y4dwd67lyurloc6qcmhyeagshi6xqpk9uveembgu',
                                                          count: 4,
                                                        },
                                                      })
                                                    );
                                                  } catch (r) {
                                                    e(r);
                                                  }
                                                })
                                              )
                                            );
                                          case 2:
                                          case 'end':
                                            return t.stop();
                                        }
                                    }, t);
                                  })
                                );
                                return function (e) {
                                  return t.apply(this, arguments);
                                };
                              })()
                            )),
                            (t.next = 6),
                            Promise.allSettled(n)
                          );
                        case 6:
                          (s = t.sent),
                            (o = s
                              .filter(function (t) {
                                return console.log(t), 'fulfilled' === t.status;
                              })
                              .map(function (t) {
                                return t.value.data.items;
                              })),
                            (i = [].concat.apply([], o)),
                            console.log(i),
                            i.sort(function (t, e) {
                              return new Date(e.pubDate) - new Date(t.pubDate);
                            }),
                            r(i);
                        case 12:
                        case 'end':
                          return t.stop();
                      }
                  }, t);
                })
              );
              return function () {
                return t.apply(this, arguments);
              };
            })()();
          }, []),
          Object(o.jsx)('div', {
            className: 'mediumWrap',
            children:
              n.length > 0 &&
              n.map(function (t, e) {
                return Object(o.jsx)(l, { width: 200, post: t }, e);
              }),
          })
        );
      }
    },
  },
]);
//# sourceMappingURL=6.20a4450b.chunk.js.map
