class BasicPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  def initialize(url = root_path)
    @url = url
  end

  def visit!
    visit @url
    self
  end

  def loaded?
    content = @content || I18n.t('tickets.new.cta')

    return true if has_content? content
    raise "Expected #{self.class} to have content '#{content}'"\
          " but it was not found"
  end
end
