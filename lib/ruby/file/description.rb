module Riddl
  class File
    class Description
      class Base
        #{{{
        def initialize(layer,name,type)
          if name.nil?
            @name = @content = @hash = nil
          else  
            @name = name
            @content = layer.find("des:#{type}[@name='#{name}']").first.to_doc
            @content.find("/#{type}/@name").delete_all!
            update_hash!
          end  
        end
        def update_hash!
          # TODO too simple
          @hash = @content.to_s.hash
        end
        def traverse?(other)
          other.name.nil? ? false : (self.hash == other.hash)
        end
        attr_reader :name, :content, :hash
        #}}}
      end

      class Add < Riddl::File::Description::Base
        #{{{
        def initialize(layer,name)
          super layer,name,:add
        end
        #}}}
      end

      class Remove < Riddl::File::Description::Base
        #{{{
        def initialize(layer,name)
          super layer,name,:remove
        end
        #}}}
      end

      class Message < Riddl::File::Description::Base
        #{{{
        def initialize(layer,name)
          super layer,name,:message
        end
        def initialize_copy(o)
          @content = @content.dup 
        end
        def transform(add,remove)
          ret = self.dup
          unless add.name.nil?
            add.content.root.children.each do |e|
              case e.name.name
                when 'before':
                when 'after':
                when 'as_first':
                when 'as_last':
                  ret.content.root.add(e.children)
                  ret.update_hash!
              end  
            end  
          end  
          unless remove.name.nil?
            remove.content.root.children.each do |e|
              case e.name.name
                when 'each':
                  ret.content.find("parameter[@name=\"#{e.attributes['name']}\"]").delete_all!
                when 'first':
                  if e.attributes['name']
                    case e.attributes['type']
                      when 'parameter', nil:
                        ret.content.find("//parameter[first()]").delete_all!
                      when 'header':
                        ret.content.find("//header[first()]").delete_all!
                    end    
                  else
                    case e.attributes['type']
                      when 'parameter', nil:
                        node = ret.content.find("//parameter[@name=\"#{add.attributes['name']}\"]").first
                        opt = node.add_before("optional")
                        opt.add(node)
                      when 'header':
                        ret.content.find("header[@name=\"#{add.attributes['name']}\"]").delete_all!
                    end    
                  end
                when 'last':
                  if e.attributes['name']
                    case e.attributes['type']
                      when 'parameter', nil:
                        ret.content.find("//parameter[last()]").delete_all!
                      when 'header':
                        ret.content.find("//header[last()]").delete_all!
                    end    
                  else
                    case e.attributes['type']
                      when 'parameter', nil:
                        node = ret.content.find("//parameter[@name=\"#{add.attributes['name']}\"]").last
                        opt = node.add_before("optional")
                        opt.add(node)
                      when 'header':
                        ret.content.find("header[@name=\"#{add.attributes['name']}\"]").delete_all!
                    end    
                  end
              end  
            end  
          end  
          return ret
        end
        #}}}
      end
    end
  end
end
