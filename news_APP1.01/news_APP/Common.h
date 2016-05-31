//
//  Common.h
//  news_APP
//
//  Created by qingyun on 16/5/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#ifndef Common_h
#define Common_h
//    "thumbnail": "http:\/\/d.ifengimg.com\/w132_h94_q75\/p2.ifengimg.com\/ifengimcp\/pic\/20160513\/44321b5a7ef807136d36_size14_w265_h190.jpg",     //缩略图
//    "online": "1",                                //在线
//    "title": "[晚FUN来了]努力不一定会成功 但是不劳而获很爽哦",    //标题
//    "source": "凤凰新闻客户端",                      //来源
//    "updateTime": "2016\/05\/13 18:09:19",        //更新时间
//    "id": "http:\/\/api.iclient.ifeng.com\/ipadtestdoc?aid=109165390", //详情页面
//    "type": "doc",                                //新闻类型
//    "hasSurvey": true,                            //是否调查
//    "hasSlide": true,                             //是否有幻灯片
//    "style": {                                    // 在"hasSlide": true, 的情况下 才有style
//        "type": "slides",
//          "images": ["http:\/\/d.ifengimg.com\/w155_h107_q75\/p3.ifengimg.com\/ifengimcp\/pic\/20160513\/     88f7d8c55d7d5de8e66d_size42_w429_h307.jpg", "http:\/\/d.ifengimg.com\/w155_h107_q75\/p1.ifengimg.com\/              ifengimcp\/pic\/20160513\/c680ac2be94512f30740_size59_w438_h314.jpg", "http:\/\/d.ifengimg.com\/        w155_h107_q75\/p3.ifengimg.com\/ifengimcp\/pic\/20160513\/6c300bef1decc3731790_size26_w398_h284.jpg"]
//              },
//    "commentsUrl": "http:\/\/wap.ifeng.com\/news.jsp?aid=109165390",   //评论链接
//    "comments": "45",                             //评论数
//    "commentsall": "75",                          //总评论数
//    "link": {                                     //链接
//            "type": "doc",                        //类型 
//            "url": "http:\/\/api.iclient.ifeng.com\/ipadtestdoc?aid=109165390"  //链接
//            }
static NSString * const SSthumbnail = @"thumbnail";     //缩略图
static NSString * const SSonline = @"online";           //是否在线(制定的新闻专题为0)
static NSString * const SStitle = @"title";             //新闻标题
static NSString * const SSsource = @"source";           //数据来源
static NSString * const SSupdateTime = @"updateTime";   //更新时间
static NSString * const SSNewsid = @"id";               //详情页面链接
static NSString * const SStype = @"type";               //新闻类型
static NSString * const SShasSurvey = @"hasSurvey";     //是否调查
static NSString * const SShasSlide = @"hasSlide";       //是否有幻灯片显示

static NSString * const SSslideStyle = @"style";        //幻灯片风格(在hasSlide下才有此属性) { type类型, images [ 三个图片链接 ] }
static NSString * const SSslideImages = @"images";      //
static NSString * const SScommentsUrl = @"commentsUrl"; //评论链接
//static NSString * const SScomments = @"comments";     //评论数
static NSString * const SScommentsall = @"commentsall"; //总评论数
//static NSString * const SSlink = @"link";             //链接   { type类型，url连接 }




#endif /* Common_h */
