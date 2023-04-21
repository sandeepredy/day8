exports.handler = async (event) => {
    console.log("Event: ", event);

    let responseMessage = "Hello World";


    if (event.queryStringParameter && event.queryStringParameter["Name"]) {
        responseMessage = "Hello" + event.queryStringParameter["Name"] + "!";
    }


    if (event.httpMethod === "POST") {
        const body = JSON.parse(event.body);
        responseMessage = "Hello, " + body.name + "!";
    }
};


const response = {
    statusCode: 200,
    headers: {
        "Content-Type": "application/json",
    },
    body: JSON.stringify({
        message: responseMessage,
    }),
};


return response;