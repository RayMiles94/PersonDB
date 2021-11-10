import { Controller, Get } from '@nestjs/common';


@Controller('page1')
class Page1Controller {

    constructor() {}

    @Get()
    public getPage1() : string {
        return "Page 1";
    }

}

export default Page1Controller;