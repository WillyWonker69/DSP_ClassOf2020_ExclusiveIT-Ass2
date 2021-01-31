import ballerina/http;
import ballerina/kafka;

kafka:ProducerConfiguration prodConfig ={
bootstrapServers:"localhost:9092",
clientId: "registeredVoters",
acks:"all",
retryCount:3
};

kafka:Producer kafkaProducer = new (prodConfig);

type registeredVoter record {
    int id;
    string fullName;
    boolean citizenship;
    string gender;
    int age;   
};
type ballotType record {

}


public function main(string... args)  {
    registeredVoter[] VoterList = [];
    registeredVoter voter1 = {
    id = 23;
    fullName = "Woneker Willy";
    citizenship = true;
    gender = "male";
    age = 21;  
    }
    VoterList.push(voter1)

}


    public function newVoter(http:Caller outboundEP, http:Request request){
     
        var payloadJson = request.getJsonPayload();
        if (payloadJson is json) {
            registeredVoter|error voterDetails = registeredVoter.constructFrom(payloadJson);
            if (voterDetails is registeredVoter) {

                if (voterDetails.id == "" || voterDetails.fullName == "" || voterDetails.citizenship == false || voterDetails.gender == ""|| voterDetails.age <= 0) {
                        // response.statusCode = 400;
                        // response.setPayload("Invalid Voter Details [!] " ;
                        io:println("invalid")
                } else {

                    var sendRes = prod -> send(voterDetails,"voters", partition = 0 )
                    
                    if(sendRes is error){
                        io:println("Shame :( ")
                    }

                }

    }

}