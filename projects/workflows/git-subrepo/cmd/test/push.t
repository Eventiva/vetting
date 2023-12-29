142: {
143: 	message=$(
144: 		cd "$OWNER/foo"
145: 		git subrepo pull bar
146: 		if [ $? -ne 0 ]; then
147: 			echo "Failed to pull changes from upstream repository."
148: 			return 1
149: 		fi
150: 		git subrepo push bar
151: 	)
152: 
153: 	# Test the output:
154: 	is "$message" \
155: 		"Subrepo 'bar' pushed to '$UPSTREAM/bar' (master)." \
156: 		"Push message is correct."
157: }
