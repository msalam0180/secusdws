var gulp 	= require('gulp'),
    dartSass 	= require('sass'),
  	gulpSass 	= require('gulp-sass'),
  	sourcemaps 	= require('gulp-sourcemaps'),
  	postcss 	= require('gulp-postcss'),
    autoprefixer = require('autoprefixer');
    
const sass = gulpSass(dartSass);

var paths = {
  sass: 'scss',
  buildCss: 'css'
};

//compile sass
gulp.task('sass', function () {
    var processors = [
        autoprefixer
    ];
    return gulp.src(paths.sass  + '/**/*.scss')
    	.pipe(sourcemaps.init())
        .pipe(sass({
          includePaths: ['node_modules/susy/sass', '/home/gitlab-runner/node_modules/susy/sass'] // Home dir for build server
        }).on('error', sass.logError))
        .pipe(postcss(processors))
        .pipe(sourcemaps.write('./maps'))
        .pipe(gulp.dest(paths.buildCss));
});


//TODO: add image optimization

//TODO: add JS optimization and concatenation

// Watch Files For Changes, and reloads browser window on SCSS change.
gulp.task('watch', function() {
  gulp.watch(paths.sass  + '/**/*.scss', gulp.series('sass'));
});
