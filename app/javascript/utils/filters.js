export function parseFilterValues (filter) {
  return JSON.parse(filter)[1]
}

export function formatFilter (field, values) {
  return JSON.stringify([field, values])
}
