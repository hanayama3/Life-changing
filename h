
[1mFrom:[0m /home/ubuntu/environment/Habit-is-power/app/controllers/users_controller.rb:42 UsersController#complete:

    [1;34m30[0m: [32mdef[0m [1;34mcomplete[0m
    [1;34m31[0m:  before_level = @user.level
    [1;34m32[0m:  [32munless[0m complete_params.empty?
    [1;34m33[0m:   @habit = [1;34;4mHabit[0m.find(complete_params)
    [1;34m34[0m:   @habit.each [32mdo[0m |h|
    [1;34m35[0m:   h.update_attributes([35mcomplete[0m: h.complete += [1;34m1[0m)
    [1;34m36[0m:   @user.update_attributes([35mlevel[0m: @user.level += [1;34m1[0m)
    [1;34m37[0m:  [32mend[0m
    [1;34m38[0m:  [32mif[0m flash[[33m:notice[0m].nil?
    [1;34m39[0m:     flash[[33m:notice[0m] = [31m[1;31m"[0m[31m達成！[1;31m"[0m[31m[0m
    [1;34m40[0m:   [32melse[0m
    [1;34m41[0m:     flash[[33m:notice[0m] << [31m[1;31m"[0m[31m達成！[1;31m"[0m[31m[0m
 => [1;34m42[0m:     binding.pry
    [1;34m43[0m:     flash[[33m:notice[0m].join
    [1;34m44[0m:   [32mend[0m
    [1;34m45[0m: [32mend[0m
    [1;34m46[0m: @user.record(before_level)
    [1;34m47[0m: redirect_to @user
    [1;34m48[0m: [32mend[0m

