import nearley from "@voces/nearley";
import grammar from "./grammar/jass.js";

export class AmbiguousError extends Error {}

export * from "./grammar/types.js";

export default (input) => {
	if (input[input.length - 1] !== "\n") input += "\nfin";
	else input += "fin";

	const parser = new nearley.Parser(nearley.Grammar.fromCompiled(grammar));
	parser.feed(input);
	if (parser.results.length > 1) {
		const error = new AmbiguousError(
			"Ambiguous parsing! " + parser.results.length + " results.",
		);
		error.results = parser.results;
		throw error;
	}
	return parser.results[0];
};
