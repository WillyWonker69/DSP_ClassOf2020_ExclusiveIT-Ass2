// import ballerina/http;
import ballerina/kafka;
import ballerina/io;

kafka:ProducerConfiguration prodConfig = {
    bootstrapServers: "localhost:9092",
    clientId: "registeredVoters",
    acks: "all",
    
    retryCount: 3
};

kafka:Producer kafkaProducer = new (prodConfig);

public type  registeredVoter record {
    int id;
    string fullName;
    boolean citizenship;
    string gender;
    int age;
};
type ballotType record {

};


public function main(string... args) {
    registeredVoter[] VoterList = [];
    registeredVoter voter1 = {
        id: 23,
        fullName: "Woneker Willy",
        citizenship: true,
        gender: "male",
        age: 21
    };

    VoterList.push(voter1);
    newVoter(voter1);
}


public function newVoter(registeredVoter voterDetails ) {

            if (voterDetails.id == 0 || voterDetails.fullName == "" || voterDetails.citizenship == false || voterDetails.gender == "" || voterDetails.age <= 0)
            {
                // response.statusCode = 400;
                // response.setPayload("Invalid Voter Details [!] " ;
                io:println("invalid");
            } else {

                var sendRes = kafkaProducer->send(voterDetails.toString().toBytes(), "VotoTopic", partition = 0);

                if (sendRes is error) {
                    io:println("Shame :( ");
                }

            }
        }
    






