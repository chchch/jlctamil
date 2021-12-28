const webpack = require('webpack');
const path = require('path');
module.exports = {
    entry: './index.js',
    target: 'web',
    output: {
        filename: 'mirador.js',
        path: path.resolve(__dirname, 'dist'),
    },
    resolve: {
        fallback: { "url": require.resolve("url/") }
    },
    plugins: [
        new webpack.optimize.LimitChunkCountPlugin({
            maxChunks: 1
        })
    ],
    experiments: {
        outputModule: true,
    },
    output: {
        library: {
            type: 'var',
            name: 'MiradorModule'
        },
    },

};
