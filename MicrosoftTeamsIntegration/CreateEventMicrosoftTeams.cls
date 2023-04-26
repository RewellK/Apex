public with sharing class CreateEventMicrosoftTeams extends TriggerHandler{
	public override void afterInsert() {
        
		execute((List<Event>)Trigger.new);
    }    
    public static void execute(List<Event> lstEventNew){
        map<String, Event> mapEventById = new map<String, Event>();
        for(Event iEvent : lstEventNew){
            if(iEvent.Type == 'Reunião Virtual'&& iEvent.GenerateTeamsLink__c == true){
                mapEventById.put(iEvent.Id, iEvent);
            }
        }
        
        //cria um mapa que usa o id do evento no formato string para ser o indice e organiza/filtra os eventos dentro dele
        //usando o id como base, sendo assim, ele "segura" apenas um evento e somente se ele for do tipo reunião 
        
        map<String, List<String>> mapListAttendeesByEventId = new map<String, List<String>>();

        if(!mapEventById.isEmpty()){
            //verifica se o mapa esta vazio 
            for(eventRelation iAtts : [SELECT EventId, RelationId FROM eventRelation WHERE EventId =: mapEventById.KeySet()]){
                //faz o select para puxar os registros 
              List<String> lstRelationIds = mapListAttendeesByEventId.get(iAtts.EventId);
              	//faz o get do ID do mapa 
              lstRelationIds = (lstRelationIds == null) ? new List<String>() : lstRelationIds;
              	//verifica se o mapa naquele Id está vazio, caso esteja ele inicia a lista dentro do ID
              	// a partir disso ele vai inserindo os valores dentro da fila que esta associada com o id 
              lstRelationIds.add(iAtts.RelationId);
              	//adiciona o valor dentro da lista 
              mapListAttendeesByEventId.put(iAtts.EventId, lstRelationIds);
             	//adiciona a fila ao Id correspondente
            }
        }
        map<String, string> mapListEmailByUserId = new map<String, string>();
            List<String> lstIdUsers = new List<String>(); //lista dos usuários associados ao evento
            List<String> lstIdContacts = new List<String>(); // lista dos contatos associadas
        	List<String> lstIdLeads = new List<String>(); //lista dos Leads associdos 

        if(!mapListAttendeesByEventId.isEmpty()){
            for (String iIdEvent : mapListAttendeesByEventId.KeySet()) {
                for (String iIdUser : mapListAttendeesByEventId.get(iIdEvent)){
                    if(iIdUser.startsWith('005')){
                        lstIdUsers.add(iIdUser);
                    }
                    if(iIdUser.startsWith('003')){
                        lstIdContacts.add(iIdUser);   
                    }
                    if(iIdUser.startsWith('00Q')){
                        lstIdLeads.add(iIdUser);
                    }
                }
                // temos aqui uma lista de id's de usuários, contatos e um Lead
            }
        }
        if (!lstIdUsers.isEmpty()){
            for(User iUserId :[SELECT Id, Email FROM User WHERE Id =: lstIdUsers]){
                if(iUserId.Email.contains('@')){
                    mapListEmailByUserId.put(iUserId.id, iUserId.Email);
                }
            		//pronto, aqui temos a lista de Emails dos usuários associados ao evento
            }
        }
        if (!lstIdContacts.isEmpty()){
            for(Contact iContactId :[SELECT Id, Email FROM Contact WHERE Id =: lstIdContacts]){
                 if(iContactId.Email.contains('@')){
                mapListEmailByUserId.put(iContactId.id, iContactId.Email);
                 }
            		//pronto, aqui temos a lista de Emails das contatos por id da contato
            }
        }        
        if (!lstIdLeads.isEmpty()){
            for(Lead iLeadId :[SELECT Id, Email FROM Lead WHERE Id =: lstIdLeads]){
                 if(iLeadId.Email.contains('@')){
                mapListEmailByUserId.put(iLeadId.id, iLeadId.Email);
                 }
            		//pronto, aqui temos a lista de Emails das Leads por id da contato
            }
        }        

        List<WrapperEventsRequest> lstRequests = new List<WrapperEventsRequest>();
        for(String iEvtId :mapEventById.KeySet()){
            WrapperEventsRequest objRequest =  new WrapperEventsRequest();

            objRequest.contentType = 'HTML';
            objRequest.content = mapEventById.get(iEvtId).Description;
           
            objRequest.Startdatahora = (''+mapEventById.get(iEvtId).StartDateTime.addHours(-3));
            objRequest.Enddatahora = (''+mapEventById.get(iEvtId).EndDateTime.addHours(-3));
            
            objRequest.subject = mapEventById.get(iEvtId).Subject;
            objRequest.allowNewTimeProposals = 'true';
            objRequest.isOnlineMeeting = 'true';
            objRequest.onlineMeetingProvider = 'teamsForBusiness';

            objRequest.attendees = new List<String>();

            for (String iAttendessId : mapListAttendeesByEventId.get(mapEventById.get(iEvtId).Id)) {
                string address = mapListEmailByUserId.get(iAttendessId);
                objRequest.attendees.add(address);
            }
            lstRequests.add(objRequest);
        }
        if(!lstRequests.isEmpty()){
            
            TeamsMeetingEvent.createMeetEvent(JSON.serialize(lstRequests));
        }

    }
}