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
      address = official.address
      if address
        addy = address[0]
        full_address = [addy&.line1, addy&.line2, addy&.line3, addy&.city, addy&.state, addy&.zip].compact.join(", ")
      end
      pt = official.party
      if pt
        party = pt
      end
      pic = official.photo_url
      if pic
        photo_url = pic
      end
      rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
          title: title_temp, contact_address: full_address, political_party: party,
        photo_url: photo_url})
      reps.push(rep)
    end

    reps
  end
end
