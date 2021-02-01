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
        id: 29875,
        fullName: "Wonker Willy",
        citizenship: true,
        gender: "male",
        age: 21
    };

    registeredVoter voter2 = {
        id: 8765,
        fullName: "Sagi Magteran",
        citizenship: true,
        gender: "Female",
        age: 41
    };

    registeredVoter voter3 = {
        id: 7653,
        fullName: "Mino Viera",
        citizenship: false,
        gender: "male",
        age: 22
    };

    registeredVoter voter4 = {
        id: 7868,
        fullName: "Cesario Alves",
        citizenship: true,
        gender: "male",
        age: 17
    };
    
    registeredVoter voter5 = {
        id: 9823,
        fullName: "Nsala Malinga",
        citizenship: false,
        gender: "female",
        age: 34
    };

    registeredVoter voter6 = {
        id: 2983,
        fullName: "Wilson Matanga",
        citizenship: false,
        gender: "male",
        age: 18
    };

    VoterList.push(voter1);
    // newVoter(voter1);

    VoterList.push(voter2);
    // newVoter(voter3);

    VoterList.push(voter3);
    // newVoter(voter3);

    VoterList.push(voter4);
    // newVoter(voter4);

    VoterList.push(voter5);
    // newVoter(voter5);

    VoterList.push(voter6);
    // newVoter(voter6);

    // io:println("Welcome to the Kafka tutorial...");
	
	// json registeredVoter = {
	// 	assignmentDeadline: "31/01/2021",
	// 	submissionMode: "online"
	// };
	
	// //byte[] serialisedMsg = msg.toString().toBytes();
    foreach registeredVoter voter in VoterList {
        newVoter(voter);
    }

}


public function newVoter(registeredVoter voterDetails ) {

            if (voterDetails.id == 0 || voterDetails.fullName == "" || voterDetails.citizenship == false || voterDetails.gender == "" || voterDetails.age < 18)
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
    
    





