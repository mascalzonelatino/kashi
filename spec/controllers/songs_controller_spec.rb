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

  describe "show" do
    before do
      xhr :get, :show, format: :json, id: song_id
    end

    subject(:results) { JSON.parse(response.body) }

    context "when the song exists" do
      let(:song) { 
        Song.create!(name: 'Human Nature', 
               lyrics: "Reaching out across the night time") 
      }
      let(:song_id) { song.id }

      it { expect(response.status).to eq(200) }
      it { expect(results["id"]).to eq(song.id) }
      it { expect(results["name"]).to eq(song.name) }
      it { expect(results["lyrics"]).to eq(song.lyrics) }
    end

    context "when the song doesn't exit" do
      let(:song_id) { -9999 }
      it { expect(response.status).to eq(404) }
    end
  end
  
  describe "create" do
    before do
      xhr :post, :create, format: :json, song: { name: "Careless Whisper", 
                                           lyrics: "I feel so unsure" }
    end
    it { expect(response.status).to eq(201) }
    it { expect(Song.last.name).to eq("Careless Whisper") }
    it { expect(Song.last.lyrics).to eq("I feel so unsure") }
  end

  describe "update" do
    let(:song) { 
      Song.create!(name: 'La Prima Estate', 
                     lyrics: "La Prima Estate, tutti e due laureati") 
    }
    before do
      xhr :put, :update, format: :json, id: song.id, song: { name: "Careless Whisper", 
                                                 lyrics: "I feel so unsure" }
      song.reload
    end
    it { expect(response.status).to eq(204) }
    it { expect(song.name).to eq("Careless Whisper") }
    it { expect(song.lyrics).to eq("I feel so unsure") }
  end

  describe "destroy" do
    let(:song_id) { 
      Song.create!(name: 'La Prima Estate', 
                     lyrics: "La Prima Estate, tutti e due laureati").id
    }
    before do
      xhr :delete, :destroy, format: :json, id: song_id
    end
    it { expect(response.status).to eq(204) }
    it { expect(Song.find_by_id(song_id)).to be_nil }
  end
end
