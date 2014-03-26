class Dome
  #create a dome, with options (i.e.):
  # {center: [0, 0, 0], radius: 1}
  constructor: (options) ->
    @options = options


  material: () ->
    texture = THREE.ImageUtils.loadTexture( "/images/rammed-earth.jpg" )
    material = new THREE.MeshPhongMaterial( { color: 0xffffff, map: texture } )


  buildSolid: (scene) ->
    material = @material()

    @scene =scene

    segments = 32

    cutoffRatio = 0.6
    outer = {}
    floor = {}
    inner = {}

    outer.geometry = new THREE.SphereGeometry( @options.radius, segments, segments)
    outer.mesh = new THREE.Mesh(outer.geometry, material)
    outer.csg = outer.mesh.toBSP()

    inner.geometry = new THREE.SphereGeometry( @options.radius - @options.thickness, segments, segments)
    inner.mesh = new THREE.Mesh(inner.geometry, material)
    inner.csg = inner.mesh.toBSP()

    floor.geometry = new THREE.CubeGeometry( @options.radius * 2, @options.radius - cutoffRatio, @options.radius * 2);
    floor.mesh = new THREE.Mesh( floor.geometry, material );

    floor.mesh.position.y = -(@options.radius - cutoffRatio)
    floor.csg = floor.mesh.toBSP()

    dome = {}

    dome.csg = outer.csg.subtract(floor.csg)

    dome.csg = dome.csg.subtract(inner.csg)

    @cutOpening(dome, Math.PI)

    scene.add(dome.csg.toMesh(material))
    # scene.add(floor.mesh)

  # Cut an opening in the dome at angle
  cutOpening: (dome, angle) ->

    cylinder = {}
    cylinder.geometry = new THREE.CylinderGeometry( @options.radius * 0.3, @options.radius * 0.3, @options.radius * 0.1);
    cylinder.mesh = new THREE.Mesh(cylinder.geometry, @material())

    cylinder.mesh.position.z = @options.radius * 2

    cylinder.mesh.rotation.x = Math.PI / 2

    @scene.add(cylinder.mesh)



  build: (scene) ->
    # @buildTwoSpheres(scene)
    @buildSolid(scene)

  buildTwoSpheres: (scene) ->
    material = @material()

    # inner = new THREE.SphereGeometry( @options.radius - 0.1, 16, 16)
    outer = new THREE.SphereGeometry( @options.radius, 32, 32, 0, Math.PI*2, 0, Math.PI*0.6)
    inner = new THREE.SphereGeometry( (@options.radius - 0.1) * -1, 32, 32, 0, Math.PI*2, 0, Math.PI*0.6)

    outerMesh = new THREE.Mesh(outer, material)
    innerMesh = new THREE.Mesh(inner, material)

    outerMesh.material.side = THREE.DoubleSide

    # outerBSP = outerMesh.toBSP()
    # innerBSP = innerMesh.toBSP()

    # combined = outerBSP.subtract(innerBSP)

    # scene.add(innerMesh)

    scene.add(outerMesh)

window.Dome = Dome

