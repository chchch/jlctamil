import Hypher from './hypher.mjs';
import { hyphenation_ta } from './ta.mjs';
'use strict';

const JLCConvert = (function() {
    const _state = {
        parEl: null,
        hyphenator: {
            ta: new Hypher(hyphenation_ta),
        }
    };
    
    const init = function(par) {

        _state.parEl = par || document.body; 
        if(!_state.parEl.lang) _state.parEl.lang = 'en';

        const walker = document.createTreeWalker(_state.parEl,NodeFilter.SHOW_ALL);
        var curnode = walker.currentNode;
        while(curnode) {
            if(curnode.nodeType === Node.ELEMENT_NODE) {
                if(!curnode.lang) curnode.lang = curnode.parentNode.lang;
            }
            else if(curnode.nodeType === Node.TEXT_NODE) {
                if(curnode.parentNode.lang === 'ta-Taml') {
                    curnode.data = prettify(curnode.data);
                }
            }
            curnode = walker.nextNode();
        }
        
    };

    const prettify = function(str) {
        return str.replaceAll(/\|/g,'।')
                  .replaceAll('//','॥')
                  .replaceAll(/@@/g,'\u0B85\u200D\u0BC7')
                  .replaceAll(/@/g,'\u0B85\u200D\u0BC6')
                  .replaceAll(/#/g,'\u0B85\u200D\u0BBE');
    };

    return {
        init: init,
    };
}());

export { JLCConvert };
