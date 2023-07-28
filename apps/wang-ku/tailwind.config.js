const { createGlobPatternsForDependencies } = require('@nx/react/tailwind');
const { join } = require('path');

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    join(
      __dirname,
      '{src,pages,components,app}/**/*!(*.stories|*.spec).{ts,tsx,html}'
    ),
    ...createGlobPatternsForDependencies(__dirname),
  ],
  theme: {
    extend: {
      fontSize: {
        display: [
          '60px',
          {
            lineHeight: '60px',
          },
        ],
        'heading-1': [
          '48px',
          {
            lineHeight: '58px',
          },
        ],
        'heading-2': [
          '36px',
          {
            lineHeight: '46px',
          },
        ],
        'heading-3': [
          '28px',
          {
            lineHeight: '38px',
          },
        ],
        'heading-4': [
          '24px',
          {
            lineHeight: '32px',
          },
        ],
        'heading-5': [
          '20px',
          {
            lineHeight: '26px',
          },
        ],
        'paragraph-18': [
          '18px',
          {
            lineHeight: '27px',
          },
        ],
        'paragraph-16': [
          '16px',
          {
            lineHeight: '24px',
          },
        ],
        'paragraph-12': [
          '12px',
          {
            lineHeight: '18px',
          },
        ],
        'label-18': [
          '18px',
          {
            lineHeight: '23px',
          },
        ],
        'label-16': [
          '16px',
          {
            lineHeight: '20px',
          },
        ],
        'label-12': [
          '12px',
          {
            lineHeight: '14px',
          },
        ],
      },
      colors: {
        neutral: {
          50: '#E8E8E8',
          100: '#D0D0D0',
          200: '#B9B9B9',
          300: '#A1A1A1',
          400: '#8A8A8A',
          500: '#727272',
          600: '#5B5B5B',
          700: '#595959',
          800: '#262626',
          900: '#000000',
        },
        green: {
          50: '#CCEFD9',
          100: '#AAE5BF',
          200: '#80D89F',
          300: '#55CB80',
          400: '#2ABE60',
          500: '#00B140',
          600: '#00762B',
          700: '#208746',
          800: '#005820',
          900: '#00230D',
        },
      },
    },
  },
  plugins: [],
};
