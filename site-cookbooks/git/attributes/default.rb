#https://git-scm.com/downloads => gitの最新バージョン確認
default['git']['version']    = '2.10.0'
default['git']['source_uri'] = "https://www.kernel.org/pub/software/scm/git/git-#{default['git']['version']}.tar.gz"
default['git']['configure']  = './configure --prefix=/usr/local'
default['git']['packages']   = %w{gettext gettext-devel zlib-devel openssl-devel libcurl-devel perl-ExtUtils-MakeMaker expat-devel curl-devel gcc}

