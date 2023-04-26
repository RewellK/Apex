public class teamsMeetingEvent {
        @Future (callout= true)
        public static void CreateMeetEvent( String strLstRequests){  
            List<WrapperEventsRequest> pLstRequests = (List<WrapperEventsRequest>)JSON.deserializeStrict(strLstRequests, List<WrapperEventsRequest>.class);
            createEventHandler(pLstRequests); 
        }
        public static string createEventHandler( List<WrapperEventsRequest> pLstRequests){
            for (WrapperEventsRequest iReq : pLstRequests) {
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                    req.setEndpoint('https://graph.microsoft.com/v1.0/users/'+UserInfo.getUserEmail()+'/events');
                    req.setMethod('POST');
                    req.setHeader('Authorization', 'TOKEN');
                    req.setHeader('Content-type', 'application/json');
                    req.setHeader('Accept', 'application/json');
                    req.setHeader('prefer', 'outlook.timezone="'+Userinfo.getTimeZone()+'"');
                    String strAttendees = '';
                	for(integer i=0;i<iReq.Attendees.size();i++){
                            strAttendees = strAttendees + '{"emailAddress": {"address": "'+iReq.Attendees[i]+'"}, "type": "required"},';
                        system.debug(iReq.attendees[i]);
                    }
                    strAttendees = strAttendees.left(strAttendees.length()-1);
                    req.setBody( 
                        '{"subject":"'+iReq.subject+'",'+
                        '"body": {"contentType": "'+iReq.contentType+'", "content": "'+iReq.Content+'"},'+
                            '"start": { "dateTime": "'+iReq.Startdatahora+'", "timeZone": "'+Userinfo.getTimeZone()+'"},'+
                            '"end": {"dateTime": "'+iReq.Enddatahora+'", "timeZone": "'+Userinfo.getTimeZone()+'"},'+
                            '"location": { "displayName": "Microsoft Teams"},'+
                            '"attendees": ['+strAttendees+'],'+
                        '"allowNewTimeProposals": "true",'+
                        '"isOnlineMeeting":"true",'+
                        '"onlineMeetingProvider":"teamsForBusiness"}'
                    );
                HTTPResponse res = http.send(req);
				String retorno = (''+res.getStatusCode());
                system.debug(strAttendees);
                if(res.getStatusCode()==201){
                }else{
                    system.debug('deu errado'+'\n   '+res.getStatusCode()+ '\n   '+res.getStatus()+ '\n   '+res.getBody());
                }
                
        	}
            return ('retorno');
        }    
     
     
    }
