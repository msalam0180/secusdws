// Based on Drupal default
// https://git.drupalcode.org/project/drupal/blob/8.6.x/core/.eslintrc.json
module.exports = {
  extends: [
    'airbnb',
    'plugin:prettier/recommended'
  ],
  root: true,
  env: {
    amd: true,
    browser: true,
    es6: true,
    jquery: true,
    node: true,
  },
  globals: {
    'Drupal': true,
    'drupalSettings': true,
    'drupalTranslations': true,
    'domready': true,
    'jQuery': true,
    '_': true,
    'matchMedia': true,
    'Backbone': true,
    'Modernizr': true,
    'CKEDITOR': true,
  },
  rules: {
    'consistent-return': ['off'],
    'no-underscore-dangle': ['off'],
    'max-nested-callbacks': ['warn', 3],
    'import/no-mutable-exports': ['warn'],
    'no-plusplus': ['warn', {
      'allowForLoopAfterthoughts': true
    }],
    'no-param-reassign': ['off'],
    'no-prototype-builtins': ['off'],
    'valid-jsdoc': ['warn', {
      'prefer': {
        'returns': 'return',
        'property': 'prop'
      },
      'requireReturn': false
    }],
    'no-unused-vars': ['warn'],
    'operator-linebreak': ['error', 'after', { 'overrides': { '?': 'ignore', ':': 'ignore' } }],
    // Below are custom rules
    'prettier/prettier': [
      'error',
      {
        // eslintIntegration: true,
        // printWidth: 120,
        // singleQuote: true,
        // trailingComma: 'all',
      },
    ],
    'no-console': 0,
  },
  parserOptions: {
    ecmaFeatures: {
      globalReturn: true,
      generators: false,
      objectLiteralDuplicateProperties: false,
      experimentalObjectRestSpread: true,
    },
    ecmaVersion: 2020,
    sourceType: 'module',
  },
  plugins: ['import'],
  settings: {
    'import/core-modules': [],
    'import/ignore': [
      'node_modules',
      '\\.(coffee|scss|css|less|hbs|svg|json)$',
    ],
  }
};
