/* eslint-disable no-console */
import fs from "fs/promises";
import compile from "./compile.js";

(async () => {
	try {
		console.log("loading files...");
		const [ne, processors] = await Promise.all([
			fs.readFile("./src/grammar/jass.ne"),
			fs.readFile("./src/grammar/processors.js"),
		]);

		console.log("compiling source...");
		const grammar = compile(`@preprocessor typescript
@{%
${processors}
%}

${ne}`);

		console.log("writing grammar...");
		fs.writeFile("./src/grammar/jass.js", grammar, () => {
			console.log("done!");
		});
	} catch (err) {
		console.error(err);
	}
})();

console.log("reading source...");
// fs.readFile("./src/grammar/jass.ne", "utf-8", (err, source) => {
// 	if (err) throw err;

// 	console.log("compiling source...");
// 	const grammar = compile(source);

// 	console.log("writing grammar...");
// 	fs.writeFile("./src/grammar/jass.js", grammar, () => {
// 		console.log("done!");
// 	});
// });
