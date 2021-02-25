(this.webpackJsonpweb = this.webpackJsonpweb || []).push([
  [5],
  {
    205: function (A, e, t) {
      'use strict';
      t.r(e),
        t.d(e, 'default', function () {
          return L;
        });
      var r = t(4),
        a = t(2),
        n = t(144),
        i = t(3),
        s = t(6),
        o = (t(11), t(7)),
        c = t(8);
      var l = a.createContext({}),
        d = a.forwardRef(function (A, e) {
          var t = A.children,
            r = A.classes,
            n = A.className,
            c = A.component,
            d = void 0 === c ? 'ul' : c,
            f = A.dense,
            b = void 0 !== f && f,
            h = A.disablePadding,
            u = void 0 !== h && h,
            m = A.subheader,
            j = Object(s.a)(A, [
              'children',
              'classes',
              'className',
              'component',
              'dense',
              'disablePadding',
              'subheader',
            ]),
            y = a.useMemo(
              function () {
                return { dense: b };
              },
              [b]
            );
          return a.createElement(
            l.Provider,
            { value: y },
            a.createElement(
              d,
              Object(i.a)(
                {
                  className: Object(o.a)(
                    r.root,
                    n,
                    b && r.dense,
                    !u && r.padding,
                    m && r.subheader
                  ),
                  ref: e,
                },
                j
              ),
              m,
              t
            )
          );
        }),
        f = Object(c.a)(
          {
            root: {
              listStyle: 'none',
              margin: 0,
              padding: 0,
              position: 'relative',
            },
            padding: { paddingTop: 8, paddingBottom: 8 },
            dense: {},
            subheader: { paddingTop: 0 },
          },
          { name: 'MuiList' }
        )(d),
        b = t(74);
      var h = t(34),
        u = t(24),
        m = 'undefined' === typeof window ? a.useEffect : a.useLayoutEffect,
        j = a.forwardRef(function (A, e) {
          var t = A.alignItems,
            r = void 0 === t ? 'center' : t,
            n = A.autoFocus,
            c = void 0 !== n && n,
            d = A.button,
            f = void 0 !== d && d,
            j = A.children,
            y = A.classes,
            v = A.className,
            g = A.component,
            p = A.ContainerComponent,
            E = void 0 === p ? 'li' : p,
            x = A.ContainerProps,
            R = (x = void 0 === x ? {} : x).className,
            M = Object(s.a)(x, ['className']),
            C = A.dense,
            O = void 0 !== C && C,
            U = A.disabled,
            k = void 0 !== U && U,
            L = A.disableGutters,
            I = void 0 !== L && L,
            P = A.divider,
            Z = void 0 !== P && P,
            S = A.focusVisibleClassName,
            T = A.selected,
            Q = void 0 !== T && T,
            w = Object(s.a)(A, [
              'alignItems',
              'autoFocus',
              'button',
              'children',
              'classes',
              'className',
              'component',
              'ContainerComponent',
              'ContainerProps',
              'dense',
              'disabled',
              'disableGutters',
              'divider',
              'focusVisibleClassName',
              'selected',
            ]),
            V = a.useContext(l),
            J = { dense: O || V.dense || !1, alignItems: r },
            F = a.useRef(null);
          m(
            function () {
              c && F.current && F.current.focus();
            },
            [c]
          );
          var X,
            D,
            N = a.Children.toArray(j),
            B =
              N.length &&
              ((X = N[N.length - 1]),
              (D = ['ListItemSecondaryAction']),
              a.isValidElement(X) && -1 !== D.indexOf(X.type.muiName)),
            G = a.useCallback(function (A) {
              F.current = u.findDOMNode(A);
            }, []),
            Y = Object(h.a)(G, e),
            H = Object(i.a)(
              {
                className: Object(o.a)(
                  y.root,
                  v,
                  J.dense && y.dense,
                  !I && y.gutters,
                  Z && y.divider,
                  k && y.disabled,
                  f && y.button,
                  'center' !== r && y.alignItemsFlexStart,
                  B && y.secondaryAction,
                  Q && y.selected
                ),
                disabled: k,
              },
              w
            ),
            W = g || 'li';
          return (
            f &&
              ((H.component = g || 'div'),
              (H.focusVisibleClassName = Object(o.a)(y.focusVisible, S)),
              (W = b.a)),
            B
              ? ((W = H.component || g ? W : 'div'),
                'li' === E &&
                  ('li' === W
                    ? (W = 'div')
                    : 'li' === H.component && (H.component = 'div')),
                a.createElement(
                  l.Provider,
                  { value: J },
                  a.createElement(
                    E,
                    Object(i.a)(
                      { className: Object(o.a)(y.container, R), ref: Y },
                      M
                    ),
                    a.createElement(W, H, N),
                    N.pop()
                  )
                ))
              : a.createElement(
                  l.Provider,
                  { value: J },
                  a.createElement(W, Object(i.a)({ ref: Y }, H), N)
                )
          );
        }),
        y = Object(c.a)(
          function (A) {
            return {
              root: {
                display: 'flex',
                justifyContent: 'flex-start',
                alignItems: 'center',
                position: 'relative',
                textDecoration: 'none',
                width: '100%',
                boxSizing: 'border-box',
                textAlign: 'left',
                paddingTop: 8,
                paddingBottom: 8,
                '&$focusVisible': {
                  backgroundColor: A.palette.action.selected,
                },
                '&$selected, &$selected:hover': {
                  backgroundColor: A.palette.action.selected,
                },
                '&$disabled': { opacity: 0.5 },
              },
              container: { position: 'relative' },
              focusVisible: {},
              dense: { paddingTop: 4, paddingBottom: 4 },
              alignItemsFlexStart: { alignItems: 'flex-start' },
              disabled: {},
              divider: {
                borderBottom: '1px solid '.concat(A.palette.divider),
                backgroundClip: 'padding-box',
              },
              gutters: { paddingLeft: 16, paddingRight: 16 },
              button: {
                transition: A.transitions.create('background-color', {
                  duration: A.transitions.duration.shortest,
                }),
                '&:hover': {
                  textDecoration: 'none',
                  backgroundColor: A.palette.action.hover,
                  '@media (hover: none)': { backgroundColor: 'transparent' },
                },
              },
              secondaryAction: { paddingRight: 48 },
              selected: {},
            };
          },
          { name: 'MuiListItem' }
        )(j),
        v = t(151),
        g = t(143),
        p = a.forwardRef(function (A, e) {
          var t = A.children,
            r = A.classes,
            n = A.className,
            c = A.disableTypography,
            d = void 0 !== c && c,
            f = A.inset,
            b = void 0 !== f && f,
            h = A.primary,
            u = A.primaryTypographyProps,
            m = A.secondary,
            j = A.secondaryTypographyProps,
            y = Object(s.a)(A, [
              'children',
              'classes',
              'className',
              'disableTypography',
              'inset',
              'primary',
              'primaryTypographyProps',
              'secondary',
              'secondaryTypographyProps',
            ]),
            v = a.useContext(l).dense,
            p = null != h ? h : t;
          null == p ||
            p.type === g.a ||
            d ||
            (p = a.createElement(
              g.a,
              Object(i.a)(
                {
                  variant: v ? 'body2' : 'body1',
                  className: r.primary,
                  component: 'span',
                  display: 'block',
                },
                u
              ),
              p
            ));
          var E = m;
          return (
            null == E ||
              E.type === g.a ||
              d ||
              (E = a.createElement(
                g.a,
                Object(i.a)(
                  {
                    variant: 'body2',
                    className: r.secondary,
                    color: 'textSecondary',
                    display: 'block',
                  },
                  j
                ),
                E
              )),
            a.createElement(
              'div',
              Object(i.a)(
                {
                  className: Object(o.a)(
                    r.root,
                    n,
                    v && r.dense,
                    b && r.inset,
                    p && E && r.multiline
                  ),
                  ref: e,
                },
                y
              ),
              p,
              E
            )
          );
        }),
        E = Object(c.a)(
          {
            root: {
              flex: '1 1 auto',
              minWidth: 0,
              marginTop: 4,
              marginBottom: 4,
            },
            multiline: { marginTop: 6, marginBottom: 6 },
            dense: {},
            inset: { paddingLeft: 56 },
            primary: {},
            secondary: {},
          },
          { name: 'MuiListItemText' }
        )(p),
        x = a.forwardRef(function (A, e) {
          var t = A.classes,
            r = A.className,
            n = Object(s.a)(A, ['classes', 'className']),
            c = a.useContext(l);
          return a.createElement(
            'div',
            Object(i.a)(
              {
                className: Object(o.a)(
                  t.root,
                  r,
                  'flex-start' === c.alignItems && t.alignItemsFlexStart
                ),
                ref: e,
              },
              n
            )
          );
        }),
        R = Object(c.a)(
          {
            root: { minWidth: 56, flexShrink: 0 },
            alignItemsFlexStart: { marginTop: 8 },
          },
          { name: 'MuiListItemAvatar' }
        )(x),
        M = t(35),
        C = Object(M.a)(
          a.createElement('path', {
            d:
              'M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z',
          }),
          'Person'
        );
      var O = a.forwardRef(function (A, e) {
          var t = A.alt,
            r = A.children,
            n = A.classes,
            c = A.className,
            l = A.component,
            d = void 0 === l ? 'div' : l,
            f = A.imgProps,
            b = A.sizes,
            h = A.src,
            u = A.srcSet,
            m = A.variant,
            j = void 0 === m ? 'circle' : m,
            y = Object(s.a)(A, [
              'alt',
              'children',
              'classes',
              'className',
              'component',
              'imgProps',
              'sizes',
              'src',
              'srcSet',
              'variant',
            ]),
            v = null,
            g = (function (A) {
              var e = A.src,
                t = A.srcSet,
                r = a.useState(!1),
                n = r[0],
                i = r[1];
              return (
                a.useEffect(
                  function () {
                    if (e || t) {
                      i(!1);
                      var A = !0,
                        r = new Image();
                      return (
                        (r.src = e),
                        (r.srcSet = t),
                        (r.onload = function () {
                          A && i('loaded');
                        }),
                        (r.onerror = function () {
                          A && i('error');
                        }),
                        function () {
                          A = !1;
                        }
                      );
                    }
                  },
                  [e, t]
                ),
                n
              );
            })({ src: h, srcSet: u }),
            p = h || u,
            E = p && 'error' !== g;
          return (
            (v = E
              ? a.createElement(
                  'img',
                  Object(i.a)(
                    { alt: t, src: h, srcSet: u, sizes: b, className: n.img },
                    f
                  )
                )
              : null != r
              ? r
              : p && t
              ? t[0]
              : a.createElement(C, { className: n.fallback })),
            a.createElement(
              d,
              Object(i.a)(
                {
                  className: Object(o.a)(
                    n.root,
                    n.system,
                    n[j],
                    c,
                    !E && n.colorDefault
                  ),
                  ref: e,
                },
                y
              ),
              v
            )
          );
        }),
        U = Object(c.a)(
          function (A) {
            return {
              root: {
                position: 'relative',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                flexShrink: 0,
                width: 40,
                height: 40,
                fontFamily: A.typography.fontFamily,
                fontSize: A.typography.pxToRem(20),
                lineHeight: 1,
                borderRadius: '50%',
                overflow: 'hidden',
                userSelect: 'none',
              },
              colorDefault: {
                color: A.palette.background.default,
                backgroundColor:
                  'light' === A.palette.type
                    ? A.palette.grey[400]
                    : A.palette.grey[600],
              },
              circle: {},
              rounded: { borderRadius: A.shape.borderRadius },
              square: { borderRadius: 0 },
              img: {
                width: '100%',
                height: '100%',
                textAlign: 'center',
                objectFit: 'cover',
                color: 'transparent',
                textIndent: 1e4,
              },
              fallback: { width: '75%', height: '75%' },
            };
          },
          { name: 'MuiAvatar' }
        )(O),
        k = Object(n.a)(function (A) {
          return {
            root: {
              width: '100%',
              maxWidth: '100%',
              backgroundColor: A.palette.background.paper,
            },
            inline: { display: 'inline' },
          };
        });
      function L() {
        var A = k();
        return Object(r.jsxs)(f, {
          className: A.root,
          children: [
            Object(r.jsxs)(y, {
              alignItems: 'flex-start',
              children: [
                Object(r.jsx)(R, {
                  children: Object(r.jsx)(U, {
                    alt: 'Remy Sharp',
                    src:
                      'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxESEhMTEBEPEBAVGBISFg8YExUVEhcVFRgWFhYWFxMYHSggGBolGxUVIjEhJSktLi4uGB8zODMtNygtLisBCgoKDg0OGxAQGy0lICUtLS8tLSstLS0tLS0vLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIAMgAyAMBEQACEQEDEQH/xAAbAAEAAwADAQAAAAAAAAAAAAAABQYHAQMEAv/EAD8QAAIBAQUCCggDBwUAAAAAAAABAgMEBQYRITFBEjJRYXFygpGxwRMiIzNSgaHCNELRFSRTYnPh8QdDg5Lw/8QAGwEBAAMBAQEBAAAAAAAAAAAAAAQFBgMCAQf/xAA0EQEAAgECAwYEBQMFAQAAAAAAAQIDBBEFMYESITI0QXFRkcHREyMzYfEiQlIUobHh8EP/2gAMAwEAAhEDEQA/ANxAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHDYFbvXEuTcaGTex1Hs+SJOPB62UOs4vtPZw/P7ICvbqk3nOcnzZ6dx27FY5QpsmpzZJ3tafm64VWtjaYmIc4yWid4lKWK/a0Ms3w48j2/JnK2KJT9PxPPjmN57Ufv91qu+3wrRzg9d8d6I9qzXm0em1WPUV3r1j4PUeUkAAee22yFJZyfQt7CPqNVjwV3t8letN8VJ7HwI8i29592Z7PxLNknunaP2+7x+kb2ts8zCF27T3zLuo2qceLJr5nzeXXHqMmPw2lL2G+M8o1NP5t3zPsSuNLxTeezl+f3TCPq5AAAAAAAAAAABWMXXo45UYPLPWb35bkS9Pj3/qnooOMaya/k16/ZV6MHJqMU3J6JLaSZ2iN5UFKTe0VrG8ytFgwtpnWk8/gju7REvqP8V/p+CxtvlnpD11MMUcvVc0+XNP6Hj8ayTbg+CY7pmEDel1ToPX1oPZNbOh8h1reLKXV6HJp57++PjH1dVgtkqU1KPzXKt6Ptq7w46fPbBeL1/mF7s9ZTipR2NZkSY2bPFkjJSL15S7D49uuvVUIuT2JZh4yZIx0m08oU212p1JuUvkuRch027mO1Ge2bJ27fxDvu6751XppFbZfofJd9Jor6ie7uj4pqFxUstXNvlzyPO65rwnDEd8zLptVx76b7L3/M+bOGfhMbb4p6Sh5RabTWTW48KW1ZrM1tG0wm7jtjfqSfVfkeoXfC9VM/lW6fZMH1dAAAAAAAAAABmV4Wn0lWc3nq33FvSvZrEMJqcv4ma159Z/hY8F2JetVer4seblfgRNVblVd8F08bTln2haiG0AB1WmgpxcZaprI+xO07ueXFXLSaW5Sz6tTcZSi9qbXcTY743YjJSaWms+k7LXhSvwqTj8L+j/wyNljazS8Hy9rDNZ9JTZyWyHxPX4NNR+J/Rf5R7xx3qni+Sa4YrHrKtUIOUlFbW0jpLO0rN7RWPWV5s9FQiox2LQ4TLaYsdcdIpXlDsDoAQuILOtJrofPyHyVJxfBG0ZY58pRVkq8GcZcjR8jmqdPk/DyVt+63npsQAAAAAAAABwwMpk9WXUQ/Prc5XrBn4fty8EV2q8bV8G8t1lOkZbAADP729/V68vFk6nhj2YrW+Yv7yncHbKvTD7jhn9FxwTw36fVYzgvVexbsp9MvtOuJR8a8NOv0Q91v21PrR8T3blKp0X69PeF5I7ZAACMxB7rtLzCs4t5frCuQep8lm684XZH1twAAAAAAAABwwMne1l7HJ+fW8Ur3gv8AD9uXkVer/Uavg3lusp4jLYAAZ7e79vV68vEsMfgj2YrW+Yv7yncGbKvTD7iPqOcLjgfhv0WUjr1XcX7KXTPyO2L1UfGvDTr9ENdT9tS60fE938MqjReYp7wvZGbMAAQ+JKyUFHe3nlzI+wqOL5YjHFPWZ3+Svweoln6+JeEfG3AAAAAAAAAHDAyWT1ZfRyfntvFK+YK/D9uXkVWr/Uazg3lusp8jLYAAZ1e79vV68/Essfghitd5i/un8FbKvTD7iNqecLfgfhv0+qzEZfK7jDZS6Z/ad8PqouN+GnX6IS6ffUutHxOl4/plU6LzFPeF9IjZgHgvC9adLTPhT+FefIeorMoOq1+PBG3Ofgq1ptMqknKT18FyHvZmM2a2W/bt/wC/Z8RPLxXmvaPDcAAAAAAAAADhgZE3qzQxyfnlucr9gn8P25eCKjWfqNbwXy3WVgIq2AAGcXy/b1evPxLPH4I9mJ13mL+8pvB9phBVeHKMc3DLN5fEcNRWZmNlnwfNjx1v27RHLmsH7Uo/xId5G/Dv8Fz/AK3T/wCcfNAYqttOp6NQmpNcLPLdnlkd8NJjfdTcX1GPLWsUtvz5IewV1CpCTzyjJN8uSPdq7xsqtPkjHlreeUSsNbFC14FNvnb8jh+DK7ycaj+yvzRlpvmtU0cuCuRaHuKRCuzcRz5Y2mdo/Z4uEfULd63Y5qHpGso5pLPa8+Y57xySJ02SuL8SY2jf1dMGfJhxrzhfUcm5AAAAAAAAAHDAx+T1ZoojufndvE0DA/4btz8io1v6vRreC+W6y9V44is9HThcOfwx173sRzx6a9/R21HE8GHu33n4Qr9rxfVl7uMaa3PjS+uhLro6x4p3U+XjeW0/0REf7yiq96V58arNrkzaXcdYxUryiFfk1mfJ4rS82Z62R93KPI+kzy+vtM87D7TPMw9vZQu+tPi05vny07znNqxzl3x6TPfw1lK2XDdV8eUYLk2v9DlbLHoscXB8tvHMR/vKasVzUaevB4Uviev0OU3mVtg4dgw9+28/GXVib3Paj5inNz4t5frCrU3qdJZmvNf0cG5AAAAAAAAAHDAx2W1mk9H53bnL2070qxpehjJxhm5PLRvPLa+TQ4zhpN+3PekV1eWuL8GJ2jfv29Xmiz3KOl7BcFoq5OMODF/ml6q7tpGyajHT139k/Bw3UZdpiu0fGe5OWXBq09JV6VFad7IttZ/jC1xcCj/6W+St3hRVOrUhHPKMpRWe3JPIlUmbViZ9VJqccY8tqV5ROyfwfYqdRVHUhGTi4ZZ7s8/0IuqvasxstuD6fFli03rvtt9Vl/ZVD+FDuIn4l/iu/wDRaf8Awj5K/i6zQgqXAjGObnsWXISNPabTO6n4xhx4607ERHPkiLn9/S68fFHbJ4Z9lZovMU94aGVzagACIxP7ntR8z3j8Ss4v5frCqwep2lmK84aCiM3QAAAAAAAAA4YGNyer6WaaI7n51bxS9N32OdaahTWcn3Jb2+Y55bxjrvLrgwXz3ilObRLmw9SoJPJVKm+bWzqrcUubU2yftDX6PhuLTxvzt8Z+iYI6xAMyvt/vFbrz8WXGH9OPZh9d5nJ7yseBNlbpp/cRNZzjqueBeG/T6rUQl+rGN9lLpn9pK0vOVDxzw06/RA3M/b0uvDxRIy+GfZT6HzFPeGila2wAAiMU+47UfM6Y/Eq+L+X6wqdN6neWYrzaGiI3YAAAAAAAAA4nsYh8tyY1V40ul+JqIjufnVua9f6f2WKpTq/mlLgZ80cn4v6FPxC89uK/BqOBYYjFOT1mdvkthXr4AAZhfT/eK39SfiXWH9Ovsw2v8zk91kwFsrdMPuIet5wueA+G/T6rWQWgVbHOyj0z+0maTnKh474adfogbm9/S68PFHfN4J9lPofMU94aOVjbAACHxV7jtR8zrh8Sr4v5frCoQ2kiWXrzho6ITeAAAAAAAAADiexiHy3JjFV+tLpfiaqOT86t4paJgH8L/wAk/tKPiH63RruCeW6yshBXAAAy6/H+81v6k/Eu8H6dfaGF13mb+8rLgHi1umH3ELXc4XXAfDfp9VsILQKrjrZR6Z/aTNJzlQ8d8NOv0QFyv29Hrw8UScvgn2U2h8zT3hpJVNuAAIbFfuO1HzOuHxKvi/l+sKfB6olTDL15w0lEBvAAAAAAAAAAAxy9LM6VapB/llJcmmejNRhvF8cW/Z+farHOLNas+kytv+nl4r16Enk8+HHn+JdOiKziWKd4yR7L3gWpiInDPPnH1XYqmkAOi22qNKEpzeUYpv8AseqUm9orDlmy1xUm9uUMotFdznKctsm2/mX9a9msR8GCyXm95tPrMyvOBbM40ZTf55adEdP1KvW23vt8Go4JimuGbT6z/wALKQl0r2NbO5UYzX5JfR6N+BK0ltr7fFTcaxdrBFo9J/5UyzVnCUZLbFp9xYWrvEx8WZx3mlotHpMS06yWiNSEZxecZLP+xT2rNZ2lu8OWuWkXryl3Hl0AKxjC2r1aS1fGlzchJ09f7lBxrURtGKPefogrvo8OpCKz1a7jtedomVNpsc5Mtax8Y/7aIQG4AAAAAAAAAAClY9uVvK0U1nklGoltyWyXl3Frw7Ubfl26M7xvRTb8+nX7qVRqyhJSg3GSeaa2pot7Vi0TExvDN0talotWdphdLrxyskrRB5r/AHI7+mJUZuGzzxz82i03HY22zR3/ABj7JCrjazJerGrJ8nBS+uZxjh+WeeyVbjmniO6JlVL7v+raX63qU1qqa2dLe9k/Bpa4v3n4qLW8Qyame/ur8Pu8112CdepGnDfte5Le2e82SMde1LhpdPfPkilf4hqlks8acIwjpGKSRQWtNp3lusWOuOkUryh3Hl0dVrs8akJQlxZJpnqtprO8OeXHGSk0tylml4WKVGo4TWzY9zW5ouKXi9d4YfU6e2DJNLfzD1XNfVSzvKPrQerg/J7mc8uCMnukaPX5NNO0d8esfZZqWLaDXrKpF8mSf1zIU6W8LyvGsEx3xMPNb8WLLKjF5/HLd0RPddLP9yPqONRtMYo6z9lZqVXJuUm3J6tvaSNoiNoUN72vabWneZWrCd2te2mss9ILm3siZ7/2w0HCNHMfnX6fdZSMvgAAAAAAAAAA4az0eq5ATG6l39grNudlaWerot6Z/wAr3dDLXT8R2js5Pmzut4J2p7WD5fZUbXd1ak8qlKpHncXl3lnTNjvH9NoUGTS5sU7WrMdHUqU/hl/1Z6maxzlyrS890Qm7swtaarXCj6KHxS0fyjtZCy63FTl3rLTcJ1GWe+OzHxn7L7c90UrNDg01m3xpvjS6f0KjNntlnezU6TR49NXs06z8UgcUsAAeG9brp2iPBmtVsmuMn/7cdMeW2Od4RdVpMeor2bx7T8FMvDDlek3lH0kPijq/nHaixpqaW590szqOFZ8U90dqP2+yKcJLRpp8jWR13ieSvmlo5w9NlsNWpxKcpc+Wnec7XrXnLri02bJ3UrM9FmufDHBanXab2qmtnzZEyajfuqvNHwfsz283y+6zJERfuQAAAAAAAAAAAAAAOEg+REQ5D6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf//Z',
                  }),
                }),
                Object(r.jsx)('a', {
                  href: 'https://www.harmony.one',
                  rel: 'noreferrer',
                  target: '_blank',
                  children: Object(r.jsx)(E, { primary: 'Harmony One' }),
                }),
              ],
            }),
            Object(r.jsx)(v.a, { variant: 'inset', component: 'li' }),
            Object(r.jsxs)(y, {
              alignItems: 'flex-start',
              children: [
                Object(r.jsx)(R, {
                  children: Object(r.jsx)(U, {
                    alt: 'Travis Howard',
                    src:
                      'data:image/png;base64,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',
                  }),
                }),
                Object(r.jsx)('a', {
                  href: 'https://docs.harmony.one/home/',
                  rel: 'noreferrer',
                  target: '_blank',
                  children: Object(r.jsx)(E, { primary: 'Documentation' }),
                }),
              ],
            }),
            Object(r.jsx)(v.a, { variant: 'inset', component: 'li' }),
            Object(r.jsxs)(y, {
              alignItems: 'flex-start',
              children: [
                Object(r.jsx)(R, {
                  children: Object(r.jsx)(U, {
                    alt: 'Cindy Baker',
                    src:
                      'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAilBMVEX/////AAD/kJD/sbH/zc3/1NT/hYX/oKD/4uL/v7//9vb/6en/3Nz/8/P/x8f/lZX/qKj/rKz/b2//PDz/dXX/XV3/iIj/YWH/U1P/Cgr/mpr/7u7/WVn/Jyf/uLj/5OT/NTX/SEj/aWn/GRn/fX3/UFD/RUX/LS3/ICD/R0f/gID/Z2f/ERH/GxucgkMeAAAEt0lEQVR4nO2da1fiMBCGQ0ttactN7iI3Fy+r+P//3oKCC4ilmUyazO77fPMcTfIcsEkmk6lSAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA8F+TpukiWSTRlvoH4RHdduf4x89f2P3q9i+SZtp0Pfhz0izJo0Y3bgfD9Wi8XNYmNQYmm97yftQfBkHcmTfyPMnSir2aWRTGw7en2YbDpxSbl+W4347nUWb7U05b8WjJ8kGRma3WnbolzzQcO3U7ZhVn7H7NoWurMwY5r+Cda6ELDBi/rPmLa5vLhFyCsWuTH+nzCPZdexQw5hB8c21RCIPig2uHKxh/UduuDa4yNxOsux5/CaZGhr9cD78EDyaCgevRl8JgddN0PfZyGHyIPq7VLkH/T3x2PfSSdKmCieuRl+WRathxPfKyTKhxjlvXIy8N9WkqYTL8pEMTnLoed3mIi9PI9bjLM6MZinnQbKE9anyLPRVBe9Tcux62Bi2SodvQrx4xydD1qHW4oQhmrketwz3FUNBkUattKIYt16PWgmIoaTqkbRF5IhiDGUszV6FMiGuWntvqhqWda9QJhjx7p0Cp/ImlpWIaBMNHlp6DXVMhS1OFUKZ8nn+gD0OVWt9MDwmGPD0H+9Yiy1GttXND26eQtx4YqmzA0+RFCOE2phhGcNxmw14KzrO+IdPCOzht1drkONE3ZFp4nxmqvMfT7je8MVSqy9PwOfqGTFuL74YqtZL6oB+LsmeoVN3C5Ki/uWjwdHzR0Ma5nf7mwq6hyrgjeZFvhmwdHNDfPjEtsn42ZJ4c9SOmFRiqhHHnqL9BrMKQc3L01VA1uXaO+oZMqTTXDLeTI89WW/+QlOkxcN2QKXdOP4xRoaHKGHLk/TbkmBx9NzTvTz8UVbWhyn8bdaR/vla5oeGhswBDw9C4/4avhh35bmj+LG17bZgxnJF4PVs4WtMwXUOobF2qbyhtb6GfJ4z9YUkKDTlPh700NJ0CT9A3lBZr049ESYuX+mbIfyVOPyIs7dxCP6pv8ezJSmKG/smMtPND/dO1f/8MWNg5PsGQ6e5hVbkYlARTno6ryqeh3Cnh6fmvod3rmpQLejw9HwyZdoE/Qsn6Ys1NtF63gJK5x5hfamkKPIaSfSkrR5iSQSsrz5uSBc2Uq19R8R5KJrus+xaU2wiy7sxQrliKuvdEuhUk6u7aO8VQ1P3DEclQ0h1SyoQv6x4wreSApLvc+pG2HZImxAXJUNJ0QRKUVBfjiWYoqLaJTk7LMXLq01B2FjvkPGqoFWnF1IkiXOvaI6XWl34uzQEp9doSsqGQmnukohh7/K/tuYO2ZNvjaYnkE8xqtEpYuRmW3fe3DvQBo+/oDp8rQe9gqOntdy1oYrW9U1hTl5hhEazkYIUIrYjZBRI/l28rsyrQp/j4SGV7b8AnqWfLmwmtBl0xc3/CiyPqlvcaaetusHTrtuk9xJHllwc1F/Xu3et4+V6p2Gz11o7necVvRpou8rwRdj5e9/TYe+Z53dOOyabXG4xuhkG7Ezp541MRzXSaJIvo65Vd8+N3dMVxeE7j67VdUZJsVbx7bRcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABUzB8ommwuXNQogAAAAABJRU5ErkJggg==',
                  }),
                }),
                Object(r.jsx)('a', {
                  href: 'https://www.youtube.com/harmonyprotocol',
                  rel: 'noreferrer',
                  target: '_blank',
                  children: Object(r.jsx)(E, { primary: 'YouTube' }),
                }),
              ],
            }),
            Object(r.jsx)(v.a, { variant: 'inset', component: 'li' }),
            Object(r.jsxs)(y, {
              alignItems: 'flex-start',
              children: [
                Object(r.jsx)(R, {
                  children: Object(r.jsx)(U, {
                    alt: 'Travis Howard',
                    src:
                      'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAaVBMVEX///+KnP79/f2FmP7///3Cyv+So/6Gmf6Dlv6Qof74+f329/3z9f2AlP7b4P2Wpv7q7f2otf61wP6wvP6suP6Vpf6Mnv6hr/7W3P2drP67xf7j5/3N1P2ms/7f5P3u8P3I0P7M0/2/yP5ijmZzAAAJS0lEQVR4nO2d2ZaiMBCGkQQTkE2wEUEB+/0fcgJoq5AFxQKGk/9qznTE+shWqaSiYWhpaWlpaWlpaWlpaWlpvScz9K+VNbeqqx+aIHzp3iYULUGU2Pv023hORSjZLEfMmsr5JmCaoLmZekLJ9+rRjOncOFzR+Ev9cRcsrwJboWD3DUDXXlIHfBXZul8gDJYLyBCD8YDxUptoKxSPBUyXOcg8REeOqI49N4FS9rh5sVp2G62FqlGEy69CVoljABffC2tRfwThYckzxV3kMILwfwBkiJ8Dlt7cxg+SV35M6P8P3XBURzwvf66ohc4fE/4Hs2GtETOi9Z8QWppQEy5dmlATLl+aUBMuX5pQEy5fmlATLl+aUBMuX5pQEy5fmlATjhAhiFLFzgArgNC4HaCZCAlCm2N29fMykBVL8rw4/+6TMZQzEDK6bZyWuJYZRhLbUYFbuX72Qz6knJyQ0JOVmy1eEf3IT/wl+9Rl5ZriYXVEn3zjxIQIxTVebXOZbe+1QliXRHWnbMX+Te5/QQyyfhkNZZiR979zUkKUVE6LZ/pHihoCVi/J6ZBdz2mRh7XyIj1X2T5INi0og7Kaimw+d96++60TEiK7ulWfa9m0qbefS5bmO8yXm5+j47bGROhQtIzsw+nPezuzkxES9Lu78WUJIsgLojR02v7IV/M3J6wOW4814aN/ZzSr5J0xZypCeixbPicirKtdzqUpgXvFNHPrx6P0VNzbqnt44wjBNIRkk7ajhWNRb9OMHWq4F0y3CpB3DO+MhT34yychREe3HQ3TxDumu7foHpBhZnuRc2uqzuBTkVMQkn1bge7Fi8L3au8V0kkDkt6rMRv49VMQorDpgedNO1d8LvZ28uOlrUbsDBxSJyBkVcgM2kWWOY7vBhnGeYs4sBInIPTqKnT8j7oflzEP20Y/bM6AJyTHuz/yLd2eNLAS4Qlp8T22V9ByUCXCEwZAgAxxPwQRnBCd4QiLIRaAEyY7MEIT/yyAEGVwgCYecjwSnDCEJDTnJyRw40yDGKvHGmBCwHGmISzUrhswIXVgCU31WANLSA6ggAzxV2kELCH1oQlDZUeEJdzCNtIa8aRCBCUkETSgiZXn6UEJEZTT/URYzkpogzdShijd2gEmJDE8oLqZQhKidArCUBE7BSWcoJEyxO1shOQ0BaCJZTuQsISomoZQkUMHSOjJF073LSZFEVMVQsau4kXDESZyvtI62XYQ5ZK9p1uRQs6ocGvgCKVeN97FXrMDTLyToKqxE92LBNLWoPC+4QjRVWwWDh97R4Q/qeBy+1REtsxUBKTgCKn4xbOu89yweCsQ7Lxsg1LJ1KroiHCEknVFr+eUvaL48loEuRJEqeMGRngL5nMt6l5VgHruXW8KkPVq+YwIRoh+xYS9d466lYiPXaNJv54fb0xmCRyhcHnPWZd3RxLs9p4tGbjkrilcPxS+c3ztfbDbBjm10uxCip4o82rACG2xPZxu0wmrYs6zA+ED2cg1A6HE7eaFce0OYdYv8iMZm6XH/6AIxSEanj3bLiGnDiWEslUwFKHEC+E0QXLpEPZNlsw+8tA3FKFk55fjZXUXWjjsmSzbxMLuDISe2AdhDlmvdMfDw05v4S7bLOc8cQJCmavc7WX9FthrpopNLMlgCkVoywidzlDTj6vi7kVpnjSqJdvRByKUjQv1hP7ihPC6GC5ei8gDk7LpAopQHs/H1ZP9dM9bw+PzUxF0NBXPE9sCRIgsRXDl71ZXwmqQWxb7jyKRKlYj8b2hCCUL/NYmJwvqU+t2LFwoY8cK6uPtySFXBe1kEyIUoTLcXeda+H4oO+1WFyn8fMCBOBxOXodDjnopg4n3MsonSQ+AQRFCHjLhELriKR+IkOfSQB6s2Yk3L6DqkHPWSxJLepPH6f/P5IScbSd8rr5yxhRjqz+2OuJTJ1AzPmcxh6NAHMIfzlfYvIWZOKAI5ZfyCHHsxeUoRozDvcfb0pKETIEIE96CvEYkkTsiHSE8II/rS0giNVCtlB9pY/4j8g4f5Vw0+W4e2nCDlDOMNGw5J3A2bUTo23kzdcaMtaUEBYI3J7kOFyxOIwg61NtqzJW2o2Jw7lOdwZYeCWIfs/iTKq5miGII97hvWVkEJZGvTl+rC+zSywaROr1WMEx1lptTEW6oaHmB8bnJjyWUHq1iJ/A92/91/exEm8Lo5AveBvZn2j/cUOFJBWymF9QmyVJyiis/dP+29e+7+25YVPGJ3PDIQbjVjdPZzmJsqGBt21RQWd0H+Boz2Z72cWZV16qqrCzen7ZJC9cUOJ6FUwzmbQBMRnjPOxSY1hn/2oRu1CRyk+c/1cl94lXyXnUOGviM8C13lGfb7+CEZSraihyUSwqdjUD3/AGwtw8sNZJ/lgG7QxJJwXNmCIk4eZUDTi+/PKS/oGaT5O9myEMmyD9EqJcbi3fv/TwN6eQW1SNVNvAOiUkynQm91KPhg7J70kL9hNPfh5vLCNL94DsyJsrHZz7Xscqd+2w3NEv5yc7ob6bMq8bHGfzJyW6NYHMBCQ5WWuTu+YMb+VHFfIC0ioPNm5fVTHy3CamvMPE+uvYFeZ/dN6TvidKEy5cm1ITLlybUhMuXJtSEy5cm1ITLlybUhMuXJtSEy5cm1ITL1wjCfgradHojMDyCUJrXCKzh26tjCPP5fg/YM2UnaF41gtCY7zedaWhchyKOIVRe0QSm+neah3aSMYTz/eRx8zvNPvgdtEY/HXkqtVbnBHgf3zAUN8PAiUTN95dDrp8fRTjsmlsAkcutFW1Bb4Zken8//ksKbga4AeSde7UGvEMQJXcDnBPgfW21lPfBQcn5M+ECd3KvkfxsJ5hI+TBBcfRrLOFM3inKn0yIpO7NaEIjf+sXQ74k5D+bIPXDxxMau/3IX9X6QOj6YgLQnQoP+SdvYkb0+2qB5NrrrxAyxoNH0SAn6kuEcccA8XH9LxEyFVZ8CrYTyd53vz4Xvd7vEc4t0Yi3HkIj5J/KXRGh4XIR10TId1JXRWg4HCd1XYTMSe1f3bMywr4HtzrCXih+fYTdBd0KCTsxuDUSGuVzcGWVhMbuaWJcJ+Fz9GathI/QxmoJDYuundC4ZVetmPA2Ma6Z0AjrRfGqCQ33h6ycsF4xrpzQMPbe2gmNKJvbAnCFcxugpaWlpaWlpaWlpaWltXz9A5vu3W+JW/iJAAAAAElFTkSuQmCC',
                  }),
                }),
                Object(r.jsx)('a', {
                  href: 'https://harmony.one/discord',
                  rel: 'noreferrer',
                  target: '_blank',
                  children: Object(r.jsx)(E, { primary: 'Discord' }),
                }),
              ],
            }),
            Object(r.jsx)(v.a, { variant: 'inset', component: 'li' }),
            Object(r.jsxs)(y, {
              alignItems: 'flex-start',
              children: [
                Object(r.jsx)(R, {
                  children: Object(r.jsx)(U, {
                    alt: 'Travis Howard',
                    src:
                      'data:image/png;base64,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',
                  }),
                }),
                Object(r.jsx)('a', {
                  href: 'https://www.reddit.com/r/harmony_one/',
                  rel: 'noreferrer',
                  target: '_blank',
                  children: Object(r.jsx)(E, { primary: 'Reddit' }),
                }),
              ],
            }),
            Object(r.jsx)(v.a, { variant: 'inset', component: 'li' }),
            Object(r.jsxs)(y, {
              alignItems: 'flex-start',
              children: [
                Object(r.jsx)(R, {
                  children: Object(r.jsx)(U, {
                    alt: 'Travis Howard',
                    src:
                      'data:image/png;base64,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',
                  }),
                }),
                Object(r.jsx)('a', {
                  href: 'https://github.com/harmony-one',
                  rel: 'noreferrer',
                  target: '_blank',
                  children: Object(r.jsx)(E, { primary: 'Github' }),
                }),
              ],
            }),
            Object(r.jsx)(v.a, { variant: 'inset', component: 'li' }),
            Object(r.jsxs)(y, {
              alignItems: 'flex-start',
              children: [
                Object(r.jsx)(R, {
                  children: Object(r.jsx)(U, {
                    alt: 'Travis Howard',
                    src:
                      'data:image/png;base64,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',
                  }),
                }),
                Object(r.jsx)('a', {
                  href: 'https://t.me/harmony_one',
                  rel: 'noreferrer',
                  target: '_blank',
                  children: Object(r.jsx)(E, { primary: 'Telegram' }),
                }),
              ],
            }),
            Object(r.jsx)(v.a, { variant: 'inset', component: 'li' }),
            Object(r.jsxs)(y, {
              alignItems: 'flex-start',
              children: [
                Object(r.jsx)(R, {
                  children: Object(r.jsx)(U, {
                    alt: 'Travis Howard',
                    src:
                      'data:image/png;base64,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',
                  }),
                }),
                Object(r.jsx)('a', {
                  href: 'https://t.me/HarmonyCommunityNode',
                  rel: 'noreferrer',
                  target: '_blank',
                  children: Object(r.jsx)(E, {
                    primary: 'Harmony Community Node',
                  }),
                }),
              ],
            }),
            Object(r.jsx)(v.a, { variant: 'inset', component: 'li' }),
            Object(r.jsxs)(y, {
              alignItems: 'flex-start',
              children: [
                Object(r.jsx)(R, {
                  children: Object(r.jsx)(U, {
                    alt: 'Travis Howard',
                    src:
                      'data:image/png;base64,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',
                  }),
                }),
                Object(r.jsx)('a', {
                  href: 'https://www.harmonyvalidators.com/',
                  rel: 'noreferrer',
                  target: '_blank',
                  children: Object(r.jsx)(E, { primary: 'Harmony Validators' }),
                }),
              ],
            }),
          ],
        });
      }
    },
  },
]);
//# sourceMappingURL=5.49a3258c.chunk.js.map
