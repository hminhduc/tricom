class Kintaiteeburu < ApplicationRecord
	validates :勤務タイプ,:出勤時刻,:退社時刻, presence: true
	before_save :set_data			
	# validate :time_value_order
	# def time_value_order
	#   if self.出勤時刻 && self.退社時刻 && (self.出勤時刻.to_time > self.退社時刻.to_time)
	#     self.errors.add(:退社時刻,"退社時刻 value must be greater than 出勤時刻 value.")
	#   end
	# end
	# a class method import, with file passed through as an argument
	def self.import(file)
	    # a block that runs through a loop in our CSV data	     
	    CSV.foreach(file.path, headers: true) do |row|
	       	hash=row.to_hash	       		       	
	      	Kintaiteeburu.create(
	      						勤務タイプ: hash["勤務タイプ"],
	      						出勤時刻: hash["出勤時刻"].to_time,
	      						退社時刻: hash["退社時刻"].to_time
	      						# 昼休憩時間: hash["昼休憩時間"].to_f,
	      						# 夜休憩時間: hash["夜休憩時間"].to_f,
	      						# 深夜休憩時間: hash["深夜休憩時間"].to_f,
	      						# 早朝休憩時間: hash["早朝休憩時間"].to_f,
	      						# 実労働時間: hash["実労働時間"].to_f,
	      						# 早朝残業時間: hash["早朝残業時間"].to_f,
	      						# 残業時間: hash["残業時間"].to_f,
	      						# 深夜残業時間: hash["深夜残業時間"].to_f
	      						)	      	
	    end
	    
	end	
	def yasumijikan(start,finish,s,f)
		s=s.to_time
		f=f.to_time
		f=f+1.day if s>f
		if start<f						
			tmp=((finish >f ? f : finish)-(start>s ? start : s)).to_i/1800*0.5			
			return tmp>0 ? tmp : 0
		else			
			return 0
		end
	end	
	def set_data		
		start=self.出勤時刻.strftime("%H:%M").to_time
		finish=self.退社時刻.strftime("%H:%M").to_time		
		self.出勤時刻=start
		self.退社時刻=finish
		finish=finish+1.day if start>finish
		self.昼休憩時間=yasumijikan(start,finish,"12:00","13:00")
		self.夜休憩時間=yasumijikan(start,finish,"18:00","19:00")
		self.深夜休憩時間=yasumijikan(start,finish,"23:00","0:00")
		self.早朝休憩時間=yasumijikan(start,finish,"4:00","6:00")
		self.早朝残業時間=yasumijikan(start,finish,"6:00","9:00")
		self.残業時間=yasumijikan(start,finish,"19:00","22:00")
		self.深夜残業時間=yasumijikan(start,finish,"22:00","5:00")
		self.実労働時間=(finish-start)/1800*0.5-self.昼休憩時間-self.夜休憩時間-self.深夜休憩時間-self.早朝休憩時間		
		# File.open("kq", "a") { |file|
		# 	file.write "#{self.勤務タイプ},#{self.出勤時刻.strftime("%k:%M")},#{self.退社時刻.strftime("%k:%M")},#{self.昼休憩時間>0 ? self.昼休憩時間 : ''},#{self.夜休憩時間>0 ? self.夜休憩時間 : ''},#{self.深夜休憩時間>0 ? self.深夜休憩時間 : ''},#{self.早朝休憩時間>0 ? self.早朝休憩時間 : ''},#{self.実労働時間>0 ? self.実労働時間 : ''},#{self.早朝残業時間>0 ? self.早朝残業時間 : ''},#{self.残業時間>0 ? self.残業時間 : ''},#{self.深夜残業時間>0 ? self.深夜残業時間 : ''}\n"
		# }
	end	
end
