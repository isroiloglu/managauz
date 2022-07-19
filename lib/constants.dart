import 'package:flutter/material.dart';

import 'models/main_model.dart';

const base_url = "https://manage.uz/";
const media_url = "http://188.166.222.81/";
final photoReportUrl = 'api/agent/photoreport';
const mainColor = Color(0xFF2ECC71);

MainApi basemainapi = MainApi(
    user: User(id: 0, ism: '', fam: '', login: '', parol: ''),
    zakazlar: [],
    skladlar: [],
    prCategory: [],
    tovarlar: [],
    customs: [],
    categories: [],
    productcategories: []);
const cFirstColor = Color(0xFF2F49D1);
const cThreeColor = Color(0xFF2487FE);
const cTextColor = Color(0xFF82B3DB);
const cSecondColor = Color(0xFF82B3DB);
const cTextColor2 = Color(0xFFA7C2D8);
const cTextColor3 = Color(0xFF64697E);
const cBlackColor = Color(0xFF000000);
const cWhiteColor = Color(0xFFFFFFFF);
const cRedColor = Color(0xFFDC200E);
const cGrayColor = Color(0xFFBFBFBF);
const cGrayColor1 = Color(0xFFA7C2D8);
const cYellowColor = Color(0xFFFFC92F);
const cBackColor = Color(0xFFF3F4FD);
const cBackColor2 = Color(0xFFF3F4FD);
const cBackColor3 = Color(0xFFEDF8F8);
const cBackColor4 = Color(0xFF2A7CDE);
const cBackColorImage = Color(0xFFFF007A);
const cBackColorImage2 = Color(0xFFDFF1FF);