using App.FakeEntity.Languages;
using FluentValidation;

namespace App.Framework.ValidateEntity
{
    public class LocaleStringResourceValidator : AbstractValidator<LocaleStringResourceViewModel>
	{
		public LocaleStringResourceValidator()
		{
			RuleFor(x => x.ResourceName)
                .NotEmpty()
                .WithMessage("Vui lòng nhập tên resource.");						
		}
		
	}
}