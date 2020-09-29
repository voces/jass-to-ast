import fs from "fs";
import parser from "../../src/parser.js";

it("smoke Blizzard.j", () => {
	const source = fs.readFileSync("test/data/Blizzard.j", "utf-8");

	expect(parser(source)).toMatchSnapshot();
});
