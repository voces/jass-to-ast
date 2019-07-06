
import nearley from "@voces/nearley";
import compile from "@voces/nearley/lib/compile.js";
import generate from "@voces/nearley/lib/generate.js";
import nearleyGrammar from "@voces/nearley/lib/nearley-language-bootstrapped.js";

export default languageSpec => {

	// Parse the grammar source into an AST
	const grammarParser = new nearley.Parser( nearleyGrammar );
	grammarParser.feed( languageSpec );
	const grammarAst = grammarParser.results[ 0 ];

	// Compile the AST into a set of rules
	const grammarInfoObject = compile( grammarAst, {} );

	// Generate JavaScript code from the rules
	return generate.module( grammarInfoObject, "grammar" );

};
