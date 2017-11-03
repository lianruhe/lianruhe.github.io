set -e
echo "Enter message: "
read MESSAGE

echo "Deploying $MESSAGE ..."

# clean
hexo clean

# compiler
hexo g

cp README.md ./dist/README.md

# commit
cd dist
git init
git add -A
git commit -m "$MESSAGE"
git push -f git@github.com:lianruhe/lianruhe.github.io.git master:master

# back to root
cd ..
