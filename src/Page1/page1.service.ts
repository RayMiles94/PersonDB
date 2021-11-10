import { Injectable } from "@nestjs/common";

@Injectable()
class Page1Service {

    data : string;

    constructor() {
        this.data = "hello page1";
    }

    public getDATA(): string {
        return this.data;
    }

}

export default Page1Service;