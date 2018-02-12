using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;
using System.Web;
using App.FakeEntity.Menu;
using FluentValidation;

namespace App.Framework.ValidateEntity
{
	public class MenuLinkValidator : AbstractValidator<MenuLinkViewModel>
	{
		public MenuLinkValidator()
		{
			RuleFor(x => x.MenuName).NotEmpty().WithMessage("Vui lòng nhập tiêu đề.");
			RuleFor(x => x.MetaKeywords).NotEmpty().WithMessage("Vui lòng nhập từ khoá.");
			RuleFor(x => x.Image).Must(IsValidFileType).WithMessage("Ảnh không đúng định dạng.");
			RuleFor(x => x.ImageIcon1).Must(IsValidFileType).WithMessage("Icon1 không đúng định dạng.");
			RuleFor(x => x.ImageIcon2).Must(IsValidFileType).WithMessage("Icon2 không đúng định dạng.");
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