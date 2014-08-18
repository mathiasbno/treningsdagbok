var gulp = require('gulp'),
    connect = require('gulp-connect'),
    concat = require('gulp-concat'),
    gutil = require('gulp-util'),
    uglify = require('gulp-uglify'),
    coffee = require('gulp-coffee'),
    sass = require('gulp-ruby-sass'),
    autoprefixer = require('gulp-autoprefixer'),
    minifycss = require('gulp-minify-css'),
    image = require('gulp-image'),
    watch = require('gulp-watch'),
    minifyHTML = require('gulp-minify-html'),
    rename = require('gulp-rename');

var build = './build',
    html_path = './app/views/**/*.html',
    style_path = './app/assets//stylesheets/**/**/*.sass',
    script_path = './app/assets/javascripts/**/**/*.coffee',
    lib_path = './app/assets/javascripts/lib/**/*.js',
    image_path = './app/assets/images/**/*';


gulp.task('default', function() {
  // place code for your default task here
});

gulp.task('connect', function() {
  connect.server({
    root: [build]
  });
});

gulp.task('html', function() {
  var opts = {empty:true,cdata:true};

  gulp.src(html_path)
    .pipe(minifyHTML(opts))
    .on('error', function (err) { console.log(err.message); })
    .pipe(gulp.dest(build))
});

gulp.task('script', function() {
  gulp.src(script_path)
    .pipe(coffee({bare: true}))
    .pipe(concat('application.min.js'))
    .on('error', function (err) { console.log(err.message); })
    .pipe(gulp.dest(build + '/script'));
});

gulp.task('lib', function() {
    gulp.src(lib_path)
    .pipe(concat('lib.js'))
    .pipe(uglify())
    .on('error', function (err) { console.log(err.message); })
    .pipe(gulp.dest(build + '/script/lib'));
});

gulp.task('style', function() {
  gulp.src(style_path)
    .pipe(sass({ style: 'expanded' }))
    .pipe(autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1'))
    .pipe(minifycss())
    .pipe(concat('application.min.css'))
    .on('error', function (err) { console.log(err.message); })
    .pipe(gulp.dest(build + '/css'));
});

gulp.task('image', function () {
  gulp.src(image_path)
    .pipe(image())
    .pipe(gulp.dest(build + '/images'));
});

gulp.task('watch', function () {
  gulp.watch(html_path, ['html']);
  gulp.watch(script_path, ['script']);
  gulp.watch(lib_path, ['libs']);
  gulp.watch(style_path, ['style']);
  gulp.watch(image_path, ['image']);
});

gulp.task('default', ['watch', 'html', 'style', 'script', 'lib', 'image']);
