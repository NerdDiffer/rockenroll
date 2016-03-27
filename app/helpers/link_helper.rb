module LinkHelper
  class << self
    def edit_link_dest(record)
      { action: 'edit', id: record.id }
    end

    def delete_link_opts
      {
        method: 'delete',
        data: { confirm: 'Are you sure?' }
      }
    end

    def javascript_void
      'javascript:void(0)'
    end
  end
end
