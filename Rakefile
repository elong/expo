# -*- coding:utf-8 -*-
require 'active_record'
require '../lib/zhanhui'
require '../lib/operation'

namespace zhanhui do

  config = YAML::load( File.open('localhost.yml') )
  ActiveRecord::Base.establish_connection( config )

  class Exhibition < ActiveRecord::Base 
  end
  class CityCode < ActiveRecord::Base
  end

  desc "Update exhibition list"
  task :update_list do
    Zhanhui.get_exi_list().each do |exhibition|
      begin
        Exhibition.new(exhibition).save
      rescue =>e
        p "Fail to add:" + exhibition.to_s
      end
    end
  end

  desc "Query and update city code from another table"
  task :update_city_code do
    Exhibition.where(city_code:nil).each do |exhibition|
      begin
        exhibition[:city_code] = CityCode.where( city:exhibition[:city]).first[:code]
        exhibition.save
      rescue
        p "error updating city_code" + exhibition[:name]
      end
    end
  end

  desc "Clean updated( early than today ) exhibitions"
  task :wash_list()
    """
    Delete outdated record
    """
    Exhibition.all.each do |exhibition|
      if exhibition[:date] < Time.now 
        p "Delete outdated exhibition:" + exhibition[:name]
        exhibition.destory!
      end
    end
  end

  desc "update details. default thread_num is 3"
  task :update_details do
    thread_num = 3

    works = []
    Exhibition.where(has_detail:nil).each{ |record| works << record }

    workers = (0..thread_num).map do 
      # start a new thread
      Thread.new do
        begin 
          while work = works.pop()
            raise "Works finished" if work == nil
            # sleep for 1 second
            sleep( 1.second )
            begin
              p "update details of:" + work[:name].force_encoding('utf-8')
              work = Zhanhui.get_details(work) 
              work[:has_detail] = true      
            rescue => e
              puts "error loading page:" + work[:page]
              work[:has_detail] = false
            ensure
              work.save    
            end
          end
        rescue ThreadError
        end
      end 
    end # works.map
    # hold main thread 
    workers.map(&:join); 
  end


end