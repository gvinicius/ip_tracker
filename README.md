### Ip Tracker

Track and rank requesting IPs with Ruby.

## Discussion

- What would you do differently if you had more time?
If had more time, I would also write a small Sinatra Web API just for providing a more real-life
example and shipping this tracker as ruby gem to be imported in the Sinatra API.


- What is the runtime complexity of each function?
request\_handled(ip\_address]) => O(1)

count\_entries(ips) => O(n2)

top100() => O(log n)

clear() => O(n)


- How does your code work?
My code work as object-oriented entity that is stores all requested ips in an attirbute called ips,
and has instances methods implementing each one of the requirements. Besides, the method for
ranking the 100-most frequent ips follows a concurrent approach in batches to deal with millions
records in a quikier way. Moreover, added in auxiliary method to the raking for a better separation
of concerns.

- What other approaches did you decide not to pursue?
I decided to not pursue an entirely concurrent-approach, which means that I could have made the
ip storing and clearing as concurrent as the raking method is, but the gains in doing
it seemed to be not much significant.


- How would you test this?
I would test this by writing benchmark comparisions. I could implement tests like that by writing
specific test cases with RSpec.

## Setup
```
# install ruby 3.0.2
```

```
bundle install
```

```
bundle exec rspec spec/tracker_spec.rb # for testing
```

## Run
```
irb
require_relative './tracker'
tracker = Tracker.new
tracker.request_handled('145.87.2.109')
tracker.top100()
tracker.clear()
tracker.top100()
```

