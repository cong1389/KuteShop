using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;
using System.Web;
using App.FakeEntity.Static;
using FluentValidation;

namespace App.Framework.ValidateEntity
{
	public class StaticContentValidator : AbstractValidator<StaticContentViewModel>
	{
		public StaticContentValidator()
		{
			RuleFor(x => x.Title).NotEmpty().WithMessage("Vui lòng nhập tiêu đề.");
			RuleFor(x => x.MenuId).NotEmpty().WithMessage("Vui lòng chọn danh mục.");
			RuleFor(x => x.Image).Must(IsValidFileType).WithMessage("Hình ảnh không đúng định dạng");
		}

		public static bool IsValidFileType(HttpPostedFileBase file)
		{
			bool flag;
			if ((file == null ? true : file.ContentLength <= 0))
			{
				flag = true;
			}
			else
			{
				ImageFormat[] jpeg = { ImageFormat.Jpeg, ImageFormat.Png, ImageFormat.Gif, ImageFormat.Bmp, ImageFormat.Jpeg, ImageFormat.Tiff };
				using (Image image = Image.FromStream(file.InputStream))
				{
					if (!jpeg.Contains(image.RawFormat))
					{
						flag = false;
						return flag;
					}
				}
				flag = true;
			}
			return flag;
		}
	}
}