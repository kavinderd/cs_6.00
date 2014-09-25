module University

  class Subject < Struct.new(:value, :work_load); end;

  class Advisor
    FILE_PATH = "./assignment_8/subjects.txt"
    
    attr_reader :subjects
    def initialize(file=FILE_PATH)
      @file = file
      load_subjects
    end

    def greedily_advise(max_work:, comparator: :work)
      result = {}
      sorted_keys = send("sort_by_#{comparator}", max_work)
      total_work = 0
      sorted_keys.each do |key|
        if total_work < max_work && @subjects[key].work_load <= (max_work - total_work)
          result[key] = @subjects[key]
          total_work += @subjects[key].work_load
        end
      end
      result
    end
    
    # This algorithm becomes unreasonably expensive when max_work >= 5
    def exhaustively_advise_time(max_work:)
      start_time = Time.now
      result = exhaustively_advise(max_work: max_work)
      end_time = Time.now
      puts "Took #{end_time - start_time}"
    end

    def exhaustively_advise(max_work:)
      keys= @subjects.keys      
      values = @subjects.values
      result = {}
      best_subset, best_subset_value = exhaustively_advise_search(values: values, i: 0,
                                         max_work: max_work, best_subset: nil,
                                         best_subset_value: nil,
                                         subset: [], 
                                         subset_value: 0,
                                         subset_work: 0)
      best_subset.each do |i|
        result[keys[i]] = values[i]
      end
    end

    def exhaustively_advise_search(values:, max_work:,i:, best_subset:, best_subset_value:, subset:, subset_value:, subset_work:)
      s = values[i]
      #Check if i is at the end of the list
      if i >= values.length
        if !best_subset || subset_value > best_subset_value
          return [subset, subset_value]
        else
          return [best_subset, best_subset_value]
        end
      end
      if subset_work + s.work_load <= max_work
        #There is room in subset for this course
        subset.push(i)
        best_subset, best_subset_value = exhaustively_advise_search(values: values, max_work: max_work,
                                                                    i: i+1, best_subset: best_subset,
                                                                    best_subset_value: best_subset_value,
                                                                    subset: subset,
                                                                    subset_value: subset_value + s.value,
                                                                    subset_work: subset_work + s.work_load)
        subset.pop
      end
      #Check the subset without picking the current node
      best_subset, best_subset_value = exhaustively_advise_search(values: values, max_work: max_work,
                                                                  i: i+1, best_subset: best_subset,
                                                                  best_subset_value: best_subset_value,
                                                                  subset: subset,
                                                                  subset_value: subset_value,
                                                                  subset_work: subset_work)
      [best_subset, best_subset_value]
    end

    # Dp Advise runs significantly faster than the brute force method and can handle much larger sizes of max work
    def dp_advise_time(max_work:)
      start_time = Time.now
      result = dp_advise(max_work: max_work)
      end_time = Time.now
      puts "DP Advise Time for max_work: #{max_work} = #{end_time - start_time}"
    end

    def dp_advise(max_work:)
      keys = @subjects.keys
      values = @subjects.values
      best_subset, best_value = dp_advise_search(values: values, max_work: max_work, i: 0, best_subset: nil, best_subset_value: nil, subset: [], subset_value: 0, subset_work: 0, memo: {})
      result = {}
      best_subset.each do |i|
        result[keys[i]] = values[i]
      end
      result
    end

    def dp_advise_search(values:,  max_work:, i:, best_subset:, best_subset_value:, subset: , subset_value:, subset_work:, memo:)
      s = values[i]
      if memo[[i, subset_work]]
        return memo[[i, subset_work]]
      else
        if i >= values.length
          if !best_subset || subset_value > best_subset_value
            memo[[i, subset_work]] = [subset, subset_value]
            return memo[[i, subset_work]]
          else
            memo[[i, subset_work]] = [best_subset, best_subset_value]
            return memo[[i, subset_work]]
          end
        end
        if subset_work + s.work_load <= max_work
          #There is room in subset for this course
          subset.push(i)
          best_subset, best_subset_value = dp_advise_search(values: values, max_work: max_work,
                                                                      i: i+1, best_subset: best_subset,
                                                                      best_subset_value: best_subset_value,
                                                                      subset: subset,
                                                                      subset_value: subset_value + s.value,
                                                                      subset_work: subset_work + s.work_load,
                                                                      memo: memo)
          subset.pop
        end
        #Check the subset without picking the current node
        best_subset, best_subset_value = dp_advise_search(values: values, max_work: max_work,
                                                                    i: i+1, best_subset: best_subset,
                                                                    best_subset_value: best_subset_value,
                                                                    subset: subset,
                                                                    subset_value: subset_value,
                                                                    subset_work: subset_work, 
                                                                    memo: memo)
        memo[[i, subset_work]] = [best_subset, best_subset_value]
      end
    end

    def load_subjects
      @subjects = {}
      File.readlines(@file).each do |line|
        parts = line.chomp.split(",")
        subject = Subject.new(parts[1].to_i, parts[2].to_i)
        @subjects[parts[0]] = subject
      end
    end

    def sort_by_value(max_work)
      @subjects.sort_by { |k, v| v.value }.reverse.delete_if { |a| a.last.work_load > max_work}.map { |i| i.first }
    end

    def sort_by_work(max_work)
      @subjects.sort_by { |k,v| v.work_load }.reverse.delete_if { |a| a.last.work_load > max_work }.map { |i| i.first }
    end

    def sort_by_ratio(max_work)
      @subjects.sort_by { |k,v| v.value / v.work_load }.reverse.delete_if { |a| a.last.work_load > max_work }.map { |i| i.first }
    end
  end 
end
