require 'spec_helper'

describe SongsController do
  render_views
  describe "index" do
    before do
      Song.create!(name: 'Human Nature')
      Song.create!(name: 'Careless Whisper')
      Song.create!(name: 'Lowdown')
      Song.create!(name: 'La Prima Estate')

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object["name"] }
    end

    context "when the search finds results" do
      let(:keywords) { 'human' }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return one result' do
        expect(results.size).to eq(1)
      end
      it "should include 'Human Nature'" do
        expect(results.map(&extract_name)).to include('Human Nature')
      end
    end

    context "when the search doesn't find results" do
      let(:keywords) { 'foo' }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end
end
