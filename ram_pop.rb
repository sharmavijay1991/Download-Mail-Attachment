#! /usr/bin/ruby
require 'openssl'
require 'net/pop'
require 'rubygems'
require 'base64'
require 'logger'
require 'yaml'


class MailingRcSystem

config_file_path=File.expand_path(File.dirname(__FILE__))+'/MailingSystemConfig.yml'
if ( !File.exist?(config_file_path) )
  	puts "Configuration File Does Not exists (#{config_file_path})"
		exit 1;
end
@@connection_config_data = YAML::load_file(config_file_path) ;
logpath = @@connection_config_data['OPTIONS']['LOG_FILEPATH'] ;
puts "logspath=>#{logpath}"
@@vlog = Logger.new("#{logpath}Mail_#{Time.now.hour}_#{Time.now.min}_#{Time.now.sec}.log");
@@vlog.debug "Log File Is Created"


@@uname = @@connection_config_data['OPTIONS']['USERNAME']
@@passwd = @@connection_config_data['OPTIONS']['PASSWORD']
@@hostName = @@connection_config_data['OPTIONS']['HOST_NAME']
@@port = @@connection_config_data['OPTIONS']['HOST_PORT']
@@Subject = @@connection_config_data['OPTIONS']['SUBJECT']
@@Timeout = 600
read = File.new("./ProcessedMailCount.txt",'r')
if (File.exist?(read))
	str = read.first
	if( !str.nil? && str.size > 0 )
		@@vlog.debug "Will Fetch Mail From=>#{str}"
		@@LastProcessedMail = str.to_i
	else
		@@vlog.debug "Will Fetch All Available"
		@@LastProcessedMail = 0
	end
else
	@@vlog.debug "Will Fetch All Available"
	@@LastProcessedMail = 0
end
read.close
@@record_id = @@LastProcessedMail
@@write = File.new("./ProcessedMailCount.txt",'w+')

def populateMail
	Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
	mail_obj = Net::POP3.new(@@hostName,@@port)
	mail_obj.start(@@uname,@@passwd)
#	mail_obj = Net::POP3.new('anywhere.exchserver.com',995)
#	mail_obj.start('vijay.sharma@subex.com','password')
	@@vlog.debug "started"
		while true
		begin
			if mail_obj.mails.empty?
				@@vlog.debug "There is no Mail"
			else
				read_timeout= @@Timeout
				@@vlog.debug "-------------MailReceived-----------------"
				@@vlog.debug "Total Mail =>#{mail_obj.n_mails()}"


				mail_obj.mails.each do |email|
					if ((email.unique_id).to_i < @@LastProcessedMail )
						@@vlog.debug "skiping"
					else
						@@record_id = email.unique_id ;
						sbj=email.header.split("\r\n").grep(/^Subject:/)
						if (sbj.include? ("#{@@Subject}"))
							@@vlog.debug "Downloading Mail_#{email.unique_id}"
							status_check ="Content-Disposition: attachment;"
							str = email.pop
							is_present = str.index(status_check)
							if(!is_present.nil? )
								f=File.new("./Data/mail_#{email.unique_id}.txt",'w+')
								start = str.index("Content-Transfer-Encoding: base64")
								#substring1 = str.substring(start)
								substr = str[start+33..-1]
								last = substr.index("--")
								last1 = last - 1
								body = substr[0..last1]
								f.write(Base64.decode64(body))
								f.close
							end
						else
							@@vlog.debug "Subject Doesnot Match to (#{@@Subject}) skiping mail_#{email.unique_id}"
						end
					end
				end
			end
			rescue Exception => e
				@@vlog.error "An Error Occur"
				@@vlog.error "#{e.message}";
				@@write.write "#{@@record_id}"	#-------- Update Value of LastProcessedMail by using @@record_id--(in Background file and locally also)
				@@write.close
				
		end
		@@write.write "#{@@record_id}" #--- Update Value of LastProcessedMail by using @@record_id --(in Background file and locally also)
		@@LastProcessedMail = @@record_id.to_i
		@@vlog.debug "Going To Sleep"
		sleep 10
		puts "Checking Server Again For Mail..."
		end 
end

end 		##End of Class

MailingRcSystem.new.populateMail
