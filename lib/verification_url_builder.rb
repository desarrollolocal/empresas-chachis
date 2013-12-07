class VerificationUrlBuilder

  def initialize(host, path)
    @host = host
    @path = path
  end

  def build(company)
    "#{@host}#{@path}/#{company.id}"
  end
end