class Content < ApplicationRecord
    # 1 contenu = 1 article
    belongs_to :article

end
