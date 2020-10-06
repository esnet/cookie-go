module github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}

require (
	{% if cookiecutter.use_logrus_logging == "y" -%}github.com/sirupsen/logrus v1.6.0{%- endif %}
	{% if cookiecutter.use_cobra_cmd == "y" -%}github.com/spf13/cobra v1.0.0{%- endif %}
	{% if cookiecutter.use_viper_config == "y" -%}github.com/spf13/viper v1.7.1{%- endif %}
	{% if cookiecutter.use_jsonpath_config == "y" -%}github.com/yalp/jsonpath v0.0.0-20180802001716-5cc68e5049a0{%- endif %}
	{% if cookiecutter.use_go_funk == "y" -%}github.com/thoas/go-funk v0.7.0 {%- endif %}
	github.com/jinzhu/copier v0.0.0-20190924061706-b57f9002281a // indirect
	
)
