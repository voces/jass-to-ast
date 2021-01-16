import nearley from "nearley";
import compile from "nearley/lib/compile.js";
import generate from "nearley/lib/generate.js";
import nearleyGrammar from "nearley/lib/nearley-language-bootstrapped.js";

export default (languageSpec) => {
	// Parse the grammar source into an AST
	const grammarParser = new nearley.Parser(nearleyGrammar);
	grammarParser.feed(languageSpec);
	const grammarAst = grammarParser.results[0];

	// Compile the AST into a set of rules
	const grammarInfoObject = compile(grammarAst, {});

	// Generate JavaScript code from the rules
	return (
		generate
			.module(grammarInfoObject, "grammar")
			// Move id to below pre-preocessor
			.replace("function id(x) { return x[0]; }\n", "")
			.replace(
				"let Lexer = undefined;",
				"function id(x) { return x[0]; }\nlet Lexer = undefined;",
			)
	);
};
