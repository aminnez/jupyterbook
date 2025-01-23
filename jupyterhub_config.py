import os
from oauthenticator.google import LocalGoogleOAuthenticator

pjoin = os.path.join
runtime_dir = os.path.join('/srv/jupyterhub')

c.JupyterHub.cookie_secret_file = pjoin(runtime_dir, 'cookie_secret')
c.JupyterHub.db_url = pjoin(runtime_dir, 'jupyterhub.sqlite')

c.JupyterHub.authenticator_class = LocalGoogleOAuthenticator

c.LocalGoogleOAuthenticator.oauth_callback_url = os.environ.get('OAUTH_CALLBACK_URL', 'http://localhost.com/hub/oauth_callback')
c.LocalGoogleOAuthenticator.client_id = os.environ.get('GOOGLE_OAUTH_CLIENT_ID', '')
c.LocalGoogleOAuthenticator.client_secret = os.environ.get('GOOGLE_OAUTH_CLIENT_SECRET', '')

# c.LocalGoogleOAuthenticator.allow_all = True
c.LocalGoogleOAuthenticator.allowed_users = {'aminnezam@gmail.com'}
c.LocalGoogleOAuthenticator.admin_users = {'aminnezam@gmail.com'}
c.Authenticator.manage_groups = True
c.Authenticator.refresh_pre_spawn = True
c.Authenticator.add_user_cmd = ['adduser', '-q', '--gecos', '""', '--disabled-password', '--force-badname']
c.LocalGoogleOAuthenticator.create_system_users = True

c.DockerSpawner.image = 'jupyterbook-hub'
c.DockerSpawner.network_name = 'jupyterhub-network'
c.JupyterHub.bind_url = 'http://0.0.0.0:8000'
c.Spawner.default_url = '/lab'
c.Spawner.args = ['--ServerApp.terminado_settings={ "shell_command": ["/usr/bin/zsh"] }', '--NotebookApp.kernel_manager_class=notebook.services.kernels.kernelmanager.AsyncMappingKernelManager']