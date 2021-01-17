import parser from "../src/parser.js";
import { inspect } from "../src/util";

export const trimEmptyLines = (str: string): string => {
	const lines = str.split("\n");

	let start = 0;
	while (lines[start].trim() === "" && start + 1 < lines.length) start++;

	if (start === lines.length) return "";

	let end = lines.length - 1;
	while (lines[end].trim() === "" && end > 0) end--;

	if (end === -1) return "";

	return lines.slice(start, end + 1).join("\n");
};

export const trim = (str: string): string => {
	const lines = trimEmptyLines(str);
	const match = lines.match(/^\s+/);
	if (match) {
		const indent = match[0];
		const regex = new RegExp("^" + indent);
		return lines
			.split("\n")
			.map((line) => line.replace(regex, ""))
			.join("\n");
	}

	return lines;
};

export const parseSnapshot = (value: string) => (): void =>
	expect(inspect(parser(trim(value)))).toMatchSnapshot();
