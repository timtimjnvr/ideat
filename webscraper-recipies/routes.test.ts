import Response from "express";
const supertest: any = require('supertest')

const server = require("./server");
const request: any = supertest(server);

test('server started', () => {
    request.get('/').then((res : Response) => {
        expect(res.status).toBe(200);
    });  
})