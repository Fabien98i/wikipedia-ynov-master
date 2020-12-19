class Article < ApplicationRecord
    # 1 article = 1 user
    # 1 arctile = N contunus
    belongs_to :user
    has_many :contents

    include ImageUploader::Attachment.new(:image)
    validates :title, presence: true
    validates :content, presence: true
end
