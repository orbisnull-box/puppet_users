class users {
  $users = hiera_hash('users::users', {})
  
  if (is_hash($users)) {
  $users.each |$login, $params| {
    if (has_key($params, 'home') and ($params[home] != undef)) {
      $home_dir = $params[home]
    } else {
      $home_dir = "/home/${login}"
    }
    
    $default_params = {
      name => $login,
      home => $home_dir,
      managehome => true,
    }

    #$user = deep_merge($params, $default_params)

    #notify{"ensure user: ${login}":}
    create_resources(user, {$login => $params}, $default_params)
  }
  }
}

