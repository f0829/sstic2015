__ = document;
$$$ = 'stage5';
$$_$ = 'load';
$_$$ = ' ';
_$$$$$ = 'user';
_$$$ = 'div';
$$_$$$ = 'navigator';
$$_$$ = 'preferences';
$_$$$ = 'to';
$$$_$ = 'href';
$$$$_ = '=';
$$$$$ = 'chrome';
_$$$$ = '"';
$_$$$$ = 'Agent';
$$$_$$ = 'down';
$$$$_$ = 'import';
$ = '<b>Failed to load stage5</b>';
___ = 'write';
____ = 'getElementById';
_$_ = 'raw';
$$ = window;
__$ = window.crypto.subtle;
__$_ = 'decrypt';
___$ = 'status';
$____ = 'importKey';
_______ = 0;
__$__ = 'then';
_$____ = 'digest';
__$___ = 'innerHTML';
___$__ = { name: 'SHA-1' };
____$_ = data;
_____$ = hash;
_$_____ = Blob;
___$___ = URL;
____$__ = 'createObjectURL';
______$ = 'type';
$_______ = 'application/octet-stream';
_$______ = 'name';
__$_____ = 'AES-CBC';
___$____ = 'iv';
____$___ = '<a href="';
_____$__ = '" download="stage5.zip">download stage5</a>';
______$_ = '(';
_______$ = ')';
$________ = 'setTimeout';
_________ = parseInt;
__________ = window['navigator']['userAgent'];
____________ = 'length';
_____________ = 'substr';
______________ = 1;
_______________ = 2;
________________ = 8;
_________________ = 16;
$_$ = 1000;
__________________ = 'indexOf';
___________________ = 'charCodeAt';
____________________ = 'push';
______________________ = Uint8Array;
________________________ = '';
_________________________ = 'byteLength';
__________________________ = 'toString';
document['write']('<h1>Download manager</h1>');
document['write']('<div id="status"><i>loading...</i></div>');
document['write']('<div style="display:none"><a target="blank" href="chrome://browser/content/preferences/preferences.xul">Back to preferences</a></div>');
function _____(______) {
    _ = [];
    for (___________ = 0; ___________ < ______['length']; ++___________)
        _['push'](______['charCodeAt'](___________));
    return new Uint8Array(_);
}
function _____________________(______) {
    _ = [];
    for (___________ = 0; ___________ < ______['length'] / 2; ++___________)
        _['push'](parseInt(______['substr'](___________ * 2, 2), 16));
    return new Uint8Array(_);
}
function _______________________(________) {
    ______ = '';
    for (___________ = 0; ___________ < ________['byteLength']; ++___________) {
        ___ = ________[___________]['toString'](16);
        if (___['length'] < 2)
            ______ += 0;
        ______ += ___;
    }
    return ______;
}
function ___________________________() {
    $_ = _____(__________['substr'](__________['indexOf']('(') + 1, 16));
    _$__ = _____(__________['substr'](__________['indexOf'](')') - 16, 16));
    _$ = {};
    _$['name'] = 'AES-CBC';
    _$['iv'] = $_;
    _$['length'] = _$__['length'] * 8;
    __$['importKey']('raw', _$__, _$, false, ['decrypt'])['then'](function (_$___) {
        __$['decrypt'](_$, _$___, _____________________(data))['then'](function (___$_) {
            ____$ = new Uint8Array(___$_);
            __$['digest'](___$__, ____$)['then'](function (____$$) {
                if (_____$ == _______________________(new Uint8Array(____$$))) {
                    _____$_ = {};
                    _____$_['type'] = 'application/octet-stream';
                    _____$ = new Blob([____$], _____$_);
                    __$____ = URL['createObjectURL'](_____$);
                    document['getElementById']('status')['innerHTML'] = '<a href="' + __$____ + '" download="stage5.zip">download stage5</a>';
                } else {
                    document['getElementById']('status')['innerHTML'] = '<b>Failed to load stage5</b>';
                }
            });
        }).catch(function () {
            document['getElementById']('status')['innerHTML'] = '<b>Failed to load stage5</b>';
        });
    }).catch(function () {
        document['getElementById']('status')['innerHTML'] = '<b>Failed to load stage5</b>';
    });
}
window['setTimeout'](___________________________, 1000);
