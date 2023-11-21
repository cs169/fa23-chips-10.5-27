# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []
    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      rep = Representative.find_by(name: official.name, title: title_temp)
      next unless rep.nil?

      party = official.party if official.party
      photo_url = official.photo_url if official.photo_url
      full_address = extract_full_address(official.address)
      rep = Representative.create!({ name: official.name, ocdid: ocdid_temp, title: title_temp,
contact_address: full_address, political_party: party, photo_url: photo_url })
      reps.push(rep)
    end
    reps
  end

  def self.extract_full_address(address)
    return unless address

    addy = address[0]
    [addy&.line1, addy&.line2, addy&.line3, addy&.city, addy&.state, addy&.zip].compact.join(', ')
  end
end
