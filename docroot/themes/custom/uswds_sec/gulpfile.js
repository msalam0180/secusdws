// Based on https://github.com/uswds/uswds-gulp
import { deleteSync } from 'del';
import gulp from 'gulp';
import rename from 'gulp-rename';
import replace from 'gulp-replace';
import svgSprite from 'gulp-svg-sprite';

// Used to get version number from USWDS
// Note: `assert {type: 'json'}` triggers the following warning in the terminal:
//
//   ExperimentalWarning: Importing JSON modules is an experimental feature.
//   This feature could change at any time
//
import pkg from './node_modules/@uswds/uswds/package.json' assert {type: 'json'};

// Sass compilaton dependencies
// https://github.com/dlmanning/gulp-sass#importing-it-into-your-project
import dartSass from 'sass';
import gulpSass from 'gulp-sass';
const sass = gulpSass(dartSass);
import debug from 'gulp-debug';
import dependents from 'gulp-dependents';
import sourcemaps from 'gulp-sourcemaps';
import postcss from 'gulp-postcss';
import csso from 'postcss-csso';
import postcssPresetEnv from 'postcss-preset-env';
import autoprefixer from 'autoprefixer';
import stylelint from 'stylelint';

// JS bundling using Rollup
// https://rollupjs.org/guide/en/#gulp
// https://github.com/rollup/plugins
import { rollup } from 'rollup';
import eslint from '@rollup/plugin-eslint';
import terser from '@rollup/plugin-terser';
import { babel } from '@rollup/plugin-babel';

// Path to USWDS node module to import assets
const USWDS_SRC = './node_modules/@uswds/uswds';

// Browsersync for live reload
import browserSync from 'browser-sync';
const server = browserSync.create();

// Folder paths
const SASS_SRC = './assets/sass';
const IMG_SRC = './assets/img';
const FONTS_SRC = './assets/fonts';
const JS_SRC = './assets/js';
const DEST = './dist';

// Check environment (NODE_ENV is defined in package.json scripts)
const isDev = process.env.NODE_ENV == 'development';

// Copy assets from USWDS node module
// NOTE: This only needs to be run once after upgrading USWDS
// https://github.com/uswds/uswds/releases
gulp.task('copy-uswds-fonts', () => {
  return gulp.src(`${USWDS_SRC}/dist/fonts/**/*.+(woff|woff2)`).pipe(gulp.dest(`${FONTS_SRC}`));
});

gulp.task('copy-uswds-images', () => {
  return gulp.src(`${USWDS_SRC}/dist/img/**/**`).pipe(gulp.dest(`${IMG_SRC}`));
});

gulp.task('copy-uswds-js', () => {
  return gulp.src([`${USWDS_SRC}/dist/js/**/*.js`, `!${USWDS_SRC}/dist/js/**/*.min.js`]).pipe(gulp.dest(`${JS_SRC}`));
});

gulp.task('copy-uswds-assets', gulp.series('copy-uswds-fonts', 'copy-uswds-images', 'copy-uswds-js'));

// PostCSS plugin options
let postcssPlugins = [
  // See .browserslistrc for browser support
  autoprefixer({
    cascade: false,
    grid: true,
  }),
  postcssPresetEnv({
    // Tell PostCSS to not alter the following selectors
    // https://github.com/csstools/postcss-plugins/blob/main/plugin-packs/postcss-preset-env/FEATURES.md
    features: {
      'any-link-pseudo-class': false,
      'focus-visible-pseudo-class': false,
      'focus-within-pseudo-class': false,
      'has-pseudo-class': false,
    },
    preserve: true,// allows plugins to keep original “pre-polyfilled” CSS
  })
];

// Only run certain plugins in development/production
if (isDev) {
  // Only lint in developement
  postcssPlugins.push( stylelint() );
}
else {
  // Only minify in production
  postcssPlugins.push( csso({ forceMediaMerge: false }) );
}

// Compile Sass
// Note: We’re using the “since” option in gulp.src() to cache files that haven’t changed
//       and gulp-dependents to make sure we recompile the parent Sass file.
// https://www.sarthakbatra.com/blog/incremental-sass-builds-with-gulp/
gulp.task('build-sass', (done) => {
  return (
    gulp
      .src(
        [`${SASS_SRC}/*.scss`, `${SASS_SRC}/**/*.scss`, './templates/patterns/**/*.scss'],
        { since: gulp.lastRun('build-sass') }
      )
      .pipe(dependents())
      // Uncomment to log which files were updated
      // .pipe(debug({title: 'dependents:'})) // will print the names of updated files
      .pipe(sourcemaps.init({ largeFile: true }))
      .pipe(
        sass({
          // Note: Dart Sass only supports “expanded” and “compressed”
          // https://github.com/sass/dart-sass/issues/442
          outputStyle: 'compressed',
          precision: 4,// numbers after decimal place
          // Add paths to check when importing partials (e.g. USWDS in node_modules)
          includePaths: [
            `${SASS_SRC}`,
            `${USWDS_SRC}`,
            `${USWDS_SRC}/packages`,
          ],
        })
      ).on('error', sass.logError)
      .pipe(replace(/\buswds @version\b/g, 'based on uswds v' + pkg.version))
      .pipe(postcss(postcssPlugins))
      .pipe(sourcemaps.write('.'))
      // Remove any subfolders (added by gulp-dependents)
      .pipe(rename({dirname: ''}))
      .pipe(gulp.dest(`${DEST}/css`))
      // We need to stream the results for Browsersync
      .pipe(server.stream())
  );
});

// JS bundling using Rollup
// https://rollupjs.org/guide/en/#gulp
// https://github.com/rollup/plugins
gulp.task('build-js', () => {
    return rollup({
      // Note: Use multi-entry plugin for multiple entry points
      // https://github.com/rollup/plugins/tree/master/packages/multi-entry
      input: './assets/js/app.js',
      // ESLint config located in “.eslintrc.cjs”
      plugins: isDev ? [ eslint() ] : null,
    })
    .then(bundle => {
      return bundle.write({
        file: './dist/js/app.min.js',
        format: 'umd',
        name: 'App',// required for UMD
        // Don’t minify in developement to reduce compile time
        plugins: !isDev ? [ terser() ] : null,
        sourcemap: true,
      });
    });
});

// SVG sprite tasks
gulp.task('build-sprite', (done) => {
  gulp
    .src(`${IMG_SRC}/usa-icons/**/*.svg`, {
      allowEmpty: true,
    })
    .pipe(svgSprite({
      shape: {
        dimension: {
          // Set maximum dimensions
          maxWidth: 24,
          maxHeight: 24,
        },
        id: {
          separator: '-',
        },
        spacing: {
          // Add padding
          padding: 0,
        },
      },
      mode: {
        symbol: true, // Activate the «symbol» mode
      },
    }))
    .on('error', function (error) {
      console.log('There was an error');
    })
    .pipe(gulp.dest(`${IMG_SRC}`))
    .on('end', function () {
      done();
    });
});

gulp.task('rename-sprite', (done) => {
  gulp
    .src(`${IMG_SRC}/symbol/svg/sprite.symbol.svg`, {
      allowEmpty: true,
    })
    .pipe(rename(`${IMG_SRC}/sprite.svg`))
    .pipe(gulp.dest(`./`))
    .on('end', function () {
      done();
    });
});

gulp.task('clean-sprite', (cb) => {
  cb();
  return deleteSync(`${IMG_SRC}/symbol`);
});

gulp.task('svg-sprite', gulp.series('build-sprite', 'rename-sprite', 'clean-sprite'));

// Copy static assets to dist folder
gulp.task('copy-fonts', () => {
  return gulp.src(`${FONTS_SRC}/**/**`, {base: './assets/'})// preserve subfolders
  .pipe(gulp.dest(`${DEST}`));
});

gulp.task('copy-images', () => {
  return gulp.src(`${IMG_SRC}/**/**`, {
    base: './assets/',
    since: gulp.lastRun('copy-images'),
  })
  .pipe(dependents())
  .pipe(gulp.dest(`${DEST}`));
});

// Copy static assets to dist folder
gulp.task('copy-static-assets', gulp.series('copy-fonts', 'copy-images'));

// Clean dist folder
// https://github.com/sindresorhus/del#beware
gulp.task('clean-dist', (cb) => {
  cb()
  return deleteSync([`${DEST}/**`, `!${DEST}`]);
});

// Build task
gulp.task('build', gulp.series(
  'clean-dist',
  'svg-sprite',
  'build-js',
  'copy-static-assets',
  'build-sass',
));

// Create local server with Browsersync and watch files
gulp.task('serve', gulp.series('build', () => {
    server.init({
      proxy: 'sec.lndo.site',
      startPath: '/patterns',
      ghostMode: false,
      notify: false,
      open: false,
      port: 3000,
      ui: false,
    });

    // Watch Sass files
    gulp.watch([`${SASS_SRC}/**/*.scss`, './templates/**/*.scss'], gulp.series('build-sass'));

    // Watch JS
    // Note: Each JS file needs to be manually added to the “build-js” task
    gulp.watch(`${JS_SRC}/**/*.js`, gulp.series('build-js'));

    // Watch images, copy to dist on change
    gulp.watch(`${IMG_SRC}/**/**`, gulp.series('copy-images'));

    // Reload page when twig or yml files change
    // gulp.watch(['./templates/**.{.twig,.yml}']).on('change', server.reload);
}));
