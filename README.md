# Goal

To have a local development environment that simulates Shopify.

Links and Add to Cart won't work. Just want to be able to render Shopify liquid files locally (and eventually use livereload/figwheel).

# To run server on skeleton-theme (git subtree in this repo)

```
rake
```

# To run server on your own theme

```
THEME_PATH=../my-theme rake
```

(THEME_PATH/{assets,layout,snippets,templates} should exist)

# Serve static assets at /public

```
PUBLIC_DIR=../my-theme/tmp/ rake
```

# To run tests

```
rake test
```

# See also

- https://github.com/Shopify/vision