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
                    req.setHeader('Authorization', 'eyJ0eXAiOiJKV1QiLCJub25jZSI6ImROQ0czWWdSQnJCdGZET2RMNjY2WVZ3UnRuekxMVHpmYUl4bzYxNDV6d0kiLCJhbGciOiJSUzI1NiIsIng1dCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyIsImtpZCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyJ9.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTAwMDAtYzAwMC0wMDAwMDAwMDAwMDAiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC8xNDkwNmY4Ny1mYjY0LTQyNzEtYjZkNy1kMzQ0Y2Q4Mjg5ZjMvIiwiaWF0IjoxNjgyMzU2Njk3LCJuYmYiOjE2ODIzNTY2OTcsImV4cCI6MTY4MjQ0MzM5NywiYWNjdCI6MCwiYWNyIjoiMSIsImFpbyI6IkFUUUF5LzhUQUFBQXJ5QWhsdjVOTlBTTjNzNU1DOVZqVStVd1R5aVcwUm5BRFA3d25MK05hS0t1N1ZKbFZDRUxxSmRiRXdhSk1QY1giLCJhbXIiOlsicHdkIl0sImFwcF9kaXNwbGF5bmFtZSI6IkdyYXBoIEV4cGxvcmVyIiwiYXBwaWQiOiJkZThiYzhiNS1kOWY5LTQ4YjEtYThhZC1iNzQ4ZGE3MjUwNjQiLCJhcHBpZGFjciI6IjAiLCJmYW1pbHlfbmFtZSI6IlNvdXNhIiwiZ2l2ZW5fbmFtZSI6IlJld2VsbCIsImlkdHlwIjoidXNlciIsImlwYWRkciI6IjIwMC4yMzIuMTMxLjE0OCIsIm5hbWUiOiJSZXdlbGwgU291c2EiLCJvaWQiOiI5ZGY4YmJlZC1jNmIxLTQxM2UtOWYxMy1hZmU3Y2U5NjhkMWUiLCJwbGF0ZiI6IjMiLCJwdWlkIjoiMTAwMzIwMDIyNkM5M0Q3RCIsInJoIjoiMC5BU1VBaDItUUZHVDdjVUsyMTlORXpZS0o4d01BQUFBQUFBQUF3QUFBQUFBQUFBQWxBTWMuIiwic2NwIjoiQ2FsZW5kYXJzLlJlYWRXcml0ZSBPbmxpbmVNZWV0aW5ncy5SZWFkV3JpdGUgb3BlbmlkIHByb2ZpbGUgVXNlci5SZWFkIGVtYWlsIiwic2lnbmluX3N0YXRlIjpbImttc2kiXSwic3ViIjoiRUZlVzY4bDlSc3hreXhITVk3a0RfRlQtbWI0anFBWllMd2pQRW9LN0VEayIsInRlbmFudF9yZWdpb25fc2NvcGUiOiJTQSIsInRpZCI6IjE0OTA2Zjg3LWZiNjQtNDI3MS1iNmQ3LWQzNDRjZDgyODlmMyIsInVuaXF1ZV9uYW1lIjoicmV3ZWxsLnNvdXNhQHhjbC5jb21wYW55IiwidXBuIjoicmV3ZWxsLnNvdXNhQHhjbC5jb21wYW55IiwidXRpIjoiSG5wRDFlRnV1a21Ob0pUcnRLd1JBQSIsInZlciI6IjEuMCIsIndpZHMiOlsiYjc5ZmJmNGQtM2VmOS00Njg5LTgxNDMtNzZiMTk0ZTg1NTA5Il0sInhtc19jYyI6WyJDUDEiXSwieG1zX3NzbSI6IjEiLCJ4bXNfc3QiOnsic3ViIjoiOGEydFVaYzR6UkE1U2ZDYXNDQ1JoNGtHOXEtNUwtOWhMTEJ0cndHNVRlVSJ9LCJ4bXNfdGNkdCI6MTUyODkxMDgzNn0.MEcWPHFvx_k6LIG88CJFeoUSyJlRxc_4Rt-AOKIU98tQkJ_4cv0nUB7F6dfg2D9i10SOiWSZwagg1UbpD294V4o9wEuBOrbRB1rXihgEXEj6f76YrP1jppEzY_4wgkPN2kRuMMVic8QmCFKIIwRgzpGWFcrBNTscj83ED-q5MRbdademcgU9JYfdeDIhMbOmJuN_DWhK2jlpUZ9Tql3e5M3gv2yvTyebljHPQsGK1VG70bmYQjbFl-Jux0z_z1hfV9FvEEVpcDOOyvxcqP6v9h7HN41DScg0eYJf7uTstdc3Kv7DJ5md66ipuElIqA-5J0dSgIHqGfgu0Jw6ecUMVA');
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