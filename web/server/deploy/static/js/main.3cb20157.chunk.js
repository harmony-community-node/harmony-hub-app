(this.webpackJsonpweb = this.webpackJsonpweb || []).push([
  [0],
  {
    116: function (e, t, a) {
      'use strict';
      a.r(t);
      var n = a(4),
        c = a(2),
        r = a.n(c),
        i = a(24),
        s = a.n(i),
        l = (a(89), a(22)),
        o = (a(90), a(23)),
        j = a(71),
        d = a(144),
        b = a(145),
        h = a(153),
        u = a(146),
        p = a(143),
        O = a(152),
        x = a(67),
        m = a.n(x),
        f = a(141);
      function g() {
        return Object(n.jsx)('div', {
          className: 'loaderHar',
          children: Object(n.jsx)(f.a, { color: 'secondary' }),
        });
      }
      var v = Object(c.lazy)(function () {
          return a.e(6).then(a.bind(null, 208));
        }),
        w = Object(c.lazy)(function () {
          return Promise.all([a.e(3), a.e(4)]).then(a.bind(null, 209));
        }),
        y = Object(c.lazy)(function () {
          return a.e(5).then(a.bind(null, 205));
        }),
        _ = Object(c.lazy)(function () {
          return a.e(7).then(a.bind(null, 210));
        });
      function S(e) {
        var t = e.children,
          a = e.value,
          c = e.index,
          r = Object(j.a)(e, ['children', 'value', 'index']);
        return Object(n.jsx)(
          'div',
          Object(o.a)(
            Object(o.a)(
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
      function k(e) {
        return {
          id: 'simple-tab-'.concat(e),
          'aria-controls': 'simple-tabpanel-'.concat(e),
        };
      }
      var I = Object(d.a)(function (e) {
        return {
          root: {
            flexGrow: 1,
            backgroundColor: '#fff',
            width: '100px',
            overflow: 'scroll',
          },
        };
      });
      function C() {
        var e = I(),
          t = r.a.useState(0),
          a = Object(l.a)(t, 2),
          i = a[0],
          s = a[1],
          j = (new Date(), m.a.renderToStaticMarkup(Object(n.jsx)(g, {})));
        return (
          console.log(j),
          Object(n.jsxs)('div', {
            className: e.root,
            children: [
              Object(n.jsx)(b.a, {
                position: 'static',
                children: Object(n.jsxs)(h.a, {
                  value: i,
                  onChange: function (e, t) {
                    s(t);
                  },
                  'aria-label': 'simple tabs example',
                  variant: 'fullWidth',
                  children: [
                    Object(n.jsx)(
                      u.a,
                      Object(o.a)({ label: 'Calendar' }, k(0))
                    ),
                    Object(n.jsx)(
                      u.a,
                      Object(o.a)({ label: 'Articles' }, k(1))
                    ),
                    Object(n.jsx)(u.a, Object(o.a)({ label: 'Youtube' }, k(2))),
                    Object(n.jsx)(
                      u.a,
                      Object(o.a)({ label: 'Harmony Links' }, k(3))
                    ),
                  ],
                }),
              }),
              Object(n.jsx)(S, {
                value: i,
                index: 0,
                children: Object(n.jsx)(c.Suspense, {
                  fallback: Object(n.jsx)('div', {
                    dangerouslySetInnerHTML: { __html: j },
                  }),
                  children: Object(n.jsx)(w, {}),
                }),
              }),
              Object(n.jsx)(S, {
                value: i,
                index: 1,
                children: Object(n.jsx)(c.Suspense, {
                  fallback: Object(n.jsx)('div', {
                    dangerouslySetInnerHTML: { __html: j },
                  }),
                  children: Object(n.jsx)(v, {}),
                }),
              }),
              Object(n.jsx)(S, {
                value: i,
                index: 2,
                children: Object(n.jsx)(c.Suspense, {
                  fallback: Object(n.jsx)('div', {
                    dangerouslySetInnerHTML: { __html: j },
                  }),
                  children: Object(n.jsx)(_, {}),
                }),
              }),
              Object(n.jsx)(S, {
                value: i,
                index: 3,
                children: Object(n.jsx)(c.Suspense, {
                  fallback: Object(n.jsx)('div', {
                    dangerouslySetInnerHTML: { __html: j },
                  }),
                  children: Object(n.jsx)(y, {}),
                }),
              }),
            ],
          })
        );
      }
      var L = a(42),
        T = a.n(L),
        z = a(47),
        B = a(50),
        D = a(147),
        N = a(148),
        P = a(150),
        A = a(149),
        F = Object(d.a)({
          root: { maxWidth: 370 },
          media: { height: 60, width: 60 },
        });
      function H(e) {
        var t = e.state,
          a = F();
        return Object(n.jsx)(D.a, {
          className: a.root,
          children: Object(n.jsx)('a', {
            href: t.url,
            className: 'anchor',
            target: '_blank',
            children: Object(n.jsxs)(N.a, {
              children: [
                Object(n.jsxs)('div', {
                  style: { display: 'flex', justifyContent: 'space-around' },
                  children: [
                    Object(n.jsx)(A.a, {
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
                Object(n.jsx)(P.a, {
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
      a(51);
      var M = a(53),
        U = a.n(M);
      a(115);
      function R() {
        var e = Object(c.useState)([]),
          t = Object(l.a)(e, 2),
          a = t[0],
          r = t[1],
          i = Object(c.useState)(!0),
          s = Object(l.a)(i, 2),
          o = s[0],
          j = s[1],
          d = (function () {
            var e = Object(B.a)(
              T.a.mark(function e() {
                var t, a;
                return T.a.wrap(function (e) {
                  for (;;)
                    switch ((e.prev = e.next)) {
                      case 0:
                        return (
                          j(!0),
                          (e.next = 3),
                          U.a.get(''.concat('', '/twitter'))
                        );
                      case 3:
                        (t = e.sent),
                          console.log(t),
                          (a = []
                            .concat(
                              Object(z.a)(t.data.data),
                              Object(z.a)(t.data.data2)
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
                                    .concat(e.user.screen_name, '/status/')
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
                                new Date(t.created_at) - new Date(e.created_at)
                              );
                            })),
                          r(a),
                          j(!1);
                      case 8:
                      case 'end':
                        return e.stop();
                    }
                }, e);
              })
            );
            return function () {
              return e.apply(this, arguments);
            };
          })();
        return (
          Object(c.useEffect)(function () {
            d();
          }, []),
          console.log(a),
          Object(n.jsxs)('div', {
            className: 'flexTweet',
            children: [
              o && Object(n.jsx)(f.a, {}),
              !o &&
                a.length > 0 &&
                a.map(function (e, t) {
                  return Object(n.jsx)(H, { state: e });
                }),
            ],
          })
        );
      }
      var W = a(151);
      var J = function () {
          var e = Object(c.useState)(window.innerWidth > window.innerHeight),
            t = Object(l.a)(e, 2),
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
                          Object(n.jsx)(W.a, { orientation: 'vertical' }),
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
                      Object(n.jsx)(W.a, {}),
                      Object(n.jsxs)('div', {
                        style: { display: 'flex', height: '100%' },
                        children: [
                          Object(n.jsxs)('div', {
                            style: { width: '20%', overflow: 'scroll' },
                            children: [
                              Object(n.jsx)('br', {}),
                              Object(n.jsx)('br', {}),
                              Object(n.jsx)(R, {}),
                            ],
                          }),
                          Object(n.jsx)(C, {}),
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
        E = function (e) {
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
                  i = t.getTTFB;
                a(e), n(e), c(e), r(e), i(e);
              });
        };
      s.a.render(
        Object(n.jsx)(r.a.StrictMode, { children: Object(n.jsx)(J, {}) }),
        document.getElementById('root')
      ),
        E();
    },
    51: function (e, t, a) {
      'use strict';
      var n = a(32);
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
//# sourceMappingURL=main.3cb20157.chunk.js.map
