# Observer pattern works in this way.
# We have one component that’s being ‘watched’ by other components.
# When the component being watched changes it sends out a message to the other components that basically says
# “ I’m different now ”, and anyone waiting for this message can change accordingly.

# Also main idea the Subject class don't need to changed even if we have one more observer.

# Example
# First state

class Professor
  attr_reader :name, :class_name, :exam_date
  def initialize(name, class_name, student, secretary, dean)
    @name = name
    @class = class_name

    @student = student
    @secretary = secretary
    @dean = dean
  end

  def set_midterm(midterm_date)
    @exam_date = midterm_date
    @student.update(self)
    @secretary.update(self)
    @dean.update(self)
  end
end

class Student
  def update(prof)
    puts "I need to start studying for Prof. #{prof.name} exam on the #{prof.exam_date}"
  end
end

class Secretary
  def update(prof)
    puts "I will find a room for the midterm on the #{prof.exam_date}"
  end
end

class Dean
  def update(prof)
    puts "I will go over the midterm before #{prof.exam_date}"
  end
end

student = Student.new
secretary = Secretary.new
dean = Dean.new
prof = Professor.new("Jeff Professor", "Software Engineering", student, secretary, dean)
prof.set_midterm("Oct 25th")


# Second state

class Professor
  attr_reader :name, :class_name, :exam_date
  attr_accessor :observers

  def initialize(name, class_name)
    @name = name
    @class = class_name
    @observers = []
  end

  def set_midterm(midterm_date)
    notify_observers
  end

  def add_observer(observer)
    @observers << observer
  end

  def notify_observers
    observers.each do |observer|
      observer.update(self)
    end
  end
end

prof.add_observer(student)
prof.add_observer(secretary)
prof.add_observer(dean)

# And the las step move logic to module

class Professor
  include Subject

  attr_reader :name, :class_name, :exam_date
  attr_accessor :observers

  def initialize(name, class_name)
    super()
    @name = name
    @class = class_name
  end

  def set_midterm(exam_date)
    notify_observers
  end
end

module Subject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observer.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end
end
