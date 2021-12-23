const fs = require('fs');
const jsdom = require('jsdom');
const Sanscript = require('./sanscript');

const xsltSheet = fs.readFileSync('./xslt/tei-to-html-reduced.json',{encoding:'utf-8'});

//const dir = '../../../mss/';
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

const getRepo = (xmlDoc) => {

    const names = new Map([
        ['Bibliothèque nationale de France. Département des Manuscrits','BnF'],
        ['Bibliothèque nationale de France. Département des Manuscrits.','BnF'],
        ['Staats- und UniversitätsBibliothek Hamburg Carl von Ossietzky','Hamburg Stabi'],
        ['Bodleian Library, University of Oxford','Oxford'],
        ['Cambridge University Library','Cambridge'],
        ['Bibliothèque universitaire des langues et civilisations','BULAC'],
        ['Private collection','private']
    ]);
    const repo = xmlDoc.querySelector('repository > orgName').textContent.replace(/\s+/g,' ');
    return names.get(repo); 
};

const getCote = function(xmlDoc) {
    const txt = xmlDoc.querySelector('idno[type="shelfmark"]').textContent || '';
    const sort = txt.replace(/\d+/g,((match) => {
        return match.padStart(4,'0');
    }));
    return {text: txt, sort: sort};
};

const getPersNames = function(xmlDoc) {
    return [...xmlDoc.querySelectorAll('persName')].map(el => {return {name: el.innerHTML, role: el.getAttribute('role') || ''}});
};

const getAuthors = function(xmlDoc) {
    return [...xmlDoc.querySelectorAll('author')].map(el => {return {name: el.innerHTML, role: 'author'}});
}

const getScribes = function(xmlDoc) {
    const els = [...xmlDoc.querySelectorAll('handNote[scribeRef]')];
    const scribes = new Map([
        ['#ArielTitleScribe','Ariel\'s title scribe'],
        ['#EdouardAriel','Edouard Ariel'],
        ['#PhEDucler','Philippe Étienne Ducler'],
        ['#DuclerScribe','Ducler\'s scribe'],
        ['#UmraosinghSherGil','Umraosingh Sher-Gil']
    ]);
    return els.map(el => scribes.get(el.getAttribute('scribeRef')))
        .filter(el => el !== undefined)
        .map(el => {return {name: el, role: 'scribe'}});
};

const fileredux = function(acc,cur,cur1) {
    const txt = Sanscript.t(
        cur.name.replace(/[\n\s]+/g,' ').trim(),
        'tamil','iast');
    return acc + 
`<tr>
<td>
${txt}
</td>
<td>
${cur.role}
</td>
<td><a href="${cur1.fname}">${cur1.cote.text}</a></td>
<td>
${cur1.repo}
</td>
<td>
${cur1.title}
</td>
</tr>\n`;
};

const readfiles = function(arr) {
    const tab = arr.map((f) => 
    {
        const str = fs.readFileSync(f,{encoding:'utf-8'});
        const fname = `../../../${f}`;
        const dom = new jsdom.JSDOM('');
        const parser = new dom.window.DOMParser();
        const xmlDoc = parser.parseFromString(str,'text/xml');
        const cote = getCote(xmlDoc);
        const repo = getRepo(xmlDoc);
        const peeps = [...getAuthors(xmlDoc),...getScribes(xmlDoc),...getPersNames(xmlDoc)];
        return {
            cote: cote,
            title: xmlDoc.querySelector('titleStmt > title').textContent.replace(/&/g,'&#38;'),
            repo: repo,
            fname: fname,
            persons: peeps
        };
    });
    /*
    tab.sort((a,b) => {
        if(a.sort  b.sort) return -1;
        else return 1;
    });
    */
    const template = new jsdom.JSDOM(fs.readFileSync('persons-template.html',{encoding:'utf8'})).window.document;
    const table = template.querySelector('#index').firstElementChild;
    const tstr = tab.reduce((acc, cur) => {
        if(cur.persons.length > 0) {
            const lines = [...cur.persons].reduce((acc2,cur2) => fileredux(acc2,cur2,cur),'');
            return acc + lines;
        }
        else return acc;
    },'');
    const thead = '<tr id="head"><th>Person</th><th>Role</th><th class="sorttable_alphanum">Shelfmark</th><th>Repository</th><th>Title</th></tr>';
    table.innerHTML = thead + tstr;
    fs.writeFile('persons.html',template.documentElement.outerHTML,{encoding: 'utf8'},function(){return;});
};
