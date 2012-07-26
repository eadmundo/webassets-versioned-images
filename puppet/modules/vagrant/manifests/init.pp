class vagrant {
  if ($site_root) {
    file { $site_root:
      ensure  => link,
      target  => '/vagrant',
      require => File['/srv/www'],
    }
    # Transitional
    file { '/srv/www':
      ensure => directory,
    }
  }
  # Deployment SSH key
  file { '/home/vagrant/.ssh/id_rsa':
    ensure  => present,
    owner   => vagrant,
    group   => vagrant,
    mode    => '600',
    content => "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEA9l4WKHmq7J5UeMvYdv4OQI1m6uPFLnXl5MutnMhTItQN4GrM\nIodDoYRbD+VbpaDaAUfoFsZJscGEyoxjP42cbpife7mEJVCCoXOC2IfyvjK2NX7X\nREM0flBBIlM8pM5DE9JyElqZl2RDo+VdJdxsQ4tpq/03rl/xQruqp9SWbpjgVRCg\nIWAi0FD2d8IHQwTu5FV/WAl21JrO1SWyyw58W4FcZbPkzpPc0ZLKwkKW+iKsDJKU\np7OQ/JNKNKTWF2Ndf67TtVV3hU2qr83w6Sza4+eVmlECQ0QMhNgsU+1ADYuhe7u2\nZ4brmThBxcSz+Dhy+I/8DrvtFlmielIXOy4biwIDAQABAoIBAA6fkw0f+6dD1pu8\n7cJSXiIywnMaxe92DAlClbGCqnycvZ4eeLNr9/W0V3tgD8qK+6Wr0PjZGDK229zx\n7Eova6Oc54p+fnuAheBzbMbRevUTKYGPX9OrcYg110fkTOszWwPoL+ErA4ba6rDl\nwlum874mnkUZKJ7vDvD5Fq4TjkJOLuJFBAB3e21Dvm1yyaa+lL6igZIzVMpllR+O\nVqGwL2DmLLrf/3aNQ3QpONQJjkf7YgpoBPydaG9oWoLIPsgADLFT3+JzMblOTMys\nmGc6D7g6XYb6rVW2oJa41LAyavtOv/TYS4mHlMdf320Q7Mkh8+mZMsEXhBdlEka5\njxq/W2ECgYEA/Ioj2Kn0QaJ1/I125klTZL1JVdgsJLvnpollh/zXxDXzVp9syUKf\n79t07PY76Z6ZppEU8Dwuq+5r9cceg2WXdccXc2t+mQzlBlSA7dvOoRC9RsZnRnqA\nxF5zNUpBmq+qZ5SmcPYFNW+MYqGnZe98u1KX+9g4Hx9lnAfFssVIvsMCgYEA+b5L\nymVsacBFWFbuZXLEqHoEYgyjV8YmWyhhY4gjbsNlYGQsXdjFVPqMGTTFHBR7mECF\ncqBFx6aEY+JaZA1ZWb6bxXuFQOOLpVhx7RVdxMvJ+oC3TXYbtdT1yQjwiXs/pVS0\noysEQgLuroL9Mwxeuaby2C534YQavjOlJevL85kCgYAm7Uw1O41RCK/TLCMlwCvA\nnYTOXLIBP42nmAo0ef7wWbiWo6BrLX/lwxg05oe5rR7WFAr8NOqkye2ORxEnA+Pi\n3bt5qRoskVZEMYZmI7moDiJ+5FpK/NsYac6sajPOmkFUEg/N3b5TzEwBcBWTmuTJ\nIyQWR+/urDJHaNNKiSp7bQKBgAklTuE6lZ3JzMBPbquIaGtDDKYKkHDGcOEluWtL\nsQB9Z1kAUh+dsJxMEJVbuVwt49jPhBOOiv+kuXRu9aB0XLFMqaexvk+CBbsoYgOs\npKJwVBU4YX4UtS8TfWy/Rw/B07LaR0MycBV6xgLeCSe1bEKgOoRwLzOzAse0XHfn\nCrEBAoGAHz4zPpPcwThM//zWaliW58a/csfsZuRP4XNWiVhcn/Dv6Y5gIbZVb5q9\n669xquHG47c5+EnbkJu9P7bEds8ISDf5RX4OFOY35Irlpl+2lS+jlcedZa0/yydB\nU2Hpl+eiZJfDpJOgTRW3KCIGDsABFc8GHPZqM12VoWNbUzU6W3w=\n-----END RSA PRIVATE KEY-----\n",
    require => File['/home/vagrant/.ssh'],
  }
  file { '/home/vagrant/.ssh':
    ensure => directory,
    owner  => vagrant,
    group  => vagrant,
    mode   => '700',
  }
}
