require 'irb'
require 'aws-sdk'

AWS.config(:access_key_id => ENV['AWSKEY'], :secret_access_key => ENV['AWSSEC'])
$s3 = AWS::S3.new

def create_bucket(name)
	begin
		$s3.buckets.create(name)
		resque AWS::S3::Errors::BucketAlreadyExists
	end
end

def show_menu
	puts '(l)ist buckets, (c)reate bucket, (u)pload file, (d)ownload file, (q)uit'
	response = gets.chomp
end

while show_menu != 'q'; end