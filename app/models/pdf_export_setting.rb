class PdfExportSetting < ActiveRecord::Base
  attr_accessible :foot, :head, :insertFoot, :insertHead, :marginBottom, :marginLeft, :marginRight, :marginTop, :tableOfContent
  belongs_to :user

  #TODO: Sinnvolle maximal Ränder definieren
  validates :marginLeft, :marginRight, :presence => true, :numericality => {:greater_than => 0.5, :less_than => 10.0}
  validates :marginTop, :marginBottom, :presence => true, :numericality => {:greater_than => 0.5, :less_than => 20.0}

  #TODO: Eventuell brauchen wir hier keine Begrenzung wenn der PDF-Export automatisch Zeilen umbricht.
  validates :foot, :presence => true, :if => :insertFoot?, :length => {:maximum => 20}
  validates :head, :presence => true, :if => :insertHead?, :length => {:maximum => 20}

end

