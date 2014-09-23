class Article < ActiveRecord::Base
  belongs_to :wiki

 # validates :wiki, presence :true
end
