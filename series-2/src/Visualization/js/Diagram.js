(function() {
	// size of the wheel
	const diameter = DIAMETER,
	      radius = diameter / 2,
	      innerRadius = radius - 120;

	// Make a full circle
	const cluster = d3.layout.cluster()
		    .size([DEGREES, innerRadius])
		    .sort(null)
		    .value(d => d.size);

	const bundle = d3.layout.bundle();

	const line = d3.svg.line.radial()
		    .interpolate("bundle")
		    .tension(TENSION)
		    .radius(d => d.y)
		    .angle(d => d.x / 180 * Math.PI);

	// Setup dom elements
	const svg = d3.select("body").append("svg")
	    .attr("width", diameter)
	    .attr("height", diameter)
	  .append("g")
	    .attr("transform", "translate(" + radius + "," + radius + ")");

	var link = svg.append("g").selectAll(".link"),
	    node = svg.append("g").selectAll(".node");

	d3.json(DATA_FILE, readData);

	// Read the data
	function readData(error, data) {
		if (error) throw error;

		// extract data
		const allFiles = data.files;
		const allClonePairs = data.clone_pairs;

		// Setup nodes and links from the data
	    var nodes = cluster.nodes(fileHierarchy(allFiles, allClonePairs)),
	        links = fileClonePairs(nodes, allClonePairs);

	    // Construct the links between the nodes in the dom
	    link = link
	        .data(bundle(links))
	      .enter().append("path")
	        .each(d => {
				d.source = d[0];
				d.target = d[d.length - 1];
			})
	        .attr("class", "link")
	        .attr("d", line);

		// Construct the nodes in the dom
	    node = node
	        .data(nodes.filter(n => !n.children))
	      .enter().append("text")
	        .attr("class", "node")
	        .attr("dy", ".31em")
	        .attr("transform", d => "rotate(" + (d.x - 90) + ")translate(" + (d.y + 8) + ",0)" + (d.x < 180 ? "" : "rotate(180)"))
	        .style("text-anchor", d => d.x < 180 ? "start" : "end")
	        .text(d => d.key)
	        .on("mouseover", mouseovered)
			.on("mousedown", mousedown)
	        .on("mouseout", mouseouted);
	}

	// Lazily construct the files as nodes.
	function fileHierarchy(files, clonePairs) {
		var map = {};

		const find = (name, data) => {
			var node = map[name], i;

			if (!node) {

				node = map[name] = data || {name: name, children: []};
				if (name.length) {
					node.parent = find(name.substring(0, i = name));
					node.parent.children.push(node);

					// set it's name as key
					node.key = name.substring(i + 1);

					// Add node's clone pair
					node.clonePairs = clonePairs
					.filter(clonepair => clonepair.origin.file == node.name)
					.map(clonepair => clonepair);
				}
			}
			return node;
		}

		files.forEach(d => find(d.name, d));

		return map[""];
	}

	// Return a list of clone pairs for the given array of clone pairs.
	function fileClonePairs(nodes, clonePairs) {
		var map = {},
			clones = [];

		// Compute a map from name to node.
		nodes.forEach(d => map[d.name] = d);

	    // For each clone pair, construct a link from the source to target node.
	 	nodes.forEach(node => {
			clonePairs
			.filter(clonepair => node.name === clonepair.origin.file)
		  	.forEach(clonepair => {
				clones.push({
					source: map[node.name],
					target: map[clonepair.clone.file]
				});
			});
		});

		return clones;
	}

	function mousedown(d) {
		console.log(d);
	}

	function mouseovered(d) {
		node
			.each(n => n.target = n.source = false);

		link
			.classed("link--target", function(l) { if (l.target === d) return l.source.source = true; })
			.classed("link--source", function(l) { if (l.source === d) return l.target.target = true; })
			.filter(function(l) { return l.target === d || l.source === d; })
			.each(function() { this.parentNode.appendChild(this); });

		node
			.classed("node--target", n => n.target)
			.classed("node--source", n => n.source);
	}

	function mouseouted(d) {
		link
			.classed("link--target", false)
			.classed("link--source", false);

		node
			.classed("node--target", false)
			.classed("node--source", false);
	}

	d3.select(self.frameElement).style("height", diameter + "px");
})();
