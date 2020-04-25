module.exports = {
	parser: '@typescript-eslint/parser', 
	plugins: ["@typescript-eslint"],
    extends: [
		"plugin:@typescript-eslint/eslint-recommended",
		"plugin:@typescript-eslint/recommended",
		"verit"
	],
	env: { jest: true },
	rules: {
		"no-extra-parens": "off",
		"@typescript-eslint/no-extra-parens": ["error"]
	}
};