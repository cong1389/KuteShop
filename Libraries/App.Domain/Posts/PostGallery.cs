using App.Core.Common;

namespace App.Domain.Posts
{
    public class PostGallery : Entity<int>
    {
        public int PostId
        {
            get;
            set;
        }

        public string Title
        {
            get;
            set;
        }

        public int OrderDisplay
        {
            get;
            set;
        }

        public string ImageSmallSize
        {
            get;
            set;
        }
        public string ImageBigSize
        {
            get;
            set;
        }

        public string ImageMediumSize
        {
            get;
            set;
        }

        public int Status
        {
            get;
            set;
        }

        public int IsAvatar { get; set; }

        public PostGallery()
        {
        }
    }
}