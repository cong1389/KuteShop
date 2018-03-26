using System;
using App.Core.Extensions;
using App.Core.Templating;
using App.Domain.Email;
using App.Domain.Messages;

namespace App.Service.Messages
{
	public class MessageService : IMessageService
	{
		private readonly ITemplateEngine _templateEngine;

		public MessageService(ITemplateEngine templateEngine)
		{
			_templateEngine = templateEngine;
		}

		public virtual CreateMessageResult CreateMessage(MessageContext messageContext, bool queue,
			params object[] modelParts)
		{
			var messageTemplate = messageContext.MessageTemplate;

			// Render templates
			var to = RenderEmailAddress(messageTemplate.To, messageContext);

			return new CreateMessageResult { MessageContext = messageContext };
		}

		private EmailAddress RenderEmailAddress(string email, MessageContext ctx, bool required = true)
		{
			string parsed = null;

			try
			{
				parsed = RenderTemplate(email, ctx, required);

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


		protected MessageTemplate GetActiveMessageTemplate(string messageTemplateName, int storeId)
		{
			var messageTemplate = _messageTemplateService.GetMessageTemplateByName(messageTemplateName, storeId);
			if (messageTemplate == null || !messageTemplate.IsActive)
				return null;

			return messageTemplate;
		}

	}
}
