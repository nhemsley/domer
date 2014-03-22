$(document).ready ->
  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000)
  renderer = new THREE.WebGLRenderer()
  renderer.setSize window.innerWidth, window.innerHeight

  document.body.appendChild renderer.domElement

  geometry = new THREE.CubeGeometry(1, 1, 1)
  material = new THREE.MeshPhongMaterial( { ambient: 0x030303, color: 0xdddddd, specular: 0x009900, shininess: 30, shading: THREE.FlatShading } )
  cube = new THREE.Mesh(geometry, material)
  scene.add cube
  camera.position.z = 5

  light = new THREE.DirectionalLight( 0xffffff )
  light.position.set( 0, 0, 1 ).normalize()
  scene.add( light )

  render = () ->
    requestAnimationFrame(render)


    # cube.rotation.x += 0.1;
    cube.rotation.y += 0.01;
    renderer.render(scene, camera)
  
  render();