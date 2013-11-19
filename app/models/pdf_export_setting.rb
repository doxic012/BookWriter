class PdfExportSetting < ActiveRecord::Base
  attr_accessible :foot, :head, :insertFoot, :insertHead, :marginBottom, :marginLeft, :marginRight, :marginTop, :tableOfContent
  belongs_to :user
end
