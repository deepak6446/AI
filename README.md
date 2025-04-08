# Step 1: Create README.md with instructions

echo "# TSS Model

## How to Run

Move into the Docker CPU directory:

\`\`\`bash
mv Kokoro-FastAPI/docker/cpu
\`\`\`

Then build and run the Docker containers:

\`\`\`bash
docker container prune -f && DOCKER_BUILDKIT=1 docker-compose up --build
\`\`\`
" > README.md
