$(document).ready ->
  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
  renderer = new THREE.WebGLRenderer()
  renderer.setSize window.innerWidth, window.innerHeight

  document.body.appendChild renderer.domElement

  geometry = new THREE.CubeGeometry(1, 1, 1)

  material =  new THREE.MeshLambertMaterial( { color:0xffffff, shading: THREE.FlatShading } )
  # material = new THREE.MeshPhongMaterial( { ambient: 0x030303, color: 0xdddddd, specular: 0x009900, shininess: 30, shading: THREE.FlatShading } )

  camera.position.z = 10

  light = new THREE.DirectionalLight( 0xffffff )
  light.position.set( 1, 1, 1 )
  scene.add( light )

  light = new THREE.DirectionalLight( 0x002288 )
  light.position.set( -1, -1, -1 )
  scene.add( light )

  light = new THREE.AmbientLight( 0x222222 )
  scene.add( light )

  controls = new THREE.FlyControls( camera )
  controls.movementSpeed = 5
  controls.rollSpeed = Math.PI / 4
  controls.autoForward = false
  controls.dragToLook = false

  clock = new THREE.Clock();

  dome = new Dome({radius: 3, thickness: 0.1})

  dome.build(scene)

  render = () ->
    requestAnimationFrame(render)

    delta = clock.getDelta()
    controls.update( delta );

    renderer.clear()
    renderer.render(scene, camera)
  
  render();