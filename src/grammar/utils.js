import fs from "fs/promises";

import compile from "./compile.js";

export const build = async (withLogs = false) => {
	const [ne, processors] = await Promise.all([
		fs.readFile("./src/grammar/jass.ne"),
		fs.readFile("./src/grammar/processors.js"),
	]);

	// eslint-disable-next-line no-console
	if (withLogs) console.log("compiling source...");

	const grammar = compile(`@preprocessor typescript
@{%
${processors}
%}

${ne}`);

	return grammar;
};
