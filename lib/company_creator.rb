require 'mail'

class CompanyCreator

  def initialize(database)
    @collection = database.collection 'companies'
  end

  def create(params)
    id = @collection.insert(prepare_insert(params))

    company = Company.new(params['name'], params['address'], params['website'],
      params['logo'], params['email'], params['keywords'], params['description'], id.to_s)

    Mail.deliver do
      to company.email
      from 'sender@example.comt'
      subject 'Confirma tu suscripcion'
      body "esta es tu url #{company.id}"
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
