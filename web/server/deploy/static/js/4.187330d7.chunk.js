(this.webpackJsonpweb = this.webpackJsonpweb || []).push([
  [4],
  {
    209: function (e, t, n) {
      'use strict';
      n.r(t);
      var r = n(42),
        a = n.n(r),
        o = n(23),
        s = n(47),
        c = n(50),
        i = n(166),
        l = n(167),
        d = n(189),
        p = n(188),
        u = n(4),
        b = n(2),
        j = n.n(b),
        h = n(51),
        f = (n(168), n(169)),
        v = n.n(f),
        O = n(144),
        m = n(206),
        x = n(202),
        y = n(207),
        g = n(203),
        D = Object(O.a)(function (e) {
          return {
            modal: {
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
            },
            paper: {
              backgroundColor: e.palette.background.paper,
              border: '2px solid #000',
              boxShadow: e.shadows[5],
              padding: e.spacing(2, 4, 3),
            },
          };
        });
      function k(e) {
        var t = e.open,
          n = e.setOpen,
          r = e.modalInfo,
          a = D();
        console.log(r, t);
        var o = function () {
          console.log('close'), n(!1);
        };
        return (
          console.log(r),
          Object(u.jsx)('div', {
            children: Object(u.jsx)(m.a, {
              'aria-labelledby': 'transition-modal-title',
              'aria-describedby': 'transition-modal-description',
              className: a.modal,
              open: t,
              onClose: o,
              closeAfterTransition: !0,
              BackdropComponent: x.a,
              BackdropProps: { timeout: 500 },
              children: Object(u.jsx)(y.a, {
                in: t,
                children: Object(u.jsxs)('div', {
                  className: a.paper,
                  children: [
                    Object(u.jsx)('h4', {
                      id: 'transition-modal-title',
                      children: 'Description',
                    }),
                    Object(u.jsxs)('p', {
                      id: 'transition-modal-description',
                      children: [
                        'All Day:',
                        ' ',
                        !0 === r.allDay
                          ? Object(u.jsx)('span', { children: 'Yes' })
                          : Object(u.jsx)('span', { children: 'No' }),
                        Object(u.jsx)('br', {}),
                        'Description: ',
                        r.title,
                        Object(u.jsx)('br', {}),
                        'Notes: ',
                        r.notes ||
                          Object(u.jsx)('span', {
                            children: 'No Notes regarding this',
                          }),
                        Object(u.jsx)('br', {}),
                        'StartTime:',
                        ' ',
                        r.start
                          ? r.start.toDate().toString()
                          : Object(u.jsx)(u.Fragment, {}),
                        Object(u.jsx)('br', {}),
                        'EndTime:',
                        ' ',
                        r.end
                          ? r.end.toDate().toString()
                          : Object(u.jsx)('span', {
                              children: 'No End Date Availaible',
                            }),
                        Object(u.jsx)('br', {}),
                        'Type: ',
                        r.recurrence_type,
                      ],
                    }),
                    Object(u.jsx)(g.a, {
                      variant: 'contained',
                      onClick: o,
                      children: 'Close',
                    }),
                    ' ',
                  ],
                }),
              }),
            }),
          })
        );
      }
      var w = (function (e) {
        Object(d.a)(n, e);
        var t = Object(p.a)(n);
        function n(e) {
          var r;
          return (
            Object(i.a)(this, n),
            ((r = t.call(this, e)).state = {
              events: [{ title: 'All Day Event', start: '2017-05-01' }],
              open: !1,
              modelInfo: {},
            }),
            r
          );
        }
        return (
          Object(l.a)(n, [
            {
              key: 'componentDidMount',
              value: (function () {
                var e = Object(c.a)(
                  a.a.mark(function e() {
                    var t, n, r, c;
                    return a.a.wrap(
                      function (e) {
                        for (;;)
                          switch ((e.prev = e.next)) {
                            case 0:
                              return (
                                (e.next = 2),
                                h.a
                                  .firestore()
                                  .collection('calendar_events')
                                  .get()
                              );
                            case 2:
                              (t = e.sent),
                                (n = t.docs
                                  .filter(function (e) {
                                    return (
                                      console.log(e.data()), e.data().approved
                                    );
                                  })
                                  .map(function (e) {
                                    var t = e.data();
                                    return {
                                      textColor: 'white',
                                      color: t.color,
                                      start: t.start_date.toDate(),
                                      end: t.end_date.toDate(),
                                      title: t.title,
                                      recurrence_type: t.recurrence_type,
                                      recurrence_rule: t.recurrence_rule,
                                      notes: t.notes,
                                    };
                                  })),
                                (r = Object(s.a)(n)),
                                n.reduce(function () {
                                  var e =
                                    arguments.length > 1
                                      ? arguments[1]
                                      : void 0;
                                  if ('Weekly' === e.recurrence_type) {
                                    for (
                                      var t = e.recurrence_rule.indexOf(
                                          'COUNT'
                                        ),
                                        n = e.recurrence_rule[t + 6],
                                        a = [],
                                        s = e.start,
                                        c = 1;
                                      c < n;
                                      c++
                                    ) {
                                      var i = new Date(
                                        s.setDate(s.getDate() + 7)
                                      );
                                      a.push(
                                        Object(o.a)(
                                          Object(o.a)({}, e),
                                          {},
                                          { start: i }
                                        )
                                      );
                                    }
                                    r.push.apply(r, a);
                                  }
                                }),
                                (c = new Set(r)),
                                console.log(Array.from(c)),
                                this.setState({ events: Array.from(c) });
                            case 9:
                            case 'end':
                              return e.stop();
                          }
                      },
                      e,
                      this
                    );
                  })
                );
                return function () {
                  return e.apply(this, arguments);
                };
              })(),
            },
            {
              key: 'render',
              value: function () {
                var e = this;
                return Object(u.jsxs)('div', {
                  id: 'example-component',
                  children: [
                    Object(u.jsx)(v.a, {
                      id: 'your-custom-ID',
                      header: {
                        left: 'prev,next today myCustomButton',
                        center: 'title',
                        right: 'month,basicWeek,basicDay',
                      },
                      defaultDate: Date.now(),
                      navLinks: !0,
                      editable: !0,
                      eventLimit: !0,
                      events: this.state.events,
                      eventClick: function (t) {
                        e.setState({ open: !e.state.open, modelInfo: t });
                      },
                    }),
                    Object(u.jsx)(k, {
                      open: this.state.open,
                      setOpen: function (t) {
                        return e.setState({ open: t });
                      },
                      modalInfo: this.state.modelInfo,
                    }),
                  ],
                });
              },
            },
          ]),
          n
        );
      })(j.a.Component);
      t.default = w;
    },
  },
]);
//# sourceMappingURL=4.187330d7.chunk.js.map
