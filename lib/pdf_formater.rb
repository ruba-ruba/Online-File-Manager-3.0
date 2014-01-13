class PdfFormater < Prawn::Document
  def to_pdf(path)
    data = HTTParty.get(path).body
    text data
    render
  end
end