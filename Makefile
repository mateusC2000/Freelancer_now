bash:
	docker compose run --rm app bash

lint:
	rubocop

test:
	docker compose run --rm app bash -c "rspec"

docker_run:
	docker compose run --rm -p 3000:3000 app
