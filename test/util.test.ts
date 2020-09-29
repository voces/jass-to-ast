import { trimEmptyLines, trim } from "./util";

describe("trimEmptyLines", () => {
	it("smoke", () => {
		expect(
			trimEmptyLines(
				[
					"     ",
					"\t\t",
					"   hit",
					" ",
					"this",
					" ",
					"",
					"\t",
					"\t ",
					"\n",
				].join("\n"),
			),
		).toEqual(["   hit", " ", "this"].join("\n"));
	});

	it("empty", () => {
		expect(trimEmptyLines(["", " ", ""].join("\n"))).toEqual("");
	});
});

describe("trim", () => {
	it("smoke", () => {
		expect(
			trim(`
            //comments
              this works!
            
            yay
            
        `),
		).toEqual(["//comments", "  this works!", "", "yay"].join("\n"));
	});
});
