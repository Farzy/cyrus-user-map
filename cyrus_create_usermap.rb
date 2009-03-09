#!/usr/bin/env ruby
# -*- coding: utf8 -*-
# vim: sw=2 sts=2:

# cyrus_create_usermap: Create a Postfix map table listing all
# valid email user accounts available in the Cyrus Imap database.
# The map uses the Postfix "hash" format.
#
# Date: 2009/03/09
#
# Copyright (C) 2009 Farzad FARID <ffarid@pragmatic-source.com>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.


#################
# Configuration #
#################

CYRUS_CMD = "/usr/sbin/ctl_mboxlist"
USERS_MAPFILE = "/etc/postfix/cyrus_usermap"

# Main program

if Process.uid != 0
  abort "ERROR: #{$0} must be called as root."
end

File.open(USERS_MAPFILE, "w") do |outfile|
  outfile.write <<-EOT
# This is an auto-generated file, do now modify directly.
# File created on #{Time.now}
# by #{$0}.
# See http://github.com/Farzy/cyrus-user-map/ for details.

EOT
  IO.popen("sudo -u cyrus #{CYRUS_CMD} -d") do |pipe|
    while line = pipe.gets
      # Only extract top level mailboxes like "my.domain.com!user.mylogin<TAB>..."
      outfile.puts "#{$2}@#{$1}\tOK" if line.match /^(.+)!user\.([^.\t]+)\t/
      # Now extract top loevel mailboxes without a domain prefix
      outfile.puts "#{$1}\tOK" if line.match /^user\.([^.\t]+)\t/
    end
  end
end
# Generate the hash map
system("postmap hash:#{USERS_MAPFILE}")

exit 0

