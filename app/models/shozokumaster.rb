class Shozokumaster < ActiveRecord::Base
  self.table_name = :所属マスタ
  self.primary_key = :所属コード
  include PgSearch
  multisearchable :against => %w{所属コード 所属名}
  validates :所属コード, :所属名, presence: true
  validates :所属コード, uniqueness: true

  has_many :kouteimasters, foreign_key: :所属コード
  has_one :shainmaster, foreign_key: :所属コード

  alias_attribute :id, :所属コード
  alias_attribute :name, :所属名

  # a class method import, with file passed through as an argument
  def self.import(file)
    # a block that runs through a loop in our CSV data
    CSV.foreach(file.path, headers: true) do |row|
      # creates a user for each row in the CSV file
      Shozokumaster.create! row.to_hash
    end
  end

  def self.to_csv
    attributes = %w{所属コード 所属名}

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |shozokumaster|
        csv << attributes.map{ |attr| shozokumaster.send(attr) }
      end
    end
  end
  # Naive approach
  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end
end
