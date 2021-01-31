import ballerina/io;
import ballerina/kafka;
import ballerina/log;
// import ballerina/lang;

kafka:ConsumerConfiguration consumerConfig ={
    bootstrapServers: "localhost:9092",
    groupId: "registered-Voters",
    topics:["Voting"],

    // pollingIntervalMillis: 1000,
    // keyDeserializerType:Kafka:DES_INT,
    // valueDeserializerType:kafka:DES_STRING,
    autoCommit:false
};

listener kafka:Consumer consumer = new (consumerConfig);

service kafkaService on consumer {
    resource function onMassage(kafka:Consumer kc, kafka:ConsumerRecord[] records){
        foreach var rec in records {
            processRecord(rec);
        }
        var commitResults = kafkaConsumer -> commit();

        // if (commitResults if error) {
        // io:println("Error -> ", commitResults)
        // }

    }
}

function processRecord(kafka:ConsumerRecord rec) {
    anydata msgVal = rec.val;

if(msgVal is string) {
    io:println("Nice");
} else {
    io:println("Shit, -> ", msgVal);
}


}