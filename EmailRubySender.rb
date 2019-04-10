require 'mail'

options = { :address              => 'posta.dotvocal.com',
    :port                 => '465',
    :domain               => 'dotvocal.com',
    :user_name            => 'beltrami@dotvocal.com',
    :password             => 'Yamahas90xs',
    :authentication       => :login,
    :ssl                  => true,
    :openssl_verify_mode  => 'none' #Use this because ssl is activated but we have no certificate installed. So clients need to confirm to use the untrusted url.
}


Mail.defaults do
  delivery_method :smtp, options
end

if ( ARGV[0] =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/ )
Mail.deliver do
	to ARGV[0]
	from 'beltrami@dotvocal.com'
  	subject 'Server Status'
  	body "Server is offline, code error #{ARGV[1]}"
	end
else
puts "Invalid email"
end
