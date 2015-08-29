class PageVersion < PaperTrail::Version
  self.table_name = :page_versions
  default_scope { where.not(event: 'create') }
end
