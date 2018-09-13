class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.to_csv
    attributes = self::CSV_HEADERS

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |obj|
        csv << attributes.map { |attr| obj.send(attr) }
      end
    end
  end

  # Naive approach
  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end
end
