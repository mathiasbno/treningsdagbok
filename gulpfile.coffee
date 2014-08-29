gulp = require 'gulp'
gulpCoffee = require 'coffee-script'
concat = require 'gulp-concat'
gutil = require 'gulp-util'
uglify = require 'gulp-uglify'
coffee = require 'gulp-coffee'
sass = require 'gulp-ruby-sass'
autoprefixer = require 'gulp-autoprefixer'
minifycss = require 'gulp-minify-css'
image = require 'gulp-image'
watch = require 'gulp-watch'
minifyHTML = require 'gulp-minify-html'
rename = require 'gulp-rename'

build = './build/public'
html_path = './app/views/**/**/*.html'
style_path = './app/assets/stylesheets/**/**/*.sass'
script_path = './app/assets/javascripts/**/**/*.coffee'
lib_path = './app/assets/javascripts/lib/**/*.js'
image_path = './app/assets/images/**/*'

express = require "express"
app = express()

app.set 'views', 'build/view'
app.engine('html', require('ejs').renderFile)
app.set 'view engine', 'html'

app.use(express.static(build))

app.use (req, res) ->
  # Use res.sendfile, as it streams instead of reading the file into memory.
  res.sendFile('./build/view/application.html')


gulp.task 'html', ->
  gulp.src('./app/views/application.html')
    .on('error', (err) -> console.log('Error: ' + err.message))
    .pipe(gulp.dest('./build/view'))

  gulp.src('./app/views/templates/**/*.html')
    .on('error', (err) -> console.log('Error: ' + err.message))
    .pipe(gulp.dest(build + '/templates'))

  return

gulp.task 'script', ->
  gulp.src(script_path)
    .pipe(coffee({bare: true}))
    .on('error', (err) -> console.log('Error: ' + err.message))
    .pipe(concat('application.min.js'))
    .pipe(gulp.dest(build + '/script'))

  return

gulp.task 'lib', ->
  gulp.src(lib_path)
    .pipe(concat('lib.js'))
    .pipe(uglify())
    .on('error', (err) -> console.log('Error: ' + err.message))
    .pipe(gulp.dest(build + '/script/lib'))

  return

gulp.task 'style', ->
  gulp.src(style_path)
    .pipe(sass({ style: 'expanded' }))
    .on('error', (err) -> console.log('Error: ' + err.message))
    .pipe(autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1'))
    .pipe(minifycss())
    .pipe(concat('application.min.css'))
    .pipe(gulp.dest(build + '/css'))

  return

gulp.task 'prodServer', ->
  gulp.src('./production/*')
    .on('error', (err) -> console.log('Error: ' + err.message))
    .pipe(gulp.dest('./build'))

gulp.task 'image', ->
  gulp.src(image_path)
    .pipe(image())
    .pipe(gulp.dest(build + '/images'))

  return

gulp.task 'watch', ->
  app.listen(3000)

  gulp.watch(html_path, ['html'])
  gulp.watch(script_path, ['script'])
  gulp.watch(lib_path, ['libs'])
  gulp.watch(style_path, ['style'])
  gulp.watch(image_path, ['image'])

gulp.task('default', ['watch', 'html', 'style', 'script', 'lib', 'image', 'prodServer'])
