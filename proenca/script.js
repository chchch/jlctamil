const _state = {
    viewer: null,
};

const processManifest = (data) => {
    const canvases = data.sequences[0].canvases;
    const tiles = canvases.map((canvas) => {
            const manif = canvas.images[0].resource.service;
            manif.width = canvas.width;
            manif.height = canvas.height;
            manif.protocol = 'http://iiif.io/api/image';
            return manif;
        });
    return tiles;
};
const startViewer = (data) => {
    const tiles = processManifest(data);
    const viewer = OpenSeadragon({
            id: 'viewer',
            prefixUrl: '/jlctamil/proenca/images/',
            sequenceMode: true,
            showReferenceStrip: true,
            referenceStripScroll: 'horizontal',
            initialPage: 6,
            tileSources: [tiles],
        });
    
    _state.viewer = viewer;
};

const indexClick = (e) => {
    if(!e.target.dataset.coords) return;

    const scale = 2;
    const parsed = e.target.dataset.coords.split(':').map(x => x*scale);

    if(_state.viewer.currentPage() !== e.target.dataset.page) {
        _state.viewer.goToPage(e.target.dataset.page); 
        _state.viewer.addOnceHandler('open',zoomTo,{coords: parsed});
    }
    else
        zoomTo({userData: {coords: parsed} });
};

zoomTo = (e) => {
    const coords = e.userData.coords;
    const tileImage = _state.viewer.world.getItemAt(0);
    const bounds = tileImage.imageToViewportRectangle(
        parseInt(coords[0]),
        parseInt(coords[2]), 
        coords[1] - coords[0],
        coords[3] - coords[2]
    );
    _state.viewer.removeOverlay('overlay');
    const overlay = document.createElement('div');
    overlay.id = 'overlay';
    overlay.style.background = 'rgba(0,0,0,0.2)';
    _state.viewer.addOverlay({element: overlay, location: bounds});
    _state.viewer.viewport.fitBounds(bounds);
};

init = () => {
    fetch('https://digi.vatlib.it/iiif/MSS_Borg.ind.12/manifest.json')
        .then(res => res.json())
        .then(data => startViewer(data));

    document.getElementById('index').addEventListener('click',indexClick);
};

window.addEventListener('load',init);

