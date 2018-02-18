  def new
    letters = ("a".."z").to_a
    @chosen_letters = []
    number_of_letters = 10
    until @chosen_letters.length == number_of_letters
      sample = letters.sample
      if @chosen_letters.index(sample)
        puts "letter already present"
      else
        @chosen_letters << sample
      end
    end
    @chosen_letters
  end

  new
