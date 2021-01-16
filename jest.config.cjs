module.exports = {
	globals: { "ts-jest": { tsconfig: "tsconfig.json" } },
	moduleFileExtensions: ["ts", "js"],
	transformIgnorePatterns: [
		// "/node_modules/(?!jass-to-ast).+\\.js$",
	],
	transform: {
		"^.+\\.ts$": "ts-jest",
		"^.+\\.js$": "babel-jest",
	},
	testRegex: "(.*\\.test)\\.[tj]s$",
	testEnvironment: "node",
};
