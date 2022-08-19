echo Step 1) Build the Docker container for Kittys Tavern
docker-compose --project-name kittys_tavern build

echo Step 2) Run the Docker container we just created 
start cmd /k docker-compose --project-name kittys_tavern up
pause