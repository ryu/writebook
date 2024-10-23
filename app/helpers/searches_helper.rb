module SearchesHelper
  def highlight_page_body(page, query)
    if query.present?
      terms = page.leaf.matches_for_highlight(query)
      sanitize_content highlight(page.body.to_html, terms, sanitize: false)
    else
      sanitize_content page.body.to_html
    end
  end
end
