module.exports = {
	extends: ["verit"],
	rules: { "arrow-body-style": ["error", "as-needed"] },
	settings: { react: { version: "16.3" } },
	parserOptions: { project: "./tsconfig.json" },
};
