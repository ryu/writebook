class ActionText::Markdown::UploadsController < ApplicationController
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  def create
    @record = GlobalID::Locator.locate_signed params[:record_gid]

    @markdown = @record.safe_markdown_attribute params[:attribute_name]
    @markdown.save! unless @markdown.persisted?

    @markdown.uploads.attach params[:upload]
  end

  def show
    @attachment = ActiveStorage::Attachment.find_by! slug: "#{params[:id]}.#{params[:ext]}"
    redirect_to @attachment.url
  end
end
