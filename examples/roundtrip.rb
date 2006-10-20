#!/usr/bin/env ruby
require 'gpgme'

# If you do not have gpg-agent installed, comment out the following
# and set it as :passphrase_callback.
#
# def passfunc(hook, uid_hint, passphrase_info, prev_was_bad, fd)
#   $stderr.write("Passphrase for #{uid_hint}: ")
#   $stderr.flush
#   begin
#     system('stty -echo')
#     io = IO.for_fd(fd, 'w')
#     io.puts(gets)
#     io.flush
#   ensure
#     (0 ... $_.length).each do |i| $_[i] = ?0 end if $_
#     system('stty echo')
#   end
#   puts
# end

unless ENV['GPG_AGENT_INFO']
  $stderr.puts("gpg-agent is not running.  See the comment in #{$0}.")
  exit(1)
end

plain = 'test test test'
puts("Plaintext:\n#{plain}")

# Perform symmetric encryption on PLAIN.
cipher = GPGME::encrypt(nil, plain, {:armor => true
			  # :passphrase_callback => method(:passfunc)
			})
puts("Ciphertext:\n#{cipher}")

plain = GPGME::decrypt(cipher, {
			 # :passphrase_callback => method(:passfunc)
		       })
puts("Plaintext:\n#{plain}")
