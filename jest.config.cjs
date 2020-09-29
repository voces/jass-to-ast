module.exports = {
	globals: { "ts-jest": { tsConfig: "tsconfig.json" } },
	moduleFileExtensions: ["ts", "js"],
	transformIgnorePatterns: [
		// "/node_modules/(?!jass-to-ast).+\\.js$",
	],
	transform: {
		"^.+\\.ts$": "babel-jest",
		"^.+\\.js$": "babel-jest",
	},
	testRegex: "(.*\\.test)\\.[tj]s$",
	testEnvironment: "node",
};
