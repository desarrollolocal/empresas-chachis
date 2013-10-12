class CompanyFilters < Hash

  def add(name, value)
    self[name] = value
  end

  def add_keyword(keyword)
    self['keywords'] = /^#{keyword}$/i
  end

end