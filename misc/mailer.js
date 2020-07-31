const nodemailer=require('nodemailer');

const transport = nodemailer.createTransport({

    service:'Gmail',
    auth: {
        user: 'tn397032@gmail.com',
        pass: '11112222AAAA'
    },
    tls:{
        rejectUnauthorized: false
    }
});

module.exports = {
    async sendEmail(from,to,subject,html){
        return new Promise((resolve, reject)=>{
            transport.sendMail({from, subject, to, html}, (err, info)=>{
                if(err)reject(err);
                resolve(info);
            })
        })
    }
};
