Download-Mail-Attachment
========================

Tool which will help to download attachments(All or Subject wise) from an mailing server on a time interval. 


#############################################################################################################
###########          						Mail Reading Module									#############
########### Created By :- Vijay Sharma															#############
########### Designation :- Software Engineer @ a Private Company								#############
########### Information About This module :-													#############
###########		Aim :- This module is created to read mails from an perticular pop server and 	#############
########### 			If subject to that mail matches with specified one in such case we will #############
###########				Download attachment. Initially We were downloading *.txt file but now   #############
###########				but now modified to support all document types.							#############
###########		Requirements :- Ruby 1.9.3p0													#############
###########		Lower version compatability :- SSL feature of ruby is provided after Version 1.9#############
###########				Due to which version < 1.9 will not properly, so to make them work we   #############
###########				providing updated library code. So in short if you are using ruby >= 1.9#############
###########				no need to deploy modified library file & if your ruby < 1.9 then put 	#############
###########				Modified library in same directory we are putting our main-ruby file.   #############
###########		Release Files:-																	#############
########### 			Release containts are in two phases (i) ruby < 1.9 (ii) ruby >= 1.9		#############
###########				Phase-1: ruby < 1.9 													#############
###########					(a) ram_pop.rb		--> main-ruby file								#############
###########					(b) openssl.rb		--> updated library specially ruby < 1.9		#############
###########					(c) MailingSystemConfig.yml   --> having all configuration entry 	#############
###########					(d) 'Data' directory 	-->storage directory for all downloaded file#############
###########					(e) 'Log' direcotory 	--> Log directory 							#############
###########				Phase-2: ruby >= 1.9													#############
###########					(a) ram_pop.rb		--> main-ruby file								#############
###########					(b) MailingSystemConfig.yml   --> having all configuration entry 	#############
###########					(c) 'Data' directory 	-->storage directory for all downloaded file#############
###########					(d) 'Log' direcotory 	--> Log directory 							#############
###########																						#############
###########		Directory & File locations :-													#############
###########					(a) ram_pop.rb		--> anywhere									#############
###########					(b) openssl.rb		--> parallel to ram_pop.rb file 				#############
###########					(c) MailingSystemConfig.yml   --> Parallel to ram_pop.rb file 		#############
###########					(d) 'Data' directory 	--> Parallel to ram_pop.rb file				#############
###########					(e) 'Log' direcotory 	--> Parallel to ram_pop.rb file OR anywhere #############
###########		Pre-modification :-																#############
###########				Update MailingSystemConfig.yml file according to our need 				#############
#############################################################################################################
						
