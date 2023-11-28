function css(el, styles) {
  for (let rule in styles) {
    el.style[rule] = styles[rule]
  }
}

function trigger(el, eventName) {
  el.dispatchEvent(new CustomEvent(eventName))
}

function isPlainObject(obj) {
  return obj && obj.toString() === "[object Object]"
}

const eventHandlerRefsExpando = '__recurring_select_events'

function on(el, events, sel, handler) {
  let eventHandler = sel
  if (handler) {
    eventHandler = (e) => {
      if (e.target.matches(sel)) {
        if (handler.call(this, e) === false) {
          e.preventDefault()
          e.stopPropagation()
        }
      }
    }
  }

  el[eventHandlerRefsExpando] = el[eventHandlerRefsExpando] || []

  events.trim().split(/ +/).forEach(type => {
    el[eventHandlerRefsExpando].push([ type, eventHandler ])
    el.addEventListener(type, eventHandler)
  })
}

function off(el, events) {
  const types = events.trim().split(/ +/)

  el[eventHandlerRefsExpando] = (el[eventHandlerRefsExpando] || [])
    .filter(([t, h], i) => {
      if (types.includes(t)) {
        el.removeEventListener(t, h)
        return false
      }
      return true
    })
}

function serialize(params, prefix) {
  const query = Object.keys(params).map((key) => {
    const value  = params[key];

    if (params.constructor === Array)
      key = `${prefix}[]`;
    else if (params.constructor === Object)
      key = (prefix ? `${prefix}[${key}]` : key);

    if (value === null)
      return `${key}=`

    if (typeof value === 'object')
      return serialize(value, key);
    else
      return `${key}=${encodeURIComponent(value)}`;
  });

  return [].concat.apply([], query).join('&');
}
