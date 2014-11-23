require 'irb'
require 'aws-sdk'

AWS.config(:access_key_id => ENV['AWSKEY'], :secret_access_key => ENV['AWSSEC'])
$s3 = AWS::S3.new

def create_bucket(name)
	begin
		$s3.buckets.create(name)
	rescue AWS::S3::Errors::BucketAlreadyExists
	end
end

def show_menu
	puts '(l)ist buckets, (c)reate bucket, (u)pload file, (d)ownload file, (q)uit'
	response = gets.chomp

	case response
		when 'c'
			puts 'bucket name: '
			name = gets.chomp
			puts 'error with bucket name, please try again' if !create_bucket(name)
		when 'l'
			$s3.buckets.each {|bucket| puts bucket.name}
	end
end

while show_menu != 'q'; end