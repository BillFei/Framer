# Import file "test" (sizes and positions are scaled 1:2)
# sketch = Framer.Importer.load("imported/test@2x")

# scroll = PageComponent.wrap(sketch.main)
scroll = new PageComponent
	size: Screen.size

scroll.addPage(
	new Layer
		width: Screen.width
		height: Screen.height * 2
		)
scroll.addPage(
	new Layer
		size: Screen.size
		backgroundColor: "red"
		)

# page = new PageComponent
# 	size: Screen.size
# 
# page.addPage(sketch.main)

# print sketch.main.image 