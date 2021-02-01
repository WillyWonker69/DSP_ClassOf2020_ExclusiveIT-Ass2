import ballerina/io;
import ballerina/kafka;
// import ballerina/log;
// import ballerina/lang;

kafka:ConsumerConfiguration consumerConfig ={
    bootstrapServers: "localhost:9092",
    groupId: "group-id",

    topics:["VotoTopic"],
    pollingIntervalInMillis: 1000,
    keyDeserializerType:kafka:DES_INT,
    valueDeserializerType:kafka:DES_STRING,
    autoCommit:false
};
public type  registeredVoter record {
    int id;
    string fullName;
    boolean citizenship;
    string gender;
    int age;
};

listener kafka:Consumer consumer = new (consumerConfig);

service kafkaService on consumer {
    resource function onMessage(kafka:Consumer kc, kafka:ConsumerRecord[] records){
       
       
       
        foreach var rec in records {
            processRecord(rec);
        }
        var commitResults = kc -> commit();

        if (commitResults is error) {
        io:println("Error -> ", commitResults);
        }

    }
}

    function processRecord(kafka:ConsumerRecord rec) {

        // anydata msgVal = rec. ;
        // io:println(rec);

        // registeredVoter voterDetails

        // Array storing the records of registered voters
        kafka:ConsumerRecord []  storedApprovedVoters = [];
        storedApprovedVoters.push(rec);
        io:println("This is the stored Record: \n",storedApprovedVoters.toString());

    }

