module TeachersHelper

  def get_today_classes
    Teacher.where('user_id =? AND start_datetime>=?',params[:id], Time.now.beginning_of_day)
  end

  def get_today_classes_by_datatime
    classes = Teacher.where('user_id =? AND start_datetime>=?',params[:id], Time.now.beginning_of_day).pluck(:start_datetime)
    all_classes = []
    if classes.any?
      classes.each do |clas|
        single_classes_duration =[]
        stat_date_time = clas.strftime('%H:%M %p')
        end_date_time = (clas + 1.hour).strftime('%H:%M %p')
        single_classes_duration.push(stat_date_time)
        single_classes_duration.push(end_date_time)
        all_classes.push(single_classes_duration)
      end
    end
    all_classes
  end
end
