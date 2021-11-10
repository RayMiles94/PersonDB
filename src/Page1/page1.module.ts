import { Module } from "@nestjs/common";
import Page1Controller from './page1.controller';
import Page1Service from './page1.service';


@Module({
    imports: [],
    controllers: [Page1Controller],
    providers: [Page1Service]
})
export class Page1Module {};