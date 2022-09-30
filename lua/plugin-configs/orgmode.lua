local om = safe_require('orgmode')
if not om then return end

om.setup_ts_grammar()

om.setup{
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
}
