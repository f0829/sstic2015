var fs = require('fs');

var esprima = require('esprima');
var estraverse = require('estraverse');
var escodegen = require('escodegen');

var filename = process.argv[2];
var ast = esprima.parse(fs.readFileSync(filename));

function simplify_node(node) {
    if ((node.type == 'BinaryExpression') &&
        (node.left.type == 'Literal') &&
        (node.right.type == 'Literal')) {
        if (node.operator == '+') {
            return {
                type: 'Literal',
                value: node.left.value + node.right.value,
                raw: node.left.raw + node.right.raw
            };
        } else if (node.operator == '*') {
            return {
                type: 'Literal',
                value: node.left.value * node.right.value,
                raw: node.left.raw * node.right.raw
            };
        }
    }
    return node;
}

function simplify_ast(ast) {
    var assignments = {};
    var renaming = {};
    var f_count = 0;
    var scopeChain = [];

    estraverse.traverse(ast, {
        enter: function(node, parent) {
            var scopeName;
            if (node.type == 'FunctionDeclaration')
                scopeName = 'function_' + node.id.name;

            if (node.type == 'Program')
                scopeName = 'program';

            if (scopeName) {
                scopeChain.push(scopeName);
                assignments[scopeName] = {};
                renaming[scopeName] = {};
            }

            if (node.type == 'Identifier') {
                var currentScope = scopeChain[scopeChain.length - 1];
                k = assignments[currentScope][node.name];
                if (parent.type == 'AssignmentExpression') {
                    /* Node is on the left-hand side of the assignment */
                    if (parent.left == node) {
                        right = parent.right;
                        if (!k) {
                            assignments[currentScope][node.name] = {
                                node: right,
                                ref_count: 1
                            };
                        } else {
                            /* Not the first assignment, increasing ref count */
                            k['ref_count']++;
                        }
                    }
                } else if ((parent.type == 'UpdateExpression') && k) {
                    k['ref_count']++;
                }
                /*else if ((parent.type == 'FunctionDeclaration') && (parent.id == node)) {
                		    renaming[node.name] = "func_" + f_count;
                		    f_count++;
                		} */
            }
        },
        leave: function(node, parent) {
            if ((node.type == 'FunctionDeclaration') || (node.type == 'Program')) {
                scopeChain.pop();
            }
        }
    });

    scopeChain = [];

    result = estraverse.replace(ast, {
        enter: function(node, parent) {
            if (node.type == 'FunctionDeclaration') {
                scopeChain.push('function_' + node.id.name);
            }
            if (node.type == 'Program') {
                scopeChain.push('program');
            }

            if (node.type == 'Identifier') {
                var currentScope = scopeChain[scopeChain.length - 1];
                k = assignments[currentScope][node.name] || assignments['program'][node.name];

                if ((parent.type == 'AssignmentExpression') && (parent.left == node) ||
                    (parent.type == 'UpdateExpression')) {
                    return node;
                }
                if (k && k['ref_count'] == 1) {
                    if ((k.node.type == 'Literal') ||  (k.node.type == 'Identifier')) {
                        return k.node;
                    }
                }
                /*
		if (renaming[node.name]) {
		    node.name = renaming[node.name];
		}
		*/
            }
            return simplify_node(node);
        },
        leave: function(node, parent) {
            if ((node.type == 'FunctionDeclaration') ||  (node.type == 'Program')) {
                scopeChain.pop();
            }
        }
    });

    return result;
}

new_code = ""
do {
    old_code = new_code;
    ast = simplify_ast(ast);
    new_code = escodegen.generate(ast);
}
while (new_code != old_code);

console.log(new_code);