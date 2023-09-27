const subject = require('./`!v expand('%:t:r:r')`');
const { RuleTester } = require('eslint');

const ruleTester = new RuleTester({
  parserOptions: {
    ecmaVersion: 6,
    ecmaFeatures: {
      jsx: true,
    }
  }
});

ruleTester.run('data-test/`!v expand('%:t:r:r')`', subject, {
  valid: [
    {
      code: '${0}'
    },
  ],
  invalid: [
    {
      code: '',
      errors: ['']
    }
  ]
});
