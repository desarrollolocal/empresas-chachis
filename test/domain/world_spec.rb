require 'rspec'

require_relative '../../lib/world'

describe 'World' do
  before(:each) do
    @world = World.new
  end

  it "says hello" do
     @world.say_hello.should eql('Hello')
  end
end