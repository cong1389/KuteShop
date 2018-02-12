using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;
using System.Web;
using App.FakeEntity.System;
using FluentValidation;

namespace App.Framework.ValidateEntity
{
	public class SystemSettingValidator : AbstractValidator<SystemSettingViewModel>
	{
		public SystemSettingValidator()
		{
			RuleFor(x => x.Title).NotEmpty().WithMessage("Vui lòng nhập tiêu đề.");

            RuleFor(x => x.Logo).Must(IsValidFileType).WithMessage("Hình ảnh Logo không đúng định dạng");

            RuleFor(x => x.LogoFooter).Must(IsValidFileType).WithMessage("Hình ảnh Logo không đúng định dạng");

            RuleFor(x => x.Favicon).Must(IsValidFileType).WithMessage("Hình ảnh Favicon không đúng định dạng");
		}

		public static bool IsValidFileType(HttpPostedFileBase file)
		{
			bool flag;
			if ((file == null ? false : file.ContentLength > 0))
			{
				ImageFormat[] jpeg = { ImageFormat.Jpeg, ImageFormat.Png, ImageFormat.Gif, ImageFormat.Bmp, ImageFormat.Jpeg, ImageFormat.Tiff, ImageFormat.Icon };
				using (Image image = Image.FromStream(file.InputStream))
				{
					if (!jpeg.Contains(image.RawFormat))
					{
						flag = false;
						return flag;
					}
				}
			}
			flag = true;
			return flag;
		}
	}
}