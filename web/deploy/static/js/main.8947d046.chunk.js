(this.webpackJsonpweb = this.webpackJsonpweb || []).push([
  [0],
  {
    116: function (e, t, a) {
      'use strict';
      a.r(t);
      var n = a(4),
        c = a(2),
        r = a.n(c),
        s = a(24),
        i = a.n(s),
        o = (a(89), a(22)),
        l = (a(90), a(23)),
        d = a(71),
        j = a(144),
        b = a(145),
        h = a(153),
        u = a(146),
        p = a(143),
        O = a(152),
        x = a(67),
        f = a.n(x),
        m = a(141);
      function g() {
        return Object(n.jsx)('div', {
          className: 'loaderHar',
          children: Object(n.jsx)(m.a, { color: 'secondary' }),
        });
      }
      var A = Object(c.lazy)(function () {
          return a.e(6).then(a.bind(null, 208));
        }),
        v = Object(c.lazy)(function () {
          return Promise.all([a.e(3), a.e(4)]).then(a.bind(null, 209));
        }),
        w = Object(c.lazy)(function () {
          return a.e(5).then(a.bind(null, 205));
        }),
        y = Object(c.lazy)(function () {
          return a.e(7).then(a.bind(null, 210));
        });
      function _(e) {
        var t = e.children,
          a = e.value,
          c = e.index,
          r = Object(d.a)(e, ['children', 'value', 'index']);
        return Object(n.jsx)(
          'div',
          Object(l.a)(
            Object(l.a)(
              {
                role: 'tabpanel',
                hidden: a !== c,
                id: 'simple-tabpanel-'.concat(c),
                'aria-labelledby': 'simple-tab-'.concat(c),
              },
              r
            ),
            {},
            {
              children:
                a === c &&
                Object(n.jsx)(O.a, {
                  p: 3,
                  children: Object(n.jsx)(p.a, { children: t }),
                }),
            }
          )
        );
      }
      function S(e) {
        return {
          id: 'simple-tab-'.concat(e),
          'aria-controls': 'simple-tabpanel-'.concat(e),
        };
      }
      var k = Object(j.a)(function (e) {
        return {
          root: {
            flexGrow: 1,
            backgroundColor: '#fff',
            width: '100px',
            overflow: 'scroll',
          },
        };
      });
      function z() {
        var e = k(),
          t = r.a.useState(0),
          a = Object(o.a)(t, 2),
          s = a[0],
          i = a[1],
          d = (new Date(), f.a.renderToStaticMarkup(Object(n.jsx)(g, {})));
        return (
          console.log(d),
          Object(n.jsxs)('div', {
            className: e.root,
            children: [
              Object(n.jsx)(b.a, {
                position: 'static',
                children: Object(n.jsxs)(h.a, {
                  value: s,
                  onChange: function (e, t) {
                    i(t);
                  },
                  'aria-label': 'simple tabs example',
                  variant: 'fullWidth',
                  children: [
                    Object(n.jsx)(
                      u.a,
                      Object(l.a)({ label: 'Calendar' }, S(0))
                    ),
                    Object(n.jsx)(
                      u.a,
                      Object(l.a)({ label: 'Articles' }, S(1))
                    ),
                    Object(n.jsx)(u.a, Object(l.a)({ label: 'Youtube' }, S(2))),
                    Object(n.jsx)(
                      u.a,
                      Object(l.a)({ label: 'Harmony Links' }, S(3))
                    ),
                  ],
                }),
              }),
              Object(n.jsx)(_, {
                value: s,
                index: 0,
                children: Object(n.jsx)(c.Suspense, {
                  fallback: Object(n.jsx)('div', {
                    dangerouslySetInnerHTML: { __html: d },
                  }),
                  children: Object(n.jsx)(v, {}),
                }),
              }),
              Object(n.jsx)(_, {
                value: s,
                index: 1,
                children: Object(n.jsx)(c.Suspense, {
                  fallback: Object(n.jsx)('div', {
                    dangerouslySetInnerHTML: { __html: d },
                  }),
                  children: Object(n.jsx)(A, {}),
                }),
              }),
              Object(n.jsx)(_, {
                value: s,
                index: 2,
                children: Object(n.jsx)(c.Suspense, {
                  fallback: Object(n.jsx)('div', {
                    dangerouslySetInnerHTML: { __html: d },
                  }),
                  children: Object(n.jsx)(y, {}),
                }),
              }),
              Object(n.jsx)(_, {
                value: s,
                index: 3,
                children: Object(n.jsx)(c.Suspense, {
                  fallback: Object(n.jsx)('div', {
                    dangerouslySetInnerHTML: { __html: d },
                  }),
                  children: Object(n.jsx)(w, {}),
                }),
              }),
            ],
          })
        );
      }
      var D = a(50),
        N = a(27),
        I = a.n(N),
        C = a(43),
        E = a(147),
        T = a(148),
        L = a(150),
        B = a(149),
        U = Object(j.a)({
          root: { maxWidth: 370 },
          media: { height: 60, width: 60 },
        });
      function J(e) {
        var t = e.state,
          a = U();
        return Object(n.jsx)(E.a, {
          className: a.root,
          children: Object(n.jsx)('a', {
            href: t.url,
            className: 'anchor',
            target: '_blank',
            children: Object(n.jsxs)(T.a, {
              children: [
                Object(n.jsxs)('div', {
                  style: { display: 'flex', justifyContent: 'space-around' },
                  children: [
                    Object(n.jsx)(B.a, {
                      'data-sizes': 'auto',
                      'data-src': t.profilePicUrl,
                      className: a.media,
                      image: t.profilePicUrl,
                      title: 'Contemplative Reptile',
                      component: 'img',
                    }),
                    Object(n.jsxs)('div', {
                      children: [
                        Object(n.jsxs)(p.a, {
                          gutterBottom: !0,
                          variant: 'h6',
                          component: 'h3',
                          children: ['@', t.userId],
                        }),
                        Object(n.jsx)(p.a, {
                          gutterBottom: !0,
                          variant: 'body2',
                          component: 'h6',
                          children: t.created_at,
                        }),
                      ],
                    }),
                  ],
                }),
                Object(n.jsx)(L.a, {
                  children: Object(n.jsx)(p.a, {
                    variant: 'body2',
                    color: 'textSecondary',
                    component: 'p',
                    children: t.tweetText,
                  }),
                }),
              ],
            }),
          }),
        });
      }
      var M = a(44),
        q = a(47),
        G = a.n(q);
      a(115);
      function P() {
        var e = Object(c.useState)([]),
          t = Object(o.a)(e, 2),
          a = t[0],
          r = t[1],
          s = Object(c.useState)(!0),
          i = Object(o.a)(s, 2),
          l = i[0],
          d = i[1];
        return (
          Object(c.useEffect)(function () {
            d(!0),
              M.a
                .firestore()
                .collection('twitter_accounts')
                .onSnapshot(
                  (function () {
                    var e = Object(C.a)(
                      I.a.mark(function e(t) {
                        var a, n, c, s;
                        return I.a.wrap(function (e) {
                          for (;;)
                            switch ((e.prev = e.next)) {
                              case 0:
                                return (
                                  (a = 'q='),
                                  t.docs.forEach(
                                    (function () {
                                      var e = Object(C.a)(
                                        I.a.mark(function e(t, n, c) {
                                          var r;
                                          return I.a.wrap(function (e) {
                                            for (;;)
                                              switch ((e.prev = e.next)) {
                                                case 0:
                                                  '$ONE' === (r = t.data()).name
                                                    ? console.log(a)
                                                    : n === c.length - 1
                                                    ? (a += 'from:'.concat(
                                                        r.handle
                                                      ))
                                                    : (a += 'from:'.concat(
                                                        r.handle,
                                                        '+OR+'
                                                      ));
                                                case 2:
                                                case 'end':
                                                  return e.stop();
                                              }
                                          }, e);
                                        })
                                      );
                                      return function (t, a, n) {
                                        return e.apply(this, arguments);
                                      };
                                    })()
                                  ),
                                  (n = 'https://cors-anywhere.herokuapp.com/'),
                                  (e.next = 5),
                                  G()({
                                    url:
                                      n +
                                      'https://api.twitter.com/1.1/search/tweets.json?'.concat(
                                        a,
                                        '  AND -filter:retweets AND -filter:replies&count=800&result_type=recent&exclude_replies=true'
                                      ),
                                    headers: {
                                      Authorization: 'Bearer '.concat(
                                        'AAAAAAAAAAAAAAAAAAAAADNaKAEAAAAAlryqzmOSe8gTVsEt7cWzEzJrUnw%3DGXEMW8QU2ACiS7wIJ6tS9kDsQQGakZezAJdaRqCfTqbYfwKGNL'
                                      ),
                                    },
                                  })
                                );
                              case 5:
                                return (
                                  (c = e.sent),
                                  (e.next = 8),
                                  G()({
                                    url:
                                      n +
                                      'https://api.twitter.com/1.1/search/tweets.json?q=harmony $ONE OR #ONE&count=50&result_type=recent&exclude_replies=true',
                                    headers: {
                                      Authorization: 'Bearer '.concat(
                                        'AAAAAAAAAAAAAAAAAAAAADNaKAEAAAAAlryqzmOSe8gTVsEt7cWzEzJrUnw%3DGXEMW8QU2ACiS7wIJ6tS9kDsQQGakZezAJdaRqCfTqbYfwKGNL'
                                      ),
                                    },
                                  })
                                );
                              case 8:
                                (s = e.sent),
                                  console.log(s),
                                  console.log('looks at this', c.data.statuses),
                                  (c = []
                                    .concat(
                                      Object(D.a)(c.data.statuses),
                                      Object(D.a)(s.data.statuses)
                                    )
                                    .map(function (e) {
                                      var t = e.created_at.split(' '),
                                        a =
                                          t[1] +
                                          ' ' +
                                          t[2] +
                                          ' ' +
                                          t[3].substring(0, 5) +
                                          ' ' +
                                          t[5];
                                      return (
                                        console.log(a),
                                        {
                                          userName: e.user.name,
                                          tweetText: e.text,
                                          tweetId: e.id_str,
                                          userId: e.user.screen_name,
                                          created_at: a,
                                          url: 'https://twitter.com/'
                                            .concat(
                                              e.user.screen_name,
                                              '/status/'
                                            )
                                            .concat(e.id_str),
                                          profilePicUrl: e.user.profile_image_url_https.replace(
                                            /_normal\./,
                                            '.'
                                          ),
                                        }
                                      );
                                    })
                                    .sort(function (e, t) {
                                      return (
                                        new Date(t.created_at) -
                                        new Date(e.created_at)
                                      );
                                    })),
                                  r(c),
                                  d(!1);
                              case 14:
                              case 'end':
                                return e.stop();
                            }
                        }, e);
                      })
                    );
                    return function (t) {
                      return e.apply(this, arguments);
                    };
                  })()
                );
          }, []),
          console.log(a),
          Object(n.jsxs)('div', {
            className: 'flexTweet',
            children: [
              l && Object(n.jsx)(m.a, {}),
              !l &&
                a.length > 0 &&
                a.map(function (e, t) {
                  return Object(n.jsx)(J, { state: e });
                }),
            ],
          })
        );
      }
      var R = a(151);
      var W = function () {
          var e = Object(c.useState)(window.innerWidth > window.innerHeight),
            t = Object(o.a)(e, 2),
            a = t[0];
          return (
            t[1],
            console.log(a, window.width, window.height),
            Object(n.jsxs)('div', {
              className: 'App',
              style: { height: '100vh', overflow: 'scroll' },
              children: [
                a &&
                  Object(n.jsxs)(n.Fragment, {
                    children: [
                      Object(n.jsxs)('div', {
                        style: {
                          display: 'flex',
                          justifyContent: 'space-around',
                        },
                        children: [
                          Object(n.jsx)('div', {
                            children: Object(n.jsx)('img', {
                              src: 'harmony-logo-horizontal-ful-color.svg',
                              width: '50%',
                              height: '100%',
                            }),
                          }),
                          Object(n.jsx)(R.a, { orientation: 'vertical' }),
                          Object(n.jsxs)('div', {
                            children: [
                              ' ',
                              Object(n.jsx)('a', {
                                href:
                                  'https://apps.apple.com/us/app/harmony-hub-app/id1526055095',
                                target: '_blank',
                                children: Object(n.jsx)('img', {
                                  src:
                                    '1200px-Download_on_the_App_Store_Badge.svg.png',
                                  width: '20%',
                                  height: '70%',
                                }),
                              }),
                              Object(n.jsx)('a', {
                                href:
                                  'https://play.google.com/store/apps/details?id=com.one.harmonyhub',
                                target: '_blank',
                                children: Object(n.jsx)('img', {
                                  src: 'en_badge_web_generic.png',
                                  width: '20%',
                                  height: '100%',
                                }),
                              }),
                            ],
                          }),
                        ],
                      }),
                      Object(n.jsx)(R.a, {}),
                      Object(n.jsxs)('div', {
                        style: { display: 'flex', height: '100%' },
                        children: [
                          Object(n.jsxs)('div', {
                            style: { width: '20%', overflow: 'scroll' },
                            children: [
                              Object(n.jsx)('br', {}),
                              Object(n.jsx)('br', {}),
                              Object(n.jsx)(P, {}),
                            ],
                          }),
                          Object(n.jsx)(z, {}),
                          Object(n.jsx)('div', {
                            children: Object(n.jsx)('iframe', {
                              id: 'tgw_5fff3a4583ba882b538b4569',
                              frameborder: '0',
                              scrolling: 'no',
                              horizontalscrolling: 'no',
                              verticalscrolling: 'no',
                              width: '100%',
                              height: '100%',
                              async: !0,
                              src:
                                'https://tgwidget.com/widget/?id=5fff3a4583ba882b538b4569',
                            }),
                          }),
                        ],
                      }),
                      ' ',
                    ],
                  }),
                !a &&
                  Object(n.jsx)(n.Fragment, {
                    children: Object(n.jsxs)('div', {
                      style: {
                        display: 'flex',
                        flexDirection: 'column',
                        justifyContent: 'center',
                      },
                      children: [
                        Object(n.jsx)('br', {}),
                        Object(n.jsx)('br', {}),
                        Object(n.jsx)('br', {}),
                        Object(n.jsx)('div', {
                          children: Object(n.jsx)('a', {
                            href:
                              'https://apps.apple.com/us/app/harmony-hub-app/id1526055095',
                            target: '_blank',
                            children: Object(n.jsx)('img', {
                              src:
                                '1200px-Download_on_the_App_Store_Badge.svg.png',
                              width: '70%',
                              height: '70%',
                            }),
                          }),
                        }),
                        Object(n.jsx)('div', {
                          children: Object(n.jsx)('a', {
                            href:
                              'https://play.google.com/store/apps/details?id=com.one.harmonyhub',
                            target: '_blank',
                            children: Object(n.jsx)('img', {
                              src: 'en_badge_web_generic.png',
                              width: '80%',
                              height: '100%',
                            }),
                          }),
                        }),
                      ],
                    }),
                  }),
              ],
            })
          );
        },
        F = function (e) {
          e &&
            e instanceof Function &&
            a
              .e(8)
              .then(a.bind(null, 204))
              .then(function (t) {
                var a = t.getCLS,
                  n = t.getFID,
                  c = t.getFCP,
                  r = t.getLCP,
                  s = t.getTTFB;
                a(e), n(e), c(e), r(e), s(e);
              });
        };
      i.a.render(
        Object(n.jsx)(r.a.StrictMode, { children: Object(n.jsx)(W, {}) }),
        document.getElementById('root')
      ),
        F();
    },
    44: function (e, t, a) {
      'use strict';
      var n = a(33);
      n.a.initializeApp({
        apiKey: 'AIzaSyBbwiU1hnRpaWmviOtfUDMa7uAd_LSFBic',
        authDomain: 'harmonyhubapp-c0044.firebaseapp.com',
        databaseURL: 'https://harmonyhubapp-c0044.firebaseio.com',
        projectId: 'harmonyhubapp-c0044',
        storageBucket: 'harmonyhubapp-c0044.appspot.com',
        messagingSenderId: '4920664565',
        appId: '1:4920664565:web:26ddf5aaddc945798980bc',
        measurementId: 'G-5Y68PLJ67R',
      }),
        n.a.analytics(),
        n.a
          .firestore()
          .enablePersistence()
          .catch(function (e) {
            'failed-precondition' === e.code
              ? console.log('presistance failed')
              : 'unimplemented' == e.code &&
                console.log('persistance is not availaible');
          }),
        (t.a = n.a);
    },
    89: function (e, t, a) {},
    90: function (e, t, a) {},
  },
  [[116, 1, 2]],
]);
//# sourceMappingURL=main.8947d046.chunk.js.map
