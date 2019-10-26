module.exports = {
	extends: ['@commitlint/config-conventional'],
	plugins: ['cleanfeet'],
	rules: {
		'body-leading-blank': [2, 'always'],
		'footer-leading-blank': [2, 'always'],
		'header-max-length': [2, 'always', 50],
		'subject-case': [
			2,
			'always',
			['sentence-case']
		],
		'type-enum': [
			2,
			'always',
			[
				'chore',
				'docs',
				'feat',
				'fix',
				'perf',
				'refactor',
				'style',
				'test'
			]
		],
		'footer-format': [
			2, 
			'always', 
			[
				'^BREAKING CHANGE: .*',
				'^[a-zA-Z0-9-]+: .*',
				'^[a-zA-Z0-9-]+ #.*'
			]
		],
		'footer-max-occurrence-breaking-change': [2, 'always', { max: 1, regex: /^BREAKING CHANGE: .*$/ }]
	}
};
