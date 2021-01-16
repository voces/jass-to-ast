/* eslint-disable no-console */

import fs from "fs";

import compile from "./compile.js";

console.log("reading source...");
fs.readFile("./src/grammar/jass.ne", "utf-8", (err, source) => {
	if (err) throw err;

	console.log("compiling source...");
	const grammar = compile(source);

	console.log("writing grammar...");
	fs.writeFile("./src/grammar/jass.js", grammar, () => {
		console.log("done!");
	});
});
