from pygments.lexer import RegexLexer, include
from pygments.token import *

__all__ = [ 'ST20DisLexer' ]

class ST20DisLexer(RegexLexer):
    name = 'ST20Dis'
    aliases = ['st20']
    filenames = ['*.asm']

    tokens = {
            'root': [
                include('keyword'),
                (r';.*', Comment),
                (r'\s+', Text),
                (r'"[^"]*"', String),
                (r"'[^']*'", String),
                (r'#-?[0-9a-f]+\b', Number.Hex),
                (r'[0-9a-f]+:', Name.Label),
                (r'(sub|loc|str)_[0-9a-f]+:?', Name.Label),
                (r'[0-9a-f]{2,2}\s', String),
                (r'\*\*\s', String),
                (r'(.string|.db)', String),
                (r'\[&?var_[0-9]+\]', Name.Constant),
                (r'\[(loc|str|arg)_[0-9a-f]+\]', Name.Constant)
                ],
            'keyword': [
                (r'(rem|and|gt|ajw|ldc|stl|mint|ldnlp|gajw|ldpi|out|ldlp|in|ldl|cj|j|lb|adc|xor|sb|ssub|wsub|eqc|ret|call|gcall|bsub|dup|nop'
                    r')\b', Keyword)
                ]
            }
