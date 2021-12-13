const fs = require('fs');
const jsdom = require('jsdom');
const SaxonJS = require('saxon-js');
const xlsx = require('xlsx');
const Sanscript = require('./sanscript');
const document = (new jsdom.JSDOM('')).window.document;

const xsltSheet = fs.readFileSync('xslt/blessings-xlsx.json',{encoding:'utf-8'});
const xsltSheet_clean = fs.readFileSync('xslt/blessings-xlsx-clean.json',{encoding:'utf-8'});

const dir = './mss/';

fs.readdir(dir,function(err,files) {
    if(err)
        return console.log(err);
    const flist = [];
    files.forEach(function(f) {
        if(/^[^_].+\.xml$/.test(f))
            flist.push(dir+f);
    });
    readfiles(flist);
});

const getCote = function(xmlDoc) {
    const txt = xmlDoc.querySelector('idno[type="shelfmark"]').textContent || '';
    const sort = txt.replace(/\d+/g,((match) => {
        return match.padStart(4,'0');
    }));
    return {text: txt, sort: sort};
};

const getBlessings = function(xmlDoc) {
    return xmlDoc.querySelectorAll('seg[function="blessing"], desc[type~="blessing"]');
};

const getPrev = function(e) {
    if(e.previousElementSibling) return e.previousElementSibling;
    if(e.parentNode.previousElementSibling) {
        if(e.parentNode.previousElementSibling.lastChild)
            return e.parentNode.previousElementSibling.lastElementChild;
        else return e.parentNode.previousElementSibling;
    }
    return false;
};

const isFolio = (str) => str === 'folio' || str === 'page' || str === 'plate';

const getMilestone = function(el) {
    const getUnit = (el) => {
        const m = el.ownerDocument.querySelector('extent > measure');
        if(m) return m.getAttribute('unit');
        return '';
    };

    var p = getPrev(el);
    while(p) {
        if(!p) return false;
        if(p.nodeName === 'text') return false;
        if(p.nodeName === 'pb' || 
            (p.nodeName === 'milestone' && isFolio(p.getAttribute('unit')) )
        ) 
            return (p.getAttribute('unit') || getUnit(p) || '') + ' ' + 
                   (p.getAttribute('n') || '');
        p = getPrev(p);
    }
};

const getPlacement = function(el) {
    var p = getPrev(el);
    while(p) {
        if(!p) return '';
        if(p.nodeName === 'text') return '';
        if(p.nodeName === 'milestone') {
            if(isFolio(p.getAttribute('unit')) ) return '';
            const u = (p.getAttribute('unit') || '').replace(/-/g,' ');
            return u + ' ' + (p.getAttribute('n') || '');
        }
        p = getPrev(p);
    }
};
const blessingmap = function(cur,cur1) {
    
    var milestone, inner, placement, synch;
    if(cur.nodeName === 'seg') {
        milestone = getMilestone(cur);
        placement = getPlacement(cur) || '';
        synch = cur.closest('text').getAttribute('synch');
        inner = cur.innerHTML;
    }
    else {
        const loc = cur.querySelector('locus');
        const subtype = cur.getAttribute('subtype') || '';
        milestone = loc ? loc.textContent : '';
        placement = subtype.replace(/\s/g,', ').replace(/-/g,' ');
        synch = cur.getAttribute('synch');
        const q = cur.querySelector('q,quote');
        inner = q ? q.innerHTML : '';
    }
    const unit = synch ? synch.replace(/^#/,'') : '';
    const processed = SaxonJS.transform({
        stylesheetText: xsltSheet,
        sourceText: '<TEI xmlns="http://www.tei-c.org/ns/1.0">'+inner+'</TEI>',
        destination: 'serialized'},'sync');
    const processed2 = SaxonJS.transform({
        stylesheetText: xsltSheet_clean,
        sourceText: '<TEI xmlns="http://www.tei-c.org/ns/1.0">'+inner+'</TEI>',
        destination: 'serialized'},'sync');
    const txt = processed.principalResult.replace(/[\n\s]+/g,' ').replace(/\s%nobreak%/g,'').trim();
    const cleantxt = Sanscript.t(
        processed2.principalResult.replace(/[\n\s]+/g,' ').replace(/\s%nobreak%/g,'').replace(/[|•-]|=(?=\w)/g,'').trim(),
        'tamil','iast');
    const tunai = Array.from(cleantxt.matchAll(/tuṇai/g)).length;
    const ret = document.createElement('tr');
    ret.innerHTML = `<td>${txt}</td><td>${cleantxt}</td><td>${cur1.cote.text}</td><td>${cur1.repo}</td><td>${cur1.title}</td><td>${unit}</td><td>${milestone}</td><td>${placement}</td><td>${tunai}</td>`;
    return ret;
};

const readfiles = function(arr) {
    const tab = arr.map((f) => 
    {
        const str = fs.readFileSync(f,{encoding:'utf-8'});
        const dom = new jsdom.JSDOM('');
        const parser = new dom.window.DOMParser();
        const xmlDoc = parser.parseFromString(str,'text/xml');
        const cote = getCote(xmlDoc);
        const repo = xmlDoc.querySelector('repository > orgName').textContent;
        const blessings = getBlessings(xmlDoc);
        return {
            cote: cote,
            title: xmlDoc.querySelector('titleStmt > title').textContent.replace(/&/g,'&#38;'),
            repo: repo,
            blessings: blessings
        };
    });
    const htmltab = document.createElement('table');
    const tabbod = document.createElement('tbody');
    for(const cur of tab) {
        if(cur.blessings.length > 0) {
            for(const b of cur.blessings)
                tabbod.appendChild(blessingmap(b,cur));
        }
    }
    htmltab.appendChild(tabbod);
    const wb = xlsx.utils.book_new();
    const ws = xlsx.utils.table_to_sheet(htmltab);
    xlsx.utils.book_append_sheet(wb,ws,'blessings');
    xlsx.writeFile(wb,'blessings.xlsx');
};
