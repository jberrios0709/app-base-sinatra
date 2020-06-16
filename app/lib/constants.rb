module Constants
  ERRORS = {
    username_already: 'username already exists',
    register_delete:  'register deleted'
  }.freeze

  ACTIONS_TOKENS = {
    restore_password: 'restore_password'
  }

  ROLES_JWT = {
    admin: ['Administrador'],
    user: ['Administrador', 'User']
  }.freeze
end