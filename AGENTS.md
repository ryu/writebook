# Agent Guidelines

## Testing Conventions

### Use Existing Fixtures
Prefer using existing fixtures over creating new records in tests. For example, use `leaves(:welcome_page)` instead of `books(:handbook).press Page.new(body: "..."), title: "..."`.

### URL Helpers in Tests
Use `_path` helpers instead of `_url` helpers in controller/integration tests unless you need to test across different hosts or explicitly need the full URL.

**Preferred:**
```ruby
get book_slug_path(books(:handbook))
```

**Avoid:**
```ruby
get book_slug_url(books(:handbook))
```

## Controller Conventions

### Simplified respond_to Blocks
When using `respond_to` with default rendering, omit the `{ render }` block as it's implied.

**Preferred:**
```ruby
def show
  respond_to do |format|
    format.html
    format.md
  end
end
```

**Avoid:**
```ruby
def show
  respond_to do |format|
    format.html { render }
    format.md { render }
  end
end
```
