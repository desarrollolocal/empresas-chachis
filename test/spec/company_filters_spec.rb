require 'rspec'

require_relative '../../lib/company_filters'

describe 'CompanyFilters' do

  it 'it allows adding filters' do
    filter = "my_filter"
    company_filters = CompanyFilters.new

    company_filters.add('filter', filter)

    expect(company_filters).to eql ({ "filter" => filter })
  end

  it 'it allows adding a keyword' do
    keyword = "Ruby"
    company_filters = CompanyFilters.new

    company_filters.add_keyword(keyword)

    expect(company_filters).to eql ({ "keywords" => /^#{keyword}$/i })
  end

end