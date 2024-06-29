## Creating a New Article

If you would like to add the clean theme to an existing directory:

```
quarto install extension chrisenv/quarto-template-report@current
```

or you can use a Quarto template that bundles a .qmd starter file:

```
quarto use template chrisenv/quarto-template-report@current
```

## Usage

For example:

`quarto render article.qmd --to report-pdf`

or in your document yaml

``` yaml
format:
  report-pdf: default 
```