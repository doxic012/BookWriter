class Authorship < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  belongs_to :pdf_export_setting

end