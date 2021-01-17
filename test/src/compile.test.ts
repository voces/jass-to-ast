import fs from "fs/promises";

import { build } from "../../src/grammar/utils.js";

it("compiled", async () => {
	const oldCompiled = await fs.readFile("./src/grammar/jass.js", "utf-8");
	const newCompiled = await build();

	try {
		expect(newCompiled).toEqual(oldCompiled);
	} catch (err) {
		throw new Error(
			"jass.js does not match generated file from jass.ne. Try to run `npm run build`",
		);
	}
});
