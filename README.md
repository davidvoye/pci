# wwuzen-template

A wwuzen sub-theme template.

## Dependencies

*   [node-js](https://nodejs.org/en/)
*   [npm](https://www.npmjs.com/)
*   [grunt-cli](https://github.com/gruntjs/grunt-cli)
*   [ruby](https://www.ruby-lang.org/en/)
*   [bundler](http://bundler.io/)
*   [wwuzen](https://bitbucket.org/wwuweb/wwuzen/)

## Setup

1.  Install node-js and npm for your platform.
2.  Install the grunt-cli with npm.
3.  In the root of this theme, run:

        bundle install

    and:

        npm install

4.  When developing in a Drupal installation, the Zen and wwuzen themes must be
    present. The easiest way to ensure these dependencies is to build your
    Drupal installation from the
    [WWU Collegesites profile](https://bitbucket.org/wwuweb/collegesites/).

        drush make collegesites.make

5.  Run the interactive build script to set the name of your new wwuzen
    sub-theme. Make sure to update the theme name in the .info file as well.

        ./build.sh

## Development

To begin developing, simply run:

    grunt watch

Any changes or additions to images, styles, or JavaScript will be detected and
compiled appropriately.

To remove all generated assets, run:

    grunt clean

## Deployment

To prepare the theme assets for deployment run:

    grunt build

In additional to compiling and copying all assets, this task will minify all
images and code.

## File Structure

All theme resources (sass, js, images) are located in the **src** directory.

Resources are grouped by asset type. Stylesheets are further organized into
logical groups based on theme region and element type.

```
src/
├── images
│   ├── header.jpg
│   ├── logo.png
│   └── screenshot.png
├── js
│   ├── README.txt
│   └── sfx.js
└── sass
    ├── main.scss
    ├── modules
    │   ├── _all.scss
    │   ├── _breakpoints.scss
    │   ├── _color.scss
    │   ├── _invisible.scss
    │   ├── _typography.scss
    │   └── wwu
    │       ├── _color.scss
    │       └── _typography.scss
    └── partials
        ├── _base.scss
        ├── components
        │   └── _view.scss
        ├── pages
        │   └── front
        │       └── _layout.scss
        ├── regions
        │   ├── content
        │   │   ├── _blockquote.scss
        │   │   ├── _heading.scss
        │   │   ├── _image.scss
        │   │   ├── _list.scss
        │   │   ├── _ordered-list.scss
        │   │   ├── _paragraph.scss
        │   │   ├── _table-cell.scss
        │   │   ├── _table-header.scss
        │   │   ├── _table.scss
        │   │   └── _unordered-list.scss
        │   ├── footer
        │   │   ├── _color.scss
        │   │   ├── _layout.scss
        │   │   └── _typography.scss
        │   ├── header
        │   │   ├── _color.scss
        │   │   ├── _layout.scss
        │   │   └── _typography.scss
        │   ├── html
        │   │   ├── _color.scss
        │   │   ├── _layout.scss
        │   │   └── _typography.scss
        │   ├── navigation
        │   │   ├── _color.scss
        │   │   ├── _layout.scss
        │   │   └── _typography.scss
        │   └── page
        │       ├── _color.scss
        │       ├── _layout.scss
        │       └── _typography.scss
        └── _reset.scss
```

## Sass Framework

This theme uses Sass for all styles.

### Organization

A pattern used throughout this framework is the decomposition of styles into the
categories of:

*   color
*   typography
*   layout

This serves several purposes:

*   Breaks stylesheets down into manageable chunks
*   Groups related properties and separates unrelated properties
*   Makes rules easier to find
*   Improves version control by spreading edits out across separate files
*   Reduces selector specificity
*   Removes implicit dependencies inherent to CSS declaration order

#### color

"Color" styles include anything visual that does not affect the theme layout;
that is, the location or size of elements on the page. This includes:

*   color
*   background
*   border style
*   list style

#### typography

"Typography" styles include anything related to typeface and text formatting.

*   font
*   text

#### layout

"Layout" styles include anything related to the placement and size of elements
on the page.

*   display
*   float
*   position
*   top, right, bottom, left
*   margin
*   padding
*   z-index

### Main Stylesheet

main.css serves as the main stylesheet, compiled from main.scss. This file
declares the character encoding used for all stylesheets and imports all
partials. **This file should not contain any literal code and generally should
not be modified at all**.

### Modules

Modules are defined in this framework as any Sass file that does not produce CSS
output upon compilation. This includes mixins, functions, and variables.

Take advantage of custom modules to define project-wide variables. For example,
create variables to store colors, primary font size, or standard padding and
margin units.

Several commonly useful modules, described below, are already provided.

#### all

The "all" module is included as a convenient way to include all defined modules
into main.scss. Globbing ensures that any new module is automatically included
by this file.

#### breakpoints

The "breakpoints" module should be used to define custom theme-wide breakpoints
following the syntax used by the breakpoint Sass module. Visit
[breakpoint-sass.com](http://breakpoint-sass.com/) and the [Breakpoint
Wiki](https://github.com/at-import/breakpoint/wiki) for detailed usage
instructions.

#### color

The "color" module should be used to define custom color variables. Make changes
to the color module, not the wwu/_color module to ensure extensability. Use of
variables for values like color ensures that:

*   Color names are human-readable
*   Theme-wide changes to a color value require editing only a single value

#### invisible

The "invisible" modules provides a custom mixin for hiding an element from
visual browsers while still allowing it to be read by screen readers. It uses
the same code as found in
[https://github.com/drupal/drupal/blob/7.x/modules/system/system.base.css#L223-249].

#### typography

The "typography" module should be used to define custom font variables. Make
changes to the color module, not the wwu/_color module to ensure extensability.
Use of variables for values like font-family ensures that:

*   Font names are semantic
*   Element typeface is decoupled from a specific family
*   Theme-wide changes to a typeface require editing only a single value

### Partials

A Partial is any Sass document that produces CSS after compilation. This is
where all actual style declarations should be located.

#### base

The base partial serves to initialize the Sass environment used in this
framework. This begins with including the main library dependencies:

*   compass
*   zen
*   breakpoint

Global variables are also initialized, and all custom modules are included.

#### reset

This partial normalizes the Sass environment. It overrides any unnecessary
styles inherited from wwuzen or Zen, and provides a common starting place for
all browser platforms.

#### regions

The regions directory contains a directory for each region in the theme
template. These styles should be limited to elements that are hard-coded into
the theme template files - **not** dynamic markup added by Drupal at runtime.

With the exception of the "content" region, each is further broken
down into a separate partial for each of color, typography, and layout. Regions
should be used to control medium- to high-level styles, particularly theme
layout.

*   **content**

    The content region is uniquely organized based on element type (paragraph, list,
    table). Stylesheets for additional elements can and should be added here.
    They will be automatically imported into main.scss.

#### pages

The pages directory contains a directory for specific pages in a site that
require unique and specific styling. A common use-case is custom styling for the
home page.

Page styles are loaded after region styles. This allows them to naturally
override region styles without requiring high selector specificity.

#### components

The components directory is intended for stylesheets related to a specific
"component"; where a component is a independant, potentially re-usable, element
in the user-interface. This includes things like a calendar, image carousel,
gallery, or form.

Component styles are loaded after both page and region styles for maximum
customization with minimum specificity.

As style customizations in Drupal are often related to a self-contained element
such as a View or Panels display, a custom component will generally be the best
strategy for adding styles.

For example, to style a newly created alumni profile view, create a new file
**src/sass/components/_alumni-profile.scss**. It will automatically be included
and compiled, thanks to the globbing gem.

## Sass Style Guide

Conventions make a system predictable. Predictability makes something easier to
learn and use. Conventions also make a system reusable. Reusability minimizes
development and maximizes flexibility and adaptability. Therefore, various
conventions are followed in this framework to streamline development.

### Filenames

Prefer file names that are all lower-case. Use dashes rather than underscores,
camel-case, or simply running words together.

Sass files should also be named in the singular when possible:

Bad:

*   colors
*   paragraphs
*   lists
*   views

Good:

*   typography
*   blockquote
*   layout
*   breakpoints

"breakpoints" is an exception to avoid naming collision with the breakpoint
library.

### Variables

Sass variables should be used to reduce duplicate code. Use WWU brand color
variables, defined in **src/sass/modules/wwu/color**, whenever possible. Use
functions from the Compass color module to modify WWU brand colors:

    $wwu-light-blue-lighter: lighten($wwu-light-blue, 10);

Avoid using color names in variable names. Also avoid being overly semantic, as
this can limit the reusability of variables. The best strategy is to define
variable names based on their function in the current color scheme:

    $primary-color: $wwu-light-blue;
    $secondary-color: $wwu-blue;
    $accent-color: $wwu-lime;

Creation of new varaibles to encapsulate the Western brand color variables in
this way is encouraged.

It may also be useful to define "sub" schemes for individual design elements,
such as buttons:

    $light-button-text-color: $secondary-color;
    $light-button-background-color: $accent-color;

    $dark-button-text-color: #fff;
    $dar-button-background-color: $secondary-color;

Again, the variables in this example reuse previously defined color variables.

### Functions and Mixins

Compass and Zen-Grids contain many useful functions and mixins to streamline
common tasks. **Use them!** Make sure to refer to the correct version of the
online documentation. Check the Gemfile for the specific versions of each
module.

The breakpoint module is included and should be used for responsive styling when
possible. It allows for the use of nested breakpoints, allowing all styles for
an element to be located in one place rather than spread across multiple media
queries. Use global variables to define breakpoints so that they can be shared
across all files.

Custom mixins and functions should be defined in a new partial in the modules
directory. Related mixins and functions should be grouped into a single file.

### CSS Selectors

Some general, non-exhaustive guidelines for choosing selectors from the HTML:

*   Prefer **class** selectors; they are more semantic than element selectors.
*   Prefer the least-specific selector possible; avoid chaining or qualifying
    selectors unless necessary to override a style further up the cascade.
*   Avoid Sass selector nesting unless a descendant selector is specifically
    required.
*   Avoid qualifying selectors:

        // Bad:

        ul.menu

        // Good:

        .menu

*    Avoid **id** selectors; they are too specific and guarantee that the associated
     style declaration cannot be reused.

## Copyright

Copyright 2016 Western Washington University Web Technologies Group Licensed
under the Educational Community License, Version 2.0 (the "License") you may not
use this file except in compliance with the License. You may obtain a copy of
the License at http://www.osedu.org/licenses/ECL-2.0

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.
