import fs from "fs";
import parser from "../../src/parser.js";

it("smoke UIUtils.j", () => {
	const source = fs.readFileSync("test/data/UIUtils.j", "utf-8");

	expect(parser(source)).toMatchSnapshot();
});
