class PdfExportSetting < ActiveRecord::Base
  attr_accessible :chunks, :foot, :head, :insertFoot, :insertHead, :marginBottom, :marginLeft, :marginRight, :marginTop, :tableOfContent, :allChunks
  has_one :authorship
  has_and_belongs_to_many :chunks

  #TODO: Sinnvolle maximal Ränder definieren
  #validates :marginLeft, :marginRight, :numericality => {:greater_than => 0.5, :less_than => 10.0}#, :message => "Seitenränder müssen zwischen 0.5cm und 10cm liegen"
  #validates :marginTop, :marginBottom, :numericality => {:greater_than => 0.5, :less_than => 10.0}#, :message => "Seitenränder müssen zwischen 0.5cm und 10cm liegen"

  #TODO: Eventuell brauchen wir hier keine Begrenzung wenn der PDF-Export automatisch Zeilen umbricht.
  #validates :foot, :length => {:maximum => 20}#, :message => "Kopfzeile darf nicht länger als 20 Zeichen sein" #:presence => true, :if => :insertFoot?,
  #validates :head, :length => {:maximum => 20}#, :message => "Fußzeile darf nicht länger als 20 Zeichen sein" #:presence => true, :if => :insertHead?,
  validates_length_of :foot, :head, :maximum => 20, :message => "Darf nicht länger als 20 Zeichen sein"
  validates_numericality_of :marginLeft, :marginRight, :marginTop, :marginBottom, :greater_than => 0.5, :less_than => 10.0, :message => "Seitenränder müssen zwischen 0.5cm und 10cm liegen"

end