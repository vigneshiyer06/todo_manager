class Todo < ActiveRecord::Base
  def to_pleasant_string
    is_completed = completed ? "[X]" : "[ ]"
    "#{id}. #{due_date.to_s(:long)} #{todo_text} #{is_completed}"
  end

  @todos_list = { :overdue => [], :due_today => [], :due_later => [] }

  def due_today?
    due_date == Date.today
  end

  def self.overdue
    all.where("due_date < ? and not completed ", Date.today)
  end
  def self.due_later
    all.where("due_date > ?", Date.today)
  end
  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list(due_status)
    @todos_list[due_status].map { |todo| todo.to_displayable_string() }
  end

  def self.show_list
    @todos_list[:overdue] = all.where("due_date < ?", Date.today)
    @todos_list[:due_today] = all.where("due_date = ?", Date.today)
    @todos_list[:due_later] = all.where("due_date > ?", Date.today)

    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts to_displayable_list(:overdue)
    puts "\n\n"

    puts "Due Today\n"
    puts to_displayable_list(:due_today)
    puts "\n\n"

    puts "Due Later\n"
    puts to_displayable_list(:due_later)
    puts "\n\n"
  end

  def self.add_task(new_todo)
    create!(todo_text: new_todo.values[0], due_date: Date.today + new_todo.values[1], completed: false)
  end

  def self.mark_as_complete!(todo_id)
    all.update(todo_id, completed: true)
  end
  def self.completed
    all.where(completed: true)
  end
end
