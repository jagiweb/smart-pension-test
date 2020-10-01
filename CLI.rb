require './lib/log_scan'

scan = LogScan.new(ARGV[0])


def scan_display(data)
    i = 1
    data.each do |key, v|
      puts "#{i}) #{key} ==>  #{v > 1 ? "#{v} views." : "#{v} view."}"
      i+=1
    end
end

scan.reader

if scan.reader
    puts "\n\t\tMOST VIEWS \n\n"
    scan_display(scan.most_views)
    puts "\n"
    puts "\t\tUNIQUE VIEWS"
    puts "\n"
    scan_display(scan.unique_views)
    puts "\n"
    puts "Would you like to print a file in the app directory with the results?"
    puts "1. Yes"
    puts "2. No"
    puts "3. Exit"
    ARGV.clear
    input = gets.chomp
    while input != "3"
        case input
        when "1"  
            scan.scan_printer
            puts 'Your file have been created successfully. Name of the file "log-results.txt"'
            break
        when "2"
            puts "The file has not been created"
            break
        when "3"
            !exit
        else
            puts "Please select the an option between 1 and 2"
            input = gets.chomp
        end
    end 
else
    puts "\n"
    puts "Please insert a file or directory"
    puts "\n"
end
