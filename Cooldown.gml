function Cooldown(_max_time, _on_complete = undefined) {
    return {
        time_max: _max_time,
        time_left: 0,
        active: false,
        paused: false,
        on_complete: _on_complete ?? function() {},

        start: function() {
            self.time_left = self.time_max;
            self.active = true;
            self.paused = false;
        },

        update: function() {
            if (self.active && !self.paused) {
                self.time_left -= 1;
                if (self.time_left <= 0) {
                    self.time_left = 0;
                    self.active = false;
                    self.on_complete();
                }
            }
        },

        pause: function() {
            self.paused = true;
        },

        resume: function() {
            self.paused = false;
        },

        reset: function() {
            self.time_left = 0;
            self.active = false;
            self.paused = false;
        },

        ready: function() {
            return !self.active;
        },

        percent: function() {
            return clamp(1 - (self.time_left / self.time_max), 0, 1);
        }
    };
}
