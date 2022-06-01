const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  darkMode: 'class',
  content: [
    './safelist.txt',
    './app/views/**/*.erb',
    './app/components/**/*',
    './app/javascript/**/*.js',
    './app/helpers/*.rb'
  ],
  theme: {
    extend: {
      colors: {
        blue: {
          light: '#1DC3FF',
          DEFAULT: '#03A9F4',
          dark: '#0090DB'
        },
        gray: {
          50: '#FAFAFA',
          100: '#F4F4F5',
          200: '#E4E4E7',
          300: '#D4D4D8',
          400: '#A1A1AA',
          500: '#71717A',
          600: '#52525B',
          700: '#3F3F46',
          800: '#27272A',
          850: '#222225',
          900: '#18181B',
          1000: '#111114',
          1100: '#101013'
        },
        green: {
          light: '#A5DD64',
          DEFAULT: '#8BC34A',
          dark: '#72AA31'
        },
        indigo: {
          light: '#596BCF',
          DEFAULT: '#3F51B5',
          dark: '#26389C'
        },
        orange: {
          light: '#FFB21A',
          DEFAULT: '#FF9800',
          dark: '#E67F00'
        },
        pink: {
          light: '#FF387D',
          DEFAULT: '#E91E63',
          dark: '#D0054A'
        },
        purple: {
          light: '#B641CA',
          DEFAULT: '#9C27B0',
          dark: '#830E97'
        },
        red: {
          light: '#FF5D50',
          DEFAULT: '#F44336',
          dark: '#DB2A1D'
        },
        teal: {
          light: '#1AB0A2',
          DEFAULT: '#009688',
          dark: '#009688'
        },
        yellow: {
          light: '#FFFF55',
          DEFAULT: '#FFEB3B',
          dark: '#E6D222'
        }
      },
      fontFamily: {
        oswald: ['Oswald', 'sans-serif'],
        sans: ['Nunito Sans', ...defaultTheme.fontFamily.sans]
      },
      screens: {
        '3xl': '2560px',
        '4xl': '3440px'
      },
      fontSize: {
        '4.5xl': ['2.5rem', 1]
      },
      boxShadow: {
        '2xld': '0 25px 50px -12px rgba(0, 0, 0, 1)'
      },
      minWidth: {
        lg: '32rem'
      },
      minHeight: {
        '3/5': '60%'
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography')
  ]
}
