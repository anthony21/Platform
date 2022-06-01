export function parseStringSet (values) {
  return values.split(',').filter(s => s.length > 0)
}

export function formatStringSet (values) {
  return values.join(',')
}
