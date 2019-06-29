cd storage/downloads/blog

for i in 'master' 'social' 'probot'
do
	git checkout $i
	git push origin $i
done
