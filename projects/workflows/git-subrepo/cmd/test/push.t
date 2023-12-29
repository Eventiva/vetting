...
# Add a new test case to check the modified `git subrepo push` command
{
  # Create a scenario where there are new changes upstream before the push operation
  (
    cd "$UPSTREAM/bar"
    echo "new changes" > new_file
    git add new_file
    git commit -m "new changes upstream"
  ) &>/dev/null || die

  # Run the `git subrepo push` command
  message=$(
    cd "$OWNER/foo"
    git subrepo push bar
  )

  # Check that the `git subrepo push` command pulls these changes before pushing
  newCommit=$(
    cd "$OWNER/foo/bar"
    git log HEAD -1 --pretty='format:%s'
  )
  is "$newCommit" \
    "new changes upstream" \
    "New changes upstream are pulled before pushing"

  # Check the output message of the `git subrepo push` command
  is "$message" \
    "Subrepo 'bar' pushed to '$UPSTREAM/bar' (master). There are new changes upstream, you need to pull first." \
    'push message is correct'
}
...
