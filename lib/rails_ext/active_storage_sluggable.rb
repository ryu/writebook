module ActiveStorage::Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :set_slug
  end

  private
    def set_slug
      self.slug = "#{slug_basename}-#{SecureRandom.alphanumeric(6)}.#{slug_extension}"
    end

    def slug_basename
      File.basename(filename.to_s, ".*").parameterize
    end

    def slug_extension
      File.extname(filename.to_s).delete(".").parameterize
    end
end

ActiveSupport.on_load :active_storage_attachment do
  ActiveStorage::Attachment.include ActiveStorage::Sluggable
end
