c.DockerSpawner.image = 'jupyterhub-ijava'
c.DockerSpawner.network_name = 'jupyterhub-network'
c.JupyterHub.bind_url = 'http://0.0.0.0:8000'
c.Spawner.default_url = '/lab'
c.LocalAuthenticator.create_system_users = True
c.Authenticator.allowed_users = {'amin'}
c.Authenticator.admin_users = {'amin'}