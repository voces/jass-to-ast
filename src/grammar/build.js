/* eslint-disable no-console */

import fs from "fs/promises";

import { build } from "./utils.js";

console.log("reading source...");

build(true).then(async (grammar) => {
	console.log("writing grammar...");
	await fs.writeFile("./src/grammar/jass.js", grammar);
	console.log("done!");
});
