import getCSRFToken from 'utils/csrf'

export function fetchTurbo ({ url, body = {} }) {
  const token = getCSRFToken()

  return fetch(url, {
    method: 'POST',
    body: new URLSearchParams({ authenticity_token: token, ...body }),
    headers: {
      'X-CSRF-Token': token,
      Accept: 'text/vnd.turbo-stream.html, text/html, application/xhtml+xml'
    }
  }).then((response) => response.text())
    .then((response) => {
      document.body.insertAdjacentHTML('afterend', response)
    })
}
