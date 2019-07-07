
import { describe, it } from "verit-test";

import { expectParse } from "../util.js";

describe( "parser", () => {

	describe( "globals", () => {

		it( "empty globals block", () => expectParse( `
			globals
			endglobals
			`, `
			Program [
				Globals {}
			]
		` ) );

		it( "commented", () => expectParse( `
			globals //foo
			//bar
			endglobals //baz
		`, `
			Program [
				Globals {
					comment: Comment "foo"
					globals: Statements [
						Comment "bar"
					]
					endComment: Comment "baz"
				}
			]
		` ) );

		it( "with globals", () => expectParse( `
			globals
				constant force sheep = CreateForce()
				real salesTax = 1.5
				real specialTax = salesTax
			endglobals
		`, `
			Program [
				Globals {
					globals: Statements [
						Variable {
							type: String "force"
							name: String "sheep"
							value: Call {
								name: String "CreateForce"
							}
							constant: Boolean true
						}
						Variable {
							type: String "real"
							name: String "salesTax"
							value: Number 1.5
						}
						Variable {
							type: String "real"
							name: String "specialTax"
							value: Name "salesTax"
						}
					]
				}
			]
		` ) );

	} );

	it( "natives", () => expectParse( `
		native FuncName takes argType1 argName1, argType2 argName2 returns returnType //with comments
		constant native foo takes nothing returns nothing
	`, `
		Program [
			Native {
				name: String "FuncName"
				params: Params [
					Param {
						type: String "argType1"
						name: String "argName1"
					}
					Param {
						type: String "argType2"
						name: String "argName2"
					}
				]
				returns: String "returnType"
				comment: Comment "with comments"
			}
			Native {
				name: String "foo"
				constant: Boolean true
			}
		]
	` ) );

	describe( "functions", () => {

		it( "comments", () => expectParse( `
			function funcName takes argType1 argName1, argType2 argName2 returns returnType //function-comment

				//internal-comment

			endfunction //endfunction-comment
		`, `
			Program [
				JASSFunction {
					name: String "funcName"
					params: Params [
						Param {
							type: String "argType1"
							name: String "argName1"
						}
						Param {
							type: String "argType2"
							name: String "argName2"
						}
					]
					returns: String "returnType"
					comment: Comment "function-comment"
					statements: Statements [
						EmptyLine {}
						Comment "internal-comment"
						EmptyLine {}
					]
					endComment: Comment "endfunction-comment"
				}
			]
		` ) );

		it( "multiple functions", () => expectParse( `
			function foo takes nothing returns nothing
			endfunction

			function bar takes nothing returns nothing
			endfunction
		`, `
			Program [
				JASSFunction {
					name: String "foo"
				}
				EmptyLine {}
				JASSFunction {
					name: String "bar"
				}
			]
		` ) );

		describe( "locals", () => {

			it( "can define locals", () => expectParse( `
				function foo takes nothing returns nothing
					local varType1 varName1

					local varType2 varName2 = "string with \\"quotes\\""
					local varType3 varName3 = 'abcd'

					local varType4 varName4 = 0
					local varType5 varName5 = 010
					local varType6 varName6 = 0x10
					local varType7 varName7 = $10

					local varType8 varName8 = 0.1

					local varType9 varName9 = true
					local varType10 varName10 = false

					local varType11 varName11 = (1 + 2)
					local varType12 varName12 = varName11
				endfunction
			`, `
				Program [
					JASSFunction {
						name: String "foo"
						statements: Statements [
							Variable {
								type: String "varType1"
								name: String "varName1"
							}
							EmptyLine {}
							Variable {
								type: String "varType2"
								name: String "varName2"
								value: String "string with \\\\\\"quotes\\\\\\""
							}
							Variable {
								type: String "varType3"
								name: String "varName3"
								value: FourCC "abcd"
							}
							EmptyLine {}
							Variable {
								type: String "varType4"
								name: String "varName4"
								value: Number 0
							}
							Variable {
								type: String "varType5"
								name: String "varName5"
								value: Number 8
							}
							Variable {
								type: String "varType6"
								name: String "varName6"
								value: Number 16
							}
							Variable {
								type: String "varType7"
								name: String "varName7"
								value: Number 16
							}
							EmptyLine {}
							Variable {
								type: String "varType8"
								name: String "varName8"
								value: Number 0.1
							}
							EmptyLine {}
							Variable {
								type: String "varType9"
								name: String "varName9"
								value: Boolean true
							}
							Variable {
								type: String "varType10"
								name: String "varName10"
								value: Boolean false
							}
							EmptyLine {}
							Variable {
								type: String "varType11"
								name: String "varName11"
								value: Parens BinaryOp {
									left: Number 1
									operator: String "+"
									right: Number 2
								}
							}
							Variable {
								type: String "varType12"
								name: String "varName12"
								value: Name "varName11"
							}
						]
					}
				]
			` ) );

		} );

		describe( "calls", () => {

			it( "with lots of parens", () => expectParse( `
				function foo takes nothing returns nothing
					call SaveStr(A,(((B[i]))),(-xG),(oG))
				endfunction
			`, `
				Program [
					JASSFunction {
						name: String "foo"
						statements: Statements [
							Call {
								name: String "SaveStr"
								args: Args [
									Name "A"
									Parens Parens Parens ArrayRef {
										name: String "B"
										prop: Name "i"
									}
									Parens UnaryOp {
										operator: String "-"
										expr: Name "xG"
									}
									Parens Name "oG"
								]
								statement: Boolean true
							}
						]
					}
				]
			` ) );

		} );

	} );

	describe( "if-then-else", () => {

		it( "empty", () => expectParse( `
			function foo takes nothing returns nothing
				if true then
				endif
			endfunction
		`, `
			Program [
				JASSFunction {
					name: String "foo"
					statements: Statements [
						IfThenElse {
							condition: Boolean true
						}
					]
				}
			]
		` ) );

		it( "simple", () => expectParse( `
			function foo takes nothing returns nothing
				if true then
					set bar = buz
				endif
			endfunction
		`, `
			Program [
				JASSFunction {
					name: String "foo"
					statements: Statements [
						IfThenElse {
							condition: Boolean true
							then: Statements [
								JASSSet {
									name: String "bar"
									value: Name "buz"
								}
							]
						}
					]
				}
			]
		` ) );

		it( "else", () => expectParse( `
			function foo takes nothing returns nothing
				if true then
					set bar = buz
				else
					set bar = qux
				endif
			endfunction
		`, `
			Program [
				JASSFunction {
					name: String "foo"
					statements: Statements [
						IfThenElse {
							condition: Boolean true
							then: Statements [
								JASSSet {
									name: String "bar"
									value: Name "buz"
								}
							]
							elses: Array [
								Else {
									statements: Statements [
										JASSSet {
											name: String "bar"
											value: Name "qux"
										}
									]
								}
							]
						}
					]
				}
			]
		` ) );

		it( "elseif", () => expectParse( `
			function foo takes nothing returns nothing
				if true then
					set bar = buz
				elseif false then
					set bar = qux
				endif
			endfunction
		`, `
			Program [
				JASSFunction {
					name: String "foo"
					statements: Statements [
						IfThenElse {
							condition: Boolean true
							then: Statements [
								JASSSet {
									name: String "bar"
									value: Name "buz"
								}
							]
							elses: Array [
								ElseIf {
									condition: Boolean false
									statements: Statements [
										JASSSet {
											name: String "bar"
											value: Name "qux"
										}
									]
								}
							]
						}
					]
				}
			]
		` ) );

		it( "elseif with else", () => expectParse( `
			function foo takes nothing returns nothing
				if true then
					set bar = buz
				elseif false then
					set bar = qux
				else
					set bar = thud
				endif
			endfunction
		`, `
			Program [
				JASSFunction {
					name: String "foo"
					statements: Statements [
						IfThenElse {
							condition: Boolean true
							then: Statements [
								JASSSet {
									name: String "bar"
									value: Name "buz"
								}
							]
							elses: Array [
								ElseIf {
									condition: Boolean false
									statements: Statements [
										JASSSet {
											name: String "bar"
											value: Name "qux"
										}
									]
								}
								Else {
									statements: Statements [
										JASSSet {
											name: String "bar"
											value: Name "thud"
										}
									]
								}
							]
						}
					]
				}
			]
		` ) );

	} );

	describe( "edge cases", () => {

		it( "multiple left expressions", () => expectParse( `
			globals
				boolean test = a==b[c]or d==e[f]or g==h[i]or j
			endglobals
		`, `
			Program [
				Globals {
					globals: Statements [
						Variable {
							type: String "boolean"
							name: String "test"
							value: BinaryOp {
								left: BinaryOp {
									left: BinaryOp {
										left: BinaryOp {
											left: Name "a"
											operator: String "=="
											right: ArrayRef {
												name: String "b"
												prop: Name "c"
											}
										}
										operator: String "or"
										right: BinaryOp {
											left: Name "d"
											operator: String "=="
											right: ArrayRef {
												name: String "e"
												prop: Name "f"
											}
										}
									}
									operator: String "or"
									right: BinaryOp {
										left: Name "g"
										operator: String "=="
										right: ArrayRef {
											name: String "h"
											prop: Name "i"
										}
									}
								}
								operator: String "or"
								right: Name "j"
							}
						}
					]
				}
			]
		` ) );

	} );

	describe( "types", () => {

		it( "works", () => expectParse( `
			type a extends handle
			  type   c    extends    d   //with comment
		`, `
			Program [
				Type {
					base: String "a"
					super: String "handle"
				}
				Type {
					base: String "c"
					super: String "d"
					comment: Comment "with comment"
				}
			]
		` ) );

	} );

} );
