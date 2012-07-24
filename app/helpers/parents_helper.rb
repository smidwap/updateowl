module ParentsHelper
  def who_last_edited_parent(parent)
    last_audit = parent.audits.last
    if !last_audit.user_id?
      "This parent"
    else
      second_or_third_person(last_audit.user).capitalize
    end
  end
end