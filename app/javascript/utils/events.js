export const listen = (name, callback) => {
  window.addEventListener(name, callback)
}

export const ignore = (name, callback) => {
  window.removeEventListener(name, callback)
}

export const fire = (name, detail) => {
  window.dispatchEvent(new CustomEvent(name, { detail }))
}
