# USWDS SEC Theme

## Technology Details

- Package Manager - NPM - https://www.npmjs.com
- Task Runner - Gulp - https://gulpjs.com
- SASS Compiler - Dart Sass - https://sass-lang.com/dart-sass
- Design System Base - USWDS
- Important Contrib modules
  - [Pattern UI](https://www.drupal.org/project/ui_patterns) - Site components are creating using the UI Pattern syntax and then available in the pattern library (/patterns). These can be used throughout Drupal including on entity displays and in views.
  - [Display Suite](https://www.drupal.org/project/ds) - Display Suite allows us to use pattern in the Manage display of the nodes and also to pass in additional configuration to the patterns. For an example on the usage, see the "Cards" Paragraph type.
  - [Twig Tweak](https://www.drupal.org/project/twig_tweak) - Twig Tweak is a small module which provides a Twig extension with some useful functions and filters that can improve development experience.
  - [Twig Field Value](https://www.drupal.org/project/twig_field_value) - Twig Field Value helps frontenders to get partial data from Drupal field render arrays. It gives them more control over the output without drilling deep into the render array or using preprocess functions.
- Important Custom Modules
  - Sec Style Guide (sec_styleguide) - Creation of custom pages where we output styles that we have setup on the site including the patterns that we are using. This guide is more for users and SEC departments. the pattern library is more for developers.

## Local Setup
TODO: Add local setup details

## Directory Structure
- TODO: write documentation

## Compiling project
| Description                            | Command           |
|----------------------------------------|-------------------|
| Watch JS and SASS to compile on change | `lando npm start` |
| Build Project files for production     | `lando npm build` |

### SASS
TODO: Add SASS details
- SASS
#### Compiling Sass
- namespacing
- uswds
- watching
- building

## Javascript
TODO: Add JS details
ESLINT

## Patterns
- TODO: write documentation
- What are patterns
- Where to view patterns
- How to nest patterns
- How to use patterns

### If Statement Usage in Patterns
  - Problem: If statements were not working as intended when determing if a section should be rendered or not.  

  The example below will render the footer if a render array is present. 

  {% if footer %}
    <div class="card-horz__footer">
      {{ footer }}
    </div>
  {% endif %}

  To fix this, we use Twig to render the footer variable and verify that its length is greater than zero.

  {% if footer | render | length > 0 %}
    <div class="card-horz__footer">
      {{ footer }}
    </div>
  {% endif %}

  Rendering images create a similar problems as described above.  When testing if an image is present we must check for either a string with a length greater than zero or a render array that contains an image.  If the render array contains an image the array length will be greater than three.  

  {%  if (image | length > 1) or ((image is iterable) and (image | first | length > 3)) %}
    <div class="usa-card__media">
      <div class="usa-card__img">
        {{ image }}
      </div>
    </div>
  {% endif %}

## USWDS references
- TODO: write documentation
- How to use colors
- How to use tokens
- Where to find documentation

## Misc TODOs
- TODO: Stop committing compiled files css js etc


## Responsive Images
This site uses responsive images wherever it is appropriate.

Please see [Responsive Image Documentation](responsive-images.md).


The BEM Naming Convention
