import EthCrypto from 'eth-crypto';
    var batchSize = 100000;
    var addressBatch = new Array(batchSize);
    const random = (length) =>{
        let chars ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let str ="";
        for(let i =0; i<length; i++){
            str += chars.charAt(Math.floor(Math.random()*chars.length));
        
        }
        return str;
    };
    const secretMessage = random(1000);
    console.log("Message", secretMessage);
    let startTime = Date.now();
    for(let i=0; i< batchSize; ++i){
    addressBatch[i] = EthCrypto.createIdentity();
    }
    let endTime = Date.now();
    console.log("Generate", batchSize, "address in", (endTime-startTime),"ms");
    startTime = Date.now();
    console.log("Encrypting time", startTime, endTime, (endTime-startTime), "ms");
