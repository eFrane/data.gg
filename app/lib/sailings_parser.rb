require 'nokogiri'
require 'open-uri'
require 'time'

class SailingsParser

  def self.get_sailings
    table_to_sailings_array
  end

  private

  def self.table_to_sailings_array
    arrivals_departures = get_arrivals_departures_json()

    if arrivals_departures == nil
      return []
    end

    return arrivals_departures
  end


  def self.get_arrivals_departures_json
    arrival_url = 'http://www.harbours.gg/152445'
    arrival_json = JSON.load(open(arrival_url))

    departure_url = 'http://www.harbours.gg/152446'
    departure_json = JSON.load(open(departure_url))

    sailings = []

    arrival_column_names = {
      0 => 'Vessel',
      1 => 'Time',
      2 => 'Type',
      3 => 'Source',
      4 => 'Arrived'
    }

    arrival_json.each do |arrival|
      sailings_info_hash = { }
      sailings_info_hash[arrival_column_names[0]] = arrival['vessel']
      time_str = arrival['time'] + ' ' + arrival['date']
      zone = 'London'
      time = ActiveSupport::TimeZone[zone].parse(time_str, DateTime.now)
      sailings_info_hash[arrival_column_names[1]] = time
      sailings_info_hash[arrival_column_names[2]] = 'Arrival'
      sailings_info_hash[arrival_column_names[3]] = arrival['port']
      sailings_info_hash[arrival_column_names[4]] = arrival['arrived']
      sailings << sailings_info_hash
    end

    departure_column_names = {
      0 => 'Vessel',
      1 => 'Time',
      2 => 'Type',
      3 => 'Destination',
      4 => 'Departed'
    }

    departure_json.each do |departure|
      sailings_info_hash = { }
      sailings_info_hash[departure_column_names[0]] = departure['vessel']
      time_str = departure['time'] + ' ' + departure['date']
      zone = 'London'
      time = ActiveSupport::TimeZone[zone].parse(time_str, DateTime.now)
      sailings_info_hash[departure_column_names[1]] = time
      sailings_info_hash[departure_column_names[2]] = 'Departure'
      sailings_info_hash[departure_column_names[3]] = departure['port']
      sailings_info_hash[departure_column_names[4]] = departure['departed']
      sailings << sailings_info_hash
    end


    return sailings
  end

  def self.get_arrivals_departures_tables
    url = 'http://www.harbours.gg/article/151766/Arrivals--Departures-scheduled-for-today--tomorrow'
    opened_url = open(url)
    doc = Nokogiri::HTML(opened_url) do |config|
      config.default_html.noent.nsclean
    end

    active_date = DateTime.now.beginning_of_day + 1.days

    arrival_column_names = {
      0 => 'Vessel',
      1 => 'Time',
      2 => 'Type',
      3 => 'Source',
      4 => 'Arrived'
    }

    departure_column_names = {
      0 => 'Vessel',
      1 => 'Time',
      2 => 'Type',
      3 => 'Destination',
      4 => 'Departed'
    }

    sailings = []


    set_back_start = 0
    set_back_end  = 0

    #<div class="tomorrowSep">Sailings scheduled for tomorrow</div>

    column_names = nil
    type = nil
    found_set_back = false

    doc.css('div#content').each do |root|

      root.children.each_with_index do |content, i|

        sailings_info_hash = { }

        if content.attr('class') == 'headerRowContainer'
        # Arrivals show first, could use class but already have to do this
        # to figure out the day anyway.
        if type.nil?
          #p 'Arrival Found'
          type = 'Arrival'
          column_names = arrival_column_names
        else
          #p 'Departure Found'
          type = 'Departure'
          column_names = departure_column_names
        end

        set_back_start = i
        set_back_end = i
      end


      set_back_end = i



      # Found next day marker, set previous
      if content.attr('class') == 'tomorrowSep'# || type == 'Departure'
        found_set_back = true

      #p "i is #{i}"
      #p "start is #{set_back_start}"
      #p "end is #{set_back_end}"
      #p sailings.count

        sailings[set_back_start..set_back_end].each do |set_back|
          #p set_back
          #p set_back.length

          next if set_back.length == 0
          set_back[column_names[1]] = set_back[column_names[1]] - 1.days
        end

        set_back_start = i
      end

      if !content.attr('class').nil? && content.attr('class').include?('recordContainer')

        #if record.attr('class').include? 'arrival'
            #type = 'Arrival'
            #column_names = arrival_column_names
        #  end

         # if record.attr('class').include? 'departure'
            #type = 'Departure'
            #column_names = departure_column_names
          #end

          content.css('div.recordRow').each do |record_data|
            vessel_text = record_data.children[0].text
            location_text = record_data.children[1].text
            time_text = record_data.children[2].text
            reached_text = record_data.children[3].text


            sailings_info_hash = { }
            sailings_info_hash[column_names[0]] = vessel_text

            time_parse_str = '%Y-%m-%d %H:%M'
            time_str = active_date.strftime('%Y-%m-%d') + ' ' + time_text
            zone = 'London'
            time = ActiveSupport::TimeZone[zone].parse(time_str, DateTime.now)


            sailings_info_hash[column_names[1]] = time

            sailings_info_hash[column_names[2]] = type

            sailings_info_hash[column_names[3]] = location_text
            sailings_info_hash[column_names[4]] = reached_text
          end
        end

        sailings << sailings_info_hash
      end
    end

    is_before_midday = DateTime.now < DateTime.now.middle_of_day

    #p found_set_back
    #p is_before_midday

    # So the list can be without any indication of which day it is
    # If we're before midday on the current day (and found no date indicators)
    # then set back all the dates to today (default is tomorrow)

    if !found_set_back && is_before_midday
      sailings.each do |set_back|
        next if set_back.length == 0
        set_back[column_names[1]] = set_back[column_names[1]] - 1.days
      end
    end

    return sailings.delete_if {|k,v| k.length == 0 }
  end
end