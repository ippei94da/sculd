#! /usr/bin/env ruby
# coding: utf-8

require "date"
require "sculd.rb"

require "rubygems"
#gem     "highline"
require "highline"

#
#
#
class Sculd::Manager
  #WEEKDAYS = [ "日", "月", "火", "水", "木", "金", "土" ]
  WEEKDAYS = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ]

  class LoadError < Exception; end

  #
  def initialize(dir, io = $stdout)
    @source_dir = dir
    @plans = []
    Dir.glob("#{@source_dir}/*").each do |file|
      load_file(file, io)
    end
  end

  def show(num_event, num_task, io = $stdout)
    show_events(num_event)
    show_tasks(num_task)
  end

  private

  # read, parse file and set data to @events and @tasks.
  def load_file(file, io = $stdio)

    File.open(file, "r").readlines.each_with_index do |line, index|
      begin
        elems = Sculd::Plan.parse(line, io)
        next unless elems[:type]
        case elems[:type]
        when Sculd::Plan::Schedule::SYMBOL_CHAR
          plan_class = Sculd::Plan::Schedule
        when Sculd::Plan::Deadline::SYMBOL_CHAR
          plan_class = Sculd::Plan::Deadline
        when Sculd::Plan::Reminder::SYMBOL_CHAR
          plan_class = Sculd::Plan::Reminder
        when Sculd::Plan::Todo::SYMBOL_CHAR
          plan_class = Sculd::Plan::Todo
        else
          next
        end
        @plans << plan_class.new(elems[:datetime   ],
                                 elems[:flag_time  ],
                                 elems[:option     ],
                                 elems[:description],
                                )
      rescue Sculd::Plan::WeekdayMismatchError
        io.puts "error occured at #{index}: #{line.to_i + 1}"
        raise LoadError
      rescue Sculd::Plan::NotNumberError
        #io.puts "error occured at #{index}: #{line+1}"
        #raise LoadError
        next
      rescue
        # do nothing
      end
    end
  end

  # Show events in 'num' days from todary.
  def show_events(num, today = Date.today, io = $stdout)
    return if num == 0
    hl = HighLine.new($stdin, io)

    d_e = days_events
    io.puts "Events:"
    num.times do |i|
      date = today + i
      str = " #{date.to_s} #{WEEKDAYS[date.wday]} "

      case date.wday
      when 0
        hl.say("  <%= color('#{str}', :white, :on_red) %>\n")
      when 6
        hl.say("  <%= color('#{str}', :white, :on_blue) %>\n")
      else
        hl.say("  <%= color('#{str}', :white, :on_black) %>\n")
      end

      events = d_e[date]
      if events # if plan is not empty.
        #HIGHLINE.say("<%= color('red', :red) %>!")
        #HIGHLINE.say("  <%= color(#{date.to_s} #{WEEKDAYS[date.wday]}, :white, :red) %>")
        #hl.say("  <%= color('red', :red) %>!")
        #io.puts str
        events.sort_by{|i| i.datetime}.each do |event|
          #pp event

          io.print("    ") #indent
          event_date = Date.new(event.datetime.year,
                                event.datetime.month,
                                event.datetime.day)
          if event_date != date
            io.printf("<%02d/%02d>", event.datetime.month, event.datetime.day )
          elsif event.flag_time
            io.printf("[%02d:%02d]", event.datetime.hour, event.datetime.minute )
          else
            io.print("       ")
          end
          io.printf("%s", event.class::SYMBOL_CHAR )
          io.printf("%-2s ", event.option.to_s )
          io.puts "#{event.description}"

          #io.puts "    #{event.description.strip}"
        end
      else
        io.puts "    (no event)"
      end
      io.puts
    end
  end

  # Return a hash of dates and events.
  # The eventes generated from @schedules sorted by date and time.
  def days_events
    results = {}
    @plans.each do |plan|
      #puts
      #p plan
      plan.event_dates.each do |date|
        #pp date
        results[date] ||= []
        results[date] << plan
      end
    end
    return results
  end

  # Show 'num' tasks of the highest priority.
  def show_tasks(num, today = Date.today, io = $stdout)
    return if num == 0

    io.puts "Tasks:"
    plans = @plans.sort_by {|plan| plan.priority(today)}.reverse

    num = plans.size if plans.size < num
    plans[0..(num-1)].each do |plan|
      io.printf("  [%4d-%02d-%02d]",
        plan.datetime.year,
        plan.datetime.month,
        plan.datetime.day,
               )
      io.printf("%s%-2s %s",
        plan.class::SYMBOL_CHAR,
        plan.option.to_s,
        plan.description
      #io.print "  #{plan.description.strip}"
      )
      io.puts
    end
  end
end

