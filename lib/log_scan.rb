class LogScan

    def initialize(file_path)
        @file_path = file_path
    end

    def reader
        if File.exists?(@file_path)
            @data = Hash.new { |data, key| data[key] = [] }
            file = File.read(@file_path).split("\n")
            file.each { |line|
                    webpage, ip = line.split(" ")
                    @data[webpage] << ip
            }
            @data
        end
    end

    def sort_list
        @unique
        @new_list = {}
        @data.each { |key, value|
            @new_list[key] = @unique ? value.uniq.size : value.size
        }
        @sorted_list = @new_list.sort_by { |_k, value| value }.reverse.to_h
        return @sorted_list
    end

    def most_views
        @unique = false
        sort_list
    end

    def unique_views
        @unique = true
        sort_list
    end

    def scan_printer
        log_results = []
        all_data = {"Most Views" => most_views, "Unique Views" => unique_views}
        
        all_data.each{|key, value| 
            i = 1
            log_results << "\n#{key}\n" 
            value.each {|key, v|
                log_results << "#{i}) #{key} ==>  #{v > 1 ? "#{v} views." : "#{v} view."}"
                i += 1
            }
        }

        File.write('log-results.txt', log_results.join("\n"))

        all_data # Just for the rspec test
    end

    

end