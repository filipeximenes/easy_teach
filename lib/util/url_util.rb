module UrlUtil
  module FriendlyUrlUtil
    def load_context_from_indexable_slug
      indexable
    end

    def load_context_from_classroom_slug
      indexable
      classroom
    end

    def classroom
      @classroom ||= index.classrooms.find_by_slug(params[:classroom_slug].downcase) || not_found
    end

    def indexable
      @indexable ||= index.indexable
    end

    def index
      if indexable_signed_in? and current_index.slug == params[:indexable_slug].downcase
        @index ||= current_index
      else
        @index ||= Index.find_by_slug(params[:indexable_slug].downcase) || not_found
      end
    end
  end

  module EnrolledEmailUrlUtil
    def load_context_from_enrolled_email_id
      indexable
    end

    def indexable
      @indexable ||= index.indexable
    end

    def index
      @index ||= classroom.index
    end

    def classroom
      @classroom ||= enrolled_email.classroom
    end

    def enrolled_email
      @enrolled_email ||= EnrolledEmail.find(params[:id]) || not_found
    end
  end

  module ClassroomUrlUtil
    def load_context_from_classroom_id
      indexable
    end

    def indexable
      @indexable ||= index.indexable
    end

    def index
      @index ||= classroom.index
    end

    def classroom
      @classroom ||= Classroom.find(params[:id]) || not_found
    end
  end
end