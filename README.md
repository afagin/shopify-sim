# To run server on skeleton-theme (git subtree in this repo)

```
rake
```

# To run server on your own theme

```
THEME_PATH=../my-theme rake
```

(THEME_PATH/{assets,layout,snippets,templates} should exist)

# To run tests

```
rake test
```

# Goal

To have a local development environment that simulates Shopify.

Links and Add to Cart won't work. Just want to be able to render Shopify liquid files locally (and eventually use livereload/figwheel).

# See also

- https://github.com/Shopify/vision