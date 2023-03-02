//Documentation https://github.com/gruntjs/grunt-contrib-imagemin

module.exports = {
  options: {
    cache: false
  },

  build: {
    files: [{
      expand: true,
      cwd: 'images/src/',
      src: ['**/*.{png,jpg,gif}'],
      dest: 'images/build/'
    }]
  }
};