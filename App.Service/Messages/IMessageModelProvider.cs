namespace App.Service.Messages
{
    public interface IMessageModelProvider
    {
        void AddGlobalModelParts(MessageContext messageContext);
    }
}