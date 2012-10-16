require 'rubygems'
require 'open-uri'
gem 'xml-smart', '>= 0.3.0'
require 'xml/smart'

module Riddl
  class Wrapper
    class WrapperUtils
      def get_resource_deep(path,pres)
        #{{{
        path.split('/').each do |pa|
          next if pa == ""
          if pres.resources.has_key?(pa)
            pres = pres.resources[pa]
          else
            return nil
          end
        end
        pres
        #}}}
      end
      def rpaths(res,what)
        #{{{
        what += what == '' ? '/' : res.path
        ret = [[what,res.recursive]]
        res.resources.each do |name,r|
          ret += rpaths(r,what == '/' ? what : what + '/')
        end
        ret.sort!
        ret
        #}}}
      end  
      protected :rpaths, :get_resource_deep
    end
  end  
end
    
require File.expand_path(File.dirname(__FILE__) + '/wrapper/description')
require File.expand_path(File.dirname(__FILE__) + '/wrapper/declaration')
require File.expand_path(File.dirname(__FILE__) + '/wrapper/messageparser')
require File.expand_path(File.dirname(__FILE__) + '/wrapper/resourcechecker')
require File.expand_path(File.dirname(__FILE__) + '/wrapper/layerchecker')
require File.expand_path(File.dirname(__FILE__) + '/handlers')
require File.expand_path(File.dirname(__FILE__) + '/roles')

module Riddl
  class Wrapper
    #{{{
    VERSION_MAJOR = 1
    VERSION_MINOR = 0
    VERSION = "#{VERSION_MAJOR}.#{VERSION_MINOR}"
    DESCRIPTION = "http://riddl.org/ns/description/#{VERSION}"
    DECLARATION = "http://riddl.org/ns/declaration/#{VERSION}"
    XINCLUDE = "http://www.w3.org/2001/XInclude"
    DESCRIPTION_FILE = "#{File.dirname(__FILE__)}/ns/description/#{VERSION_MAJOR}.#{VERSION_MINOR}/description.rng"
    DECLARATION_FILE = "#{File.dirname(__FILE__)}/ns/declaration/#{VERSION_MAJOR}.#{VERSION_MINOR}/declaration.rng"
    COMMON = "datatypeLibrary=\"http://www.w3.org/2001/XMLSchema-datatypes\" xmlns=\"#{DESCRIPTION}\" xmlns:xi=\"http://www.w3.org/2001/XInclude\""
    CHECK = "<element name=\"check\" datatypeLibrary=\"http://www.w3.org/2001/XMLSchema-datatypes\" xmlns=\"http://relaxng.org/ns/structure/1.0\"><data/></element>"
    #}}}

    def initialize(name,get_description=false)
      #{{{
      @doc = nil
      begin
        fh = name.respond_to?(:read) ? name : open(name)
        @doc = XML::Smart.string(fh.read)
        fh.close
      rescue
        begin
          @doc = XML::Smart.string(name)
        rescue
          raise SpecificationError, 'No RIDDL description or declaration found (neither a file, url or string).'
        end
      end  
      @doc.register_namespace 'des', DESCRIPTION
      @doc.register_namespace 'dec', DECLARATION
      @doc.register_namespace 'x',   XINCLUDE
      @doc.find('//x:include/@href').each do |i|
        if i.value =~ /^http:\/\/(www\.)?riddl\.org(\/ns\/common-patterns\/.*)/
          t = File.expand_path(File.dirname(__FILE__)) + $2
          i.value = t if File.exists?(t)
        end
      end
      @doc.xinclude!
      qname = @doc.root.qname
      @is_description = qname.href == DESCRIPTION && qname.name ==  'description'
      @is_declaration = qname.href == DECLARATION && qname.name ==  'declaration'
  
      if @is_description && get_description
        n = @doc.root.children
        if n.empty?
          @doc.root.add("message",:name=>"riddl-description-request").add("parameter",:name=>"riddl-description",:type=>"string")
          @doc.root.add("message",:name=>"riddl-description-response").add("parameter",:name=>"riddl-description",:mimetype=>"text/xml")
        else
          n.first.add_before("message",:name=>"riddl-description-response").add("parameter",:name=>"riddl-description",:mimetype=>"text/xml")
          n.first.add_before("message",:name=>"riddl-description-request").add("parameter",:name=>"riddl-description",:type=>"string")
        end  

        r = @doc.find("/des:description/des:resource")
        unless r.empty?
          n = r.first.children
          if n.empty?
            r.add("get",:in=>'riddl-description-request',:out=>'riddl-description-response')
          else  
            n.first.add_before("get",:in=>'riddl-description-request',:out=>'riddl-description-response')
          end  
        end
      end
      @declaration = @description = nil
      #}}}
    end

    def declaration
      #{{{
      if @is_declaration
        @declaration = Riddl::Wrapper::Declaration.new(@doc)
      end
      @declaration
      #}}}
    end
      
    def description
      #{{{
      if @is_description
        @description = Riddl::Wrapper::Description.new(@doc)
      end
      @description
      #}}}
    end

    def role(path) #{{{
      description
      declaration
      return @description.get_resource(path).role if @is_description
      return @declaration.get_resource(path).role if @is_declaration
      nil
    end #}}}

    def io_messages(path,operation,params,headers)
      #{{{
      description
      declaration
     
      req = @description.get_resource(path).access_methods if @is_description
      req = @declaration.get_resource(path).composition    if @is_declaration

      mp = MessageParser.new(params,headers)
      if req.has_key?(operation)
        if @is_description
          r = req[operation][0]
          r.select{|o|o.class==Riddl::Wrapper::Description::RequestInOut}.each do |o|
            return IOMessages.new(o.in, o.out) if mp.check(o.in)
          end
          r.select{|o|o.class==Riddl::Wrapper::Description::RequestTransformation}.each do |o|
            # TODO guess structure from input, create new output structure
            return IOMessages.new(Riddl::Wrapper::Description::Star.new, Riddl::Wrapper::Description::Star.new)
          end
          r.select{|o|o.class==Riddl::Wrapper::Description::RequestStarOut}.each do |o|
            return IOMessages.new(Riddl::Wrapper::Description::Star.new, o.out)
          end
          r.select{|o|o.class==Riddl::Wrapper::Description::RequestPass}.each do |o|
            return IOMessages.new(Riddl::Wrapper::Description::Star.new, Riddl::Wrapper::Description::Star.new)
          end
        end  
        if @is_declaration
          r = req[operation]
          r.select{|o|o.result.class==Riddl::Wrapper::Description::RequestInOut}.each do |o|
            return IOMessages.new(o.result.in, o.result.out, o.route, o.result.interface) if mp.check(o.result.in)
          end
          r.select{|o|o.result.class==Riddl::Wrapper::Description::RequestTransformation}.each do |o|
            # TODO guess structure from input, create new output structure
            return IOMessages.new(Riddl::Wrapper::Description::Star.new, Riddl::Wrapper::Description::Star.new, o.route, o.result.interface)
          end
          r.select{|o|o.result.class==Riddl::Wrapper::Description::RequestStarOut}.each do |o|
            return IOMessages.new(Riddl::Wrapper::Description::Star.new, o.result.out, o.route, o.result.interface)
          end
          r.select{|o|o.result.class==Riddl::Wrapper::Description::RequestPass}.each do |o|
            return IOMessages.new(Riddl::Wrapper::Description::Star.new, Riddl::Wrapper::Description::Star.new, o.route, o.result.interface)
          end
        end  
      end  
      return nil
      #}}}
    end

    def check_message(params,headers,message)
      description
      declaration
      #{{{
      return true if message.class == Riddl::Wrapper::Description::Star
      return true if message.nil? && params == []
      mp = MessageParser.new(params,headers)
      mp.check(message,true)
      #}}}
    end

    def validate!
      #{{{
      if @is_description
        xval = @doc.validate_against(XML::Smart.open(DESCRIPTION_FILE))
        xchk = ResourceChecker.new(@doc).check
        puts xchk.join("\n") unless xchk.empty?
        return xval && xchk.empty?
      end
      if @is_declaration
        xval = @doc.validate_against(XML::Smart.open(DECLARATION_FILE))
        xchk = LayerChecker.new(@doc).check
        puts xchk.join("\n") unless xchk.empty?
        return xval && xchk.empty?
      end
      nil
      #}}}
    end

    def load_necessary_handlers!
      #{{{
      @doc.find("//des:parameter/@handler").map{|h|h.to_s}.uniq.each do |h|
        if File.exists?(File.dirname(__FILE__) + '/handlers/' + File.basename(h) + ".rb")
          require File.expand_path(File.dirname(__FILE__) + '/handlers/' + File.basename(h))
        end
      end
      #}}}
    end
    def load_necessary_roles!
      #{{{
      @doc.find("//des:resource/@role").map{|h|h.to_s}.uniq.each do |h|
        h = HttpGenerator::escape(h)
        if File.exists?(File.dirname(__FILE__) + '/roles/' + h + '.rb')
          require File.expand_path(File.dirname(__FILE__) + '/roles/' + h)
        end
      end
      #}}}
    end

    def paths
      #{{{
      description
      declaration
      tmp = []
      tmp = @description.paths if @is_description 
      tmp = @declaration.paths if @is_declaration
      tmp.map do |t|
        [t[0],Regexp.new("^" + t[0].gsub(/\{\}/,"[^/]+") + (t[1] ? '\/?' : '\/?$'))]
      end
      #}}}
    end

    class IOMessages
      #{{{
      def initialize(min,mout,route=nil,interface=nil)
       @in = min
       @out = mout
       @route = route
       @interface = interface
      end
      def route?
        !(route.nil? || route.empty?)
      end
      attr_reader :in, :out, :route, :interface
      #}}}
    end
    
    def declaration?; @is_declaration; end
    def description?; @is_description; end
  end
end
