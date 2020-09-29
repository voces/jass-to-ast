class Node {
	constructor(data) {
		Object.defineProperty(this, "data", {
			value: data,
			configurable: true,
		});
		if (this.constructor.map) {
			const map = this.constructor.map;
			for (let i = 0; i < map.length; i++)
				if (data[i] !== null && data[i] !== undefined)
					this[map[i]] = data[i];
		}
	}
}

class Comment extends Node {
	static get map() {
		return ["value"];
	}
}
class Name extends Node {
	static get map() {
		return ["value"];
	}
}
class FourCC extends Node {
	static get map() {
		return ["value"];
	}
}

class EmptyLine extends Node {}

class SingleProp extends Node {
	constructor(...args) {
		super(...args);
		Object.defineProperty(this, "data", { enumerable: true });
	}
}
class FuncRef extends SingleProp {}
class ExitWhen extends SingleProp {}
class Return extends SingleProp {}
class Parens extends SingleProp {}
class Debug extends Node {
	static get map() {
		return ["statement"];
	}
}

class Param extends Node {
	static get map() {
		return ["type", "name"];
	}
}

class Globals extends Node {
	static get map() {
		return ["comment", "globals", "endComment"];
	}
}

class Library extends Node {
	static get map() {
		return [
			"name",
			"initializer",
			"requires",
			"comment",
			"blocks",
			"endComment",
		];
	}
	constructor(data) {
		super(data);
		const last = data[data.length - 1];
		if (last.length === 1) this.libraryType = last[0];
		else {
			this.libraryType = last[2];
			this.access = last[0];
		}
	}
}

class Module extends Node {
	static get map() {
		return ["name", "extends", "comment", "blocks", "endComment"];
	}
}

class Requirement extends Node {
	constructor(data) {
		super(data);

		this.name = data[0];
		this.optional = !!data[1];
	}
}

class Variable extends Node {
	static get map() {
		return ["type", "name", "value"];
	}
}

class Native extends Node {
	static get map() {
		return ["name", "params", "returns"];
	}
}

class Call extends Node {
	static get map() {
		return ["name", "args"];
	}
}

class JASSFunction extends Node {
	static get map() {
		return ["name", "params", "returns", "comment", "statements"];
	}
}

class BinaryOp extends Node {
	static get map() {
		return ["left", "operator", "right"];
	}
}

class IfThenElse extends Node {
	static get map() {
		return ["condition", "comment", "then", "elses"];
	}
}

class Else extends Node {
	static get map() {
		return ["comment", "statements"];
	}
}

class ElseIf extends Node {
	static get map() {
		return ["condition", "comment", "statements"];
	}
}

class JASSSet extends Node {
	static get map() {
		return ["name", "value", "prop"];
	}
}

class Loop extends Node {
	static get map() {
		return ["comment", "statements", "returns", "comment", "statements"];
	}
}

class ArrayRef extends Node {
	static get map() {
		return ["name", "prop"];
	}
}

class UnaryOp extends Node {
	static get map() {
		return ["operator", "expr"];
	}
}

class Type extends Node {
	static get map() {
		return ["base", "super"];
	}
}

class List extends Node {
	constructor(arr) {
		super(arr);
		this.body = arr;
		// this.data = arr;

		// // new Array treats arg signature (<int>) special
		// if ( arr && arr.length === 1 && typeof arr[ 0 ] === "number" ) {

		// 	super();
		// 	this[ 0 ] = arr[ 0 ];

		// } else if ( arr ) super( ...arr );
		// else super();
	}
}

class Params extends List {}
class Args extends List {}

class Block extends List {}
class Statements extends Block {}
class Program extends Block {}

export const map = {
	args: Args,
	array_ref: ArrayRef,
	binary_op: BinaryOp,
	call: Call,
	comment: Comment,
	debug: Debug,
	else: Else,
	elseif: ElseIf,
	emptyline: EmptyLine,
	exitwhen: ExitWhen,
	fourcc: FourCC,
	func_ref: FuncRef,
	function: JASSFunction,
	globals: Globals,
	ifthenelse: IfThenElse,
	library: Library,
	loop: Loop,
	name: Name,
	native: Native,
	param: Param,
	params: Params,
	parens: Parens,
	program: Program,
	return: Return,
	set: JASSSet,
	statements: Statements,
	type: Type,
	unary_op: UnaryOp,
	var: Variable,
	requirement: Requirement,
	module: Module,
};

export {
	Args,
	ArrayRef,
	BinaryOp,
	Call,
	Comment,
	Debug,
	Else,
	ElseIf,
	EmptyLine,
	ExitWhen,
	FourCC,
	FuncRef,
	Globals,
	IfThenElse,
	JASSFunction,
	JASSSet,
	Library,
	Requirement,
	List,
	Loop,
	Name,
	Native,
	Node,
	Param,
	Params,
	Parens,
	Program,
	Return,
	SingleProp,
	Statements,
	Type,
	UnaryOp,
	Variable,
	Module,
};
