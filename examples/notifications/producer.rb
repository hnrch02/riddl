#!/usr/bin/ruby
require File.expand_path(File.dirname(__FILE__) + '/../../lib/riddl/server')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/riddl/utils/fileserve')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/riddl/utils/notifications_producer')

Riddl::Server.new(::File.dirname(__FILE__) + '/producer.declaration.xml', :port => 9291) do
  accessible_description true
  backend =  Riddl::Utils::Notifications::Producer::Backend.new(
    ::File.dirname(__FILE__) + '/notifications/topics.xml',
    ::File.dirname(__FILE__) + '/notifications/'
  )

  interface 'fluff' do
    run Riddl::Utils::FileServe, "implementation/index.html" if get
    on resource 'oliver' do
      run Riddl::Utils::FileServe, "implementation/oliver.html" if get
    end  
    on resource 'juergen' do
      run Riddl::Utils::FileServe, "implementation/juergen.html" if get
    end
  end

  interface 'main' do |r|
    use Riddl::Utils::Notifications::Producer::implementation(backend,nil,@riddl_opts[:mode])
  end  
end.loop!
