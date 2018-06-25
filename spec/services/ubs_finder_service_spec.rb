require 'rails_helper'

describe UbsFinderService do
  let(:params) { { query: "-23.604936,-46.692999", page:1, per_page:1 } }
  let(:radius) { 100 }
  let(:finder) { described_class.new params, radius }

  context "#ubs" do
    let(:ubs) { create(:ubs) }
    let(:root_fields) { [:current_page, :per_page, :total_entries] }
    let(:response) do
      {
        current_page: 1,
        per_page: 1,
        total_entries: 1,
        entries: [{
          id: ubs.id,
          name: ubs.nom_estab,
          address: ubs.dsc_endereco,
          city: ubs.dsc_cidade,
          phone: ubs.dsc_telefone,
          geocode: {
            lat: ubs.coordinates.latitude,
            long: ubs.coordinates.longitude
          },
          scores: {
            size: 2,
            adaptation_for_seniors: 1,
            medical_equipment: 1,
            medicine: 2
          }
        }]
      }
    end

    before { ubs }
    subject { finder.ubs }

    it { is_expected.to be_a Hash }
    it { is_expected.to be_eql response }
  end

  context '#builder_data' do
    subject { finder.builder_data([]) }

    it { is_expected.to include :current_page, :per_page, :count, :collection }
  end
end
