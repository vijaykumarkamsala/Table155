SendSlackMessageAction.MessageInput input = new SendSlackMessageAction.MessageInput();
input.workspace_id = 'T08Q83BP01Y';  // Replace with your workspace ID
input.channel_id = 'C08Q83C3P6W'; // Replace with your channel ID
input.text = 'Test message from Salesforce ' + Datetime.now();

List<SendSlackMessageAction.MessageInput> inputs = new List<SendSlackMessageAction.MessageInput>();
inputs.add(input);

List<SendSlackMessageAction.MessageOutput> results = SendSlackMessageAction.sendMessage(inputs);

// Print results
SendSlackMessageAction.MessageOutput result = results[0];
if(result.is_success) {
    System.debug('Message sent successfully!');
    System.debug('Message Timestamp: ' + result.message_ts);
} else {
    System.debug('Failed to send message');
    System.debug('Error: ' + result.error_message);
}
