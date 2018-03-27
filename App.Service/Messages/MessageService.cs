using System;
using System.IO;
using System.Linq;
using App.Core.Extensions;
using App.Core.Templating;
using App.Core.Utils;
using App.Domain.Email;
using App.Domain.Messages;
using Domain.Entities.Customers;

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
			//messageContext.MessageTemplate= MessageTemplateConverter.Load(messageContext.MessageTemplateName);
			ValidateMessageContext(messageContext, ref modelParts);

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

			var parts = modelParts?.AsEnumerable() ?? Enumerable.Empty<object>();
			
			if (ctx.Customer.IsSystemAccount)
			{
				throw new ArgumentException("Cannot create messages for system customer accounts.", nameof(ctx));
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

			//if (ctx.EmailAccount == null)
			//{
			//	ctx.EmailAccount = GetEmailAccountOfMessageTemplate(ctx.MessageTemplate, ctx.Language.Id);
			//}

			//// Sort parts: "IModelPart" instances must come first
			//var bagParts = parts.OfType<IModelPart>();
			//if (bagParts.Any())
			//{
			//	parts = bagParts.Concat(parts.Except(bagParts));
			//}

			modelParts = parts.ToArray();
		}
	}
}
