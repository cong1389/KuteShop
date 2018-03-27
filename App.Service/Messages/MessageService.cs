using System;
using System.IO;
using System.Linq;
using App.Core.Extensions;
using App.Core.Templating;
using App.Core.Utils;
using App.Domain.Email;
using App.Domain.Entities.GlobalSetting;
using App.Domain.Messages;
using App.Service.Common;
using App.Service.Language;
using App.Service.MailSetting;

namespace App.Service.Messages
{
	public class MessageService : IMessageService
	{
		private readonly ICommonServices _services;
		private readonly ILanguageService _languageService;
		private readonly ITemplateEngine _templateEngine;
		private readonly IMailSettingService _mailSettingService;
		private readonly IMessageModelProvider _modelProvider;

		public MessageService(ICommonServices services, ILanguageService languageService,
			ITemplateEngine templateEngine, IMailSettingService mailSettingService, IMessageModelProvider modelProvider)
		{
			_services = services;
			_templateEngine = templateEngine;
			_mailSettingService = mailSettingService;
			_languageService = languageService;
			_modelProvider = modelProvider;
		}

		public virtual CreateMessageResult CreateMessage(MessageContext messageContext, bool queue,
			params object[] modelParts)
		{
			ValidateMessageContext(messageContext, ref modelParts);

			// Create and assign model
			var model = messageContext.Model = new TemplateModel();

			// Add all global template model parts
			_modelProvider.AddGlobalModelParts(messageContext);

			var messageTemplate = messageContext.MessageTemplate;

			// Render templates
			var to = RenderEmailAddress(messageTemplate.To, messageContext);

			return new CreateMessageResult { MessageContext = messageContext };
		}

		private EmailAddress RenderEmailAddress(string email, MessageContext ctx, bool required = true)
		{
			try
			{
				var parsed = RenderTemplate(email, ctx, required);

				if (required || parsed != null)
				{
					return parsed.Convert<EmailAddress>();
				}

				return null;
			}
			catch (Exception ex)
			{
				string msg = ex.Message;

			}

			return null;
		}

		private string RenderTemplate(string template, MessageContext ctx, bool required = true)
		{
			if (!required && template.IsEmpty())
			{
				return null;
			}

			return _templateEngine.Render(template, ctx.Model, ctx.FormatProvider);
		}

		private void ValidateMessageContext(MessageContext ctx, ref object[] modelParts)
		{
			var t = ctx.MessageTemplate;
			if (t != null)
			{
				if (t.To.IsEmpty() || t.Subject.IsEmpty() || t.Name.IsEmpty())
				{
					throw new InvalidOperationException("Message template validation failed, because at least one of the following properties has not been set: Name, To, Subject.");
				}
			}

			if (ctx.LanguageId.GetValueOrDefault() == 0)
			{
				ctx.Language = _services.WorkContext.WorkingLanguage;
				ctx.LanguageId = ctx.Language.Id;
			}
			else
			{
				ctx.Language = _languageService.GetById(ctx.LanguageId.Value);
			}

			if (ctx.MessageTemplate == null)
			{
				if (ctx.MessageTemplateName.IsEmpty())
				{
					throw new ArgumentException("'MessageTemplateName' must not be empty if 'MessageTemplate' is null.", nameof(ctx));
				}

				ctx.MessageTemplate = MessageTemplateConverter.Load(ctx.MessageTemplateName);
				if (ctx.MessageTemplate == null)
				{
					throw new FileNotFoundException("The message template '{0}' does not exist.".FormatInvariant(ctx.MessageTemplateName));
				}
			}

			if (ctx.EmailAccount == null)
			{
				ctx.EmailAccount = GetEmailAccountOfMessageTemplate(ctx.MessageTemplate, ctx.Language.Id);
			}

			//// Sort parts: "IModelPart" instances must come first
			//var bagParts = parts.OfType<IModelPart>();
			//if (bagParts.Any())
			//{
			//	parts = bagParts.Concat(parts.Except(bagParts));
			//}

			//modelParts = parts.ToArray();
		}

		protected ServerMailSetting GetEmailAccountOfMessageTemplate(MessageTemplate messageTemplate, int languageId)
		{
			var account = _mailSettingService.GetActive();

			if (account == null)
			{
				throw new Exception("Email account is null");
			}

			return account;
		}
	}
}
