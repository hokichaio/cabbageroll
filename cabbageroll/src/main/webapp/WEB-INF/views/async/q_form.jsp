<div class="tab-pane" id="Q${qno+1}">
	<div class="control-group">
		<label class="control-label" for="media">Media</label>
		<div class="controls">
			<label class="checkbox inline">
                <input type="checkbox" id="media_flg${qno}" name="questions[${qno}].multimedia.type" onclick="useMedia(${qno});" value="0" /> Use
     		</label>
     		<input style="position: relative; top:-10px; right:-300px" type="button" class="btn btn-mini" value="delete" onclick="removeQ(${qno+1})" />
		</div>
	</div>
	<div id="media_content${qno}" class="control-group" style="display:none;">
		<label class="control-label" >Media Type</label>
		<div class="controls">
				<!-- 
				<label class="radio">
	                <form:radiobutton id="media_type_upload" class="media_type" path="questions[${qno}].multimedia.type" onclick="mUploader(${qno});" value="1" /> Upload a file
				</label>
				 -->
   				<label class="radio">
					<input type="radio" id="media_type_youtube" class="media_type" name="questions[${qno}].multimedia.type" onclick="mUri(${qno});" value="2" /> Place a youtube link
   				</label>
   				<label class="radio">
            	    <input type="radio" id="media_type_imgurl" class="media_type" name="questions[${qno}].multimedia.type" onclick="mUri(${qno});" value="3" /> Place an image link
   				</label>
      			<label>
      				<input class="media_type" type="file" name="questions[${qno}].multimedia.file" id="media_fileuploader${qno}" style="display:none;"/>
      			</label>
   				<label>
      				<input type="text" class="media_type input-xlarge" name="questions[${qno}].multimedia.uri" id="media_uri${qno}" style="display:none;"/>
      			</label>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="description">Description</label>
		<div class="controls">
        	<textarea id="questions${qno}.description" name="questions[${qno}].description" rows="5" cols="320"></textarea>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="type">Question Type</label>
		<div class="controls">
        	<select id="questions${qno}.type" name="questions[${qno}].type">
        		<option value="1">SA</option>
        		<option value="2">MA</option>
			</select>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="title"><input type="button" class="btn btn-primary btn-mini" onclick="addChoice(${qno})" value="AddChoice" /></label>
		<div class="controls" id="choice_list${qno}">
		</div>
	</div>
</div>