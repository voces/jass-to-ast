import fs from "fs/promises";

import compile from "../../src/grammar/compile.js";

it("compiled", async () => {
	const source = await fs.readFile("./src/grammar/jass.ne", "utf-8");
	const oldCompiled = await fs.readFile("./src/grammar/jass.js", "utf-8");

	try {
		expect(compile(source)).toEqual(oldCompiled);
	} catch (err) {
		throw new Error(
			"jass.js does not match generated file from jass.ne. Try to run `npm run build`",
		);
	}
});
