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
    anydata msgVal = rec.value;

if(msgVal is string) {
    io:println("Nice");
} else {
    io:println("Shit, -> ", msgVal);
}


}