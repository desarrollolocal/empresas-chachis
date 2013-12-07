require 'mail'

class CompanyCreator

  def initialize(companies, url_builder)
    @companies = companies
    @url_builder = url_builder
  end

  def create(params)
    id = @companies.insert(prepare_insert(params))
    company = Company.new(params['name'], params['address'], params['website'],
      params['logo'], params['email'], params['keywords'], params['description'], id.to_s)

    url = @url_builder.build(company)

    Mail.deliver do
      to company.email
      from 'sender@example.comt'
      subject 'Confirma tu suscripcion'
      body "esta es tu url #{url}"
    end

    company
  end

  private

  def prepare_insert(params)
    data = {'name' => params['name'], 'email' => params['email'], 'website' => params['website']}
    data["hiring"] = true
    data["verified"] = false
    data
  end
end
