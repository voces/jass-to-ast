import { map as classes, List } from "./types.js";

// eslint-disable-next-line prefer-const
let fin = false;

export const o = (fn) => (result, ...args) => {
	program = { comments: [] };
	return fin ? fn(result, ...args) : result;
};

export const nil = () => null;

export const keywords = [
	"null",
	"globals",
	"endglobals",
	"code",
	"handle",
	"integer",
	"real",
	"boolean",
	"string",
	"constant",
	"array",
	"true",
	"false",
	"native",
	"nothing",
	"takes",
	"returns",
	"function",
	"endfunction",
	"if",
	"then",
	"endif",
	"else",
	"elseif",
	"return",
	"loop",
	"endloop",
	"not",
	"debug",
];

const flat = (arr, depth = Infinity) => {
	if (!depth) return arr.slice();
	if (!Array.isArray(arr)) return arr;
	return arr.reduce(
		(acc, cur) => {
			if (Array.isArray(cur) && !(cur instanceof List))
				acc.push(...flat(cur, depth - 1));
			else acc.push(cur);
			return acc;
		},
		arr.constructor === Array ? [] : new arr.constructor(),
	);
};

const reject = {};
const e = (fn = (data) => data) => {
	fn.index = (index) => e((data) => (fn(data) || [])[index]);
	fn.first = () => e((data) => (fn(data) || [])[0]);
	fn.second = () => e((data) => fn(data)[1]);
	fn.map = (fn2) => e((data) => fn(data).map(fn2));
	fn.filter = (fn2) => e((data) => fn(data).filter(fn2));
	fn.clean = () =>
		e((data) => fn(data).filter((v) => v !== null && v !== undefined));
	fn.fn = (fn2) => e((data) => fn2(fn(data)));
	fn.pick = (...args) =>
		e((data) => {
			data = fn(data);
			if (Array.isArray(data))
				return data
					.map((v, i) => {
						if (typeof args[i] !== "function")
							return args[i] ? v : reject;
						return args[i](v);
					})
					.filter((v) => v !== reject);
		});
	fn.flat = (depth = Infinity) => e((data) => flat(fn(data), depth));
	fn.join = (delim = "") => e((data) => fn(data).join(delim));
	fn.arr = () => e((data) => [fn(data)]);
	fn.obj = (...names) =>
		e((data) => {
			data = fn(data) || [];
			data = data.map((v, i) => [names[i], v]);
			return Object.fromEntries(data);
		});
	fn.assign = (obj) => e((data) => Object.assign(fn(data), obj));
	fn.kind = (kind) => {
		const klass = classes[kind];
		if (klass) return e((data) => new klass(fn(data)));
		return e((data) => ({ kind, data: fn(data) }));
	};
	fn.dev = (tag) => e((data) => ({ kind: "dev", tag, data: fn(data) }));
	fn.reorder = (...newPos) =>
		e((data) => {
			data = fn(data);
			const arr = [];
			for (let i = 0; i < newPos.length; i++) arr.push(data[newPos[i]]);
			return arr;
		});
	fn.commentable = (commentName = "comment") =>
		e((data) => {
			data = fn(data);
			if (
				data &&
				Array.isArray(data.data) &&
				data.data[data.data.length - 1]
			)
				data[commentName] = data.data[data.data.length - 1];
			return data;
		});
	fn.lastAsComment = (commentName = "comment") =>
		e((data) => {
			data = fn(data);
			if (
				data &&
				Array.isArray(data) &&
				data[data.length - 2] &&
				data[data.length - 1]
			)
				data[data.length - 2][commentName] = data[data.length - 1];

			return data.slice(0, -1);
		});

	return fn;
};

export const string = e().flat().join();

export const removeNulls = (obj) =>
	Object.fromEntries(
		Object.entries(obj).filter(
			([, v]) => v && !(Array.isArray(v) && v.length === 0),
		),
	);

export let program = { comments: [] };
