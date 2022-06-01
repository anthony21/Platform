function isDarkMode () {
  if (window.userTheme === 'dark') {
    return true
  }

  if (window.userTheme === 'light') {
    return false
  }

  return window.matchMedia('(prefers-color-scheme: dark)').matches
}

export function updateAmchartsTheme () {
  if (isDarkMode()) {
    am4core.useTheme(am4themes_dark)
  } else {
    am4core.useTheme(am4themes_animated)
  }
}
