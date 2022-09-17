### TODO API using Ruby Sinatra [^1] [^2]

#### Up and Running
```
1. rvm install 2.7.4 (if not already installed)
2. cd TODO_API_DIR
3. bundle install
4. bundle exec rake db:create
5. bundle exec rake db:migrate
6. rackup -p 4567
```

#### CRUD
* curl -X POST -F 'todo=TEST' http://127.0.0.1:4567/api/v1/todos
* curl http://127.0.0.1:4567/api/v1/todos (Note the id here for PATCH and DELETE requests)
* curl -X PATCH -F 'todo="TEST - marked as completed"' -F 'completed=true' http://127.0.0.1:4567/api/v1/todos/1
* curl -X DELETE http://127.0.0.1:4567/api/v1/todos/1

[^1]: To be dcokerized? Should be!
[^2]: Production db? hmm, yes that needs changes.
