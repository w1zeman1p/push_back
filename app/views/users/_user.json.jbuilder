json.id user.id
json.f_name user.f_name
json.l_name user.l_name
json.email user.email
json.daily_goal user.daily_goal
json.lifetime_total user.lifetime_total
json.last_rep_count user.last_rep_count
json.seven_day_count user.seven_day_count
json.fbid user.authorizations.find_by(provider: :facebook).try(:uid)
