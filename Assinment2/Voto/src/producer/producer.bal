import ballerina/http;
import ballerina/kafka;

kafka:ProducerConfiguration prodConfig ={
bootstrapServers:"localhost:9092, localhost:9092",
clientId: "registeredVoters",
acks:"all",
retryCount:3
};

kafka:Producer kafkaProducer = new (prodConfig);



type registereVoter record {
    int id;
    string fullName;
    string address;
    string citizenship;
    string gender;
    int age;   
};

listener http:Listener http_Listener = new (9090);
    
@http:ServiceConfig{
    basePath: "/add"
}

service add on http_Listener {

    @http:ResourceConfig {  path: "/voters/{name}"  } 
    
    }