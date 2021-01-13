(this.webpackJsonpweb = this.webpackJsonpweb || []).push([
  [7],
  {
    210: function (t, e, a) {
      'use strict';
      a.r(e),
        a.d(e, 'default', function () {
          return v;
        });
      var n = a(27),
        c = a.n(n),
        r = a(41),
        s = a(22),
        i = a(4),
        o = a(2),
        u = a(143),
        l = a(146),
        p = a(147),
        b = a(149),
        h = a(148),
        j = a(142),
        d = Object(u.a)({ root: { maxWidth: 345 } });
      function m(t) {
        var e = t.state,
          a = (d(), e.snippet),
          n = a.title,
          c = a.description,
          r = e.snippet.thumbnails.medium.url,
          s = 'https://www.youtube.com/watch?v='.concat(e.id.videoId);
        return (
          console.log(n, c, r, s),
          Object(i.jsxs)(l.a, {
            className: 'cardHolder',
            children: [
              ' ',
              Object(i.jsx)('a', {
                href: s,
                target: '_blank',
                className: 'anchor',
                children: Object(i.jsxs)(p.a, {
                  children: [
                    Object(i.jsx)(h.a, {
                      component: 'img',
                      alt: 'Contemplative Reptile',
                      height: '140',
                      image: r,
                      title: 'Contemplative Reptile',
                    }),
                    Object(i.jsxs)(b.a, {
                      children: [
                        Object(i.jsx)(j.a, {
                          gutterBottom: !0,
                          variant: 'h5',
                          component: 'h2',
                          children: n,
                        }),
                        Object(i.jsx)(j.a, {
                          variant: 'body2',
                          color: 'textSecondary',
                          component: 'p',
                          children: c,
                        }),
                      ],
                    }),
                  ],
                }),
              }),
            ],
          })
        );
      }
      var O = a(51),
        x = a.n(O),
        f = a(140);
      function v() {
        var t = Object(o.useState)([]),
          e = Object(s.a)(t, 2),
          a = e[0],
          n = e[1],
          u = Object(o.useState)(!0),
          l = Object(s.a)(u, 2),
          p = l[0],
          b = l[1];
        return (
          Object(o.useEffect)(function () {
            var t = (function () {
              var t = Object(r.a)(
                c.a.mark(function t() {
                  var e, a;
                  return c.a.wrap(function (t) {
                    for (;;)
                      switch ((t.prev = t.next)) {
                        case 0:
                          return (
                            (t.next = 2),
                            x.a.get(
                              'https://www.googleapis.com/youtube/v3/search?key=AIzaSyCYMCMmAMeTZ-Et0txHOj-3bU0G0ATRbMc&channelId=UCDfuhS7xu69IhK5AJSyiF0g&part=snippet,id&order=date&maxResults=20'
                            )
                          );
                        case 2:
                          (e = t.sent),
                            (a = e.data.items),
                            n(a),
                            b(!1),
                            console.log(a);
                        case 7:
                        case 'end':
                          return t.stop();
                      }
                  }, t);
                })
              );
              return function () {
                return t.apply(this, arguments);
              };
            })();
            b(!0), t();
          }, []),
          Object(i.jsxs)('div', {
            className: 'mediumWrap',
            children: [
              p && Object(i.jsx)(f.a, {}),
              !p &&
                a.length > 0 &&
                a.map(function (t, e) {
                  return Object(i.jsx)(m, { state: t });
                }),
            ],
          })
        );
      }
    },
  },
]);
//# sourceMappingURL=7.9a2c381d.chunk.js.map
