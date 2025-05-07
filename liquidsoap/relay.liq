url_ref = ref ""

radio = input.http(url_ref)

icecast_host = getenv("ICECAST_HOST", "localhost")
icecast_port = int(getenv("ICECAST_PORT", "8000"))
icecast_password = getenv("ICECAST_PASSWORD", "hackme")
icecast_mount = getenv("ICECAST_MOUNT", "stream.mp3")

output.icecast(%mp3, host=icecast_host, port=icecast_port, password=icecast_password,
               mount=icecast_mount, radio)

server.socket = [ ("localhost", 1234) ]

def set_url(new_url)
  url_ref := new_url
  "Stream actualizado a: #{new_url}"
end

server.register(namespace="url", "set", set_url)