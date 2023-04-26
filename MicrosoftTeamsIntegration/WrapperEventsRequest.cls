public with sharing class WrapperEventsRequest {
    public WrapperEventsRequest() {
	}
	public String subject;	//Let's go for lunch
	public List<String> attendees;
	public String allowNewTimeProposals; //true
	public String isOnlineMeeting; //true
	public String onlineMeetingProvider; //teamsForBusiness
	public String contentType; //HTML
	public String content;	//Does noon work for you?
    public String Startdatahora;	//2023-04-04T12:00:00
	public String timeZone;	//America/Sao_Paulo
    public String Enddatahora;	//2023-04-04T12:00:00
	public static WrapperEventsRequest parse(String json){
		return (WrapperEventsRequest) System.JSON.deserialize(json, WrapperEventsRequest.class);
	}

}