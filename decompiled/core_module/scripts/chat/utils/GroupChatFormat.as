package chat.utils
{
   import chat.datas.ChatCellData;
   import chat.datas.ChatChannel;
   import com.pickgliss.utils.ObjectPool;
   import flash.text.engine.ElementFormat;
   import flash.text.engine.FontDescription;
   import manager.LanguageMgr;
   import mvc.module.groupchat.ConsortiaGroupChatData;
   import mvc.module.room.RoomInfo;
   import mvc.module.star.StarInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.StarTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class GroupChatFormat
   {
      
      public function GroupChatFormat()
      {
         super();
      }
      
      public static function createExtraChatCellByContent(param1:Array, param2:ConsortiaGroupChatData) : Vector.<ChatCellData>
      {
         var _loc8_:ChatCellData = null;
         var _loc5_:XML = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:String = "";
         var _loc4_:String = param2.msg;
         var _loc9_:Vector.<ChatCellData> = new Vector.<ChatCellData>();
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc7_ = 0;
            _loc3_ = param1[_loc6_];
            _loc7_ = _loc4_.indexOf(_loc3_);
            if(_loc7_ > 0)
            {
               _loc8_ = createGeneralCellData(_loc4_.substr(0,_loc7_),param2.channel);
               _loc9_.push(_loc8_);
               _loc8_ = createGeneralCellData(" ",param2.channel);
               _loc9_.push(_loc8_);
            }
            _loc4_ = _loc4_.substr(_loc7_ + _loc3_.length,_loc4_.length);
            if(param2.channel == 2 || param2.channel == 3 || param2.channel == 11 || param2.channel == 12)
            {
               _loc9_ = _loc9_.concat(createSysCellDataByContent(_loc3_,param2.userType,param2.vipGrade,param2.channel));
               _loc8_ = createGeneralCellData(" ",param2.channel);
               _loc9_.push(_loc8_);
            }
            else if(param2.type == 3)
            {
               _loc5_ = new XML(_loc3_);
               _loc8_ = createGeneralCellData("[",param2.channel);
               _loc9_.push(_loc8_);
               _loc8_ = createPlayerCellData(param2.channel,param2.userType,int(_loc5_.@id),_loc5_.@serverName,param2.vipGrade,int(_loc5_.@grades),int(_loc5_.@consortiaId),String(_loc5_.@name));
               _loc9_.push(_loc8_);
               _loc8_ = createGeneralCellData("]",param2.channel);
               _loc9_.push(_loc8_);
               _loc8_ = createGeneralCellData(" ",param2.channel);
               _loc9_.push(_loc8_);
            }
            else if(param2.type == 4)
            {
               _loc8_ = createRoomCellData(_loc3_);
               _loc9_.push(_loc8_);
               _loc8_ = createGeneralCellData(" ",param2.channel);
               _loc9_.push(_loc8_);
            }
            else if(param2.type == 114)
            {
               _loc8_ = createTreasureCellData(param2.channel,_loc5_.@name,_loc5_.@treasureId);
               _loc9_.push(_loc8_);
            }
            else
            {
               _loc9_ = _loc9_.concat(createSysCellDataByContent(_loc3_,param2.userType,param2.vipGrade,param2.channel));
               _loc8_ = createGeneralCellData(" ",param2.channel);
               _loc9_.push(_loc8_);
            }
            _loc6_++;
         }
         if(_loc4_ != "")
         {
            _loc8_ = createGeneralCellData(_loc4_,param2.channel);
            _loc9_.push(_loc8_);
         }
         return _loc9_;
      }
      
      public static function createSysCellDataByContent(param1:String, param2:int, param3:int, param4:int) : Vector.<ChatCellData>
      {
         var _loc8_:ChatCellData = null;
         var _loc5_:int = 0;
         var _loc7_:String = null;
         var _loc9_:Vector.<ChatCellData> = new Vector.<ChatCellData>();
         var _loc6_:XML = new XML(param1);
         var _loc10_:int = int(_loc6_.@t);
         if(_loc10_ == 1)
         {
            _loc8_ = createGeneralCellData("[",param4);
            _loc9_.push(_loc8_);
            _loc8_ = createPlayerCellData(param4,param2,int(_loc6_.@id),_loc6_.@serverName,param3,int(_loc6_.@grades),int(_loc6_.@consortiaId),String(_loc6_.@name));
            _loc9_.push(_loc8_);
            _loc8_ = createGeneralCellData("]",param4);
            _loc9_.push(_loc8_);
         }
         else if(_loc10_ == 2)
         {
            _loc8_ = createGroupChatCellData(param1,param4);
            _loc9_.push(_loc8_);
         }
         else if(_loc10_ == 3)
         {
            _loc8_ = createGroupChatCellData(param1,param4);
            _loc9_.push(_loc8_);
         }
         else if(_loc10_ == 7)
         {
            _loc8_ = createVipLinkCellData(param4,_loc6_.@name);
            _loc9_.push(_loc8_);
         }
         else if(_loc10_ == 8)
         {
            _loc5_ = int(_loc6_.@sontype);
            _loc8_ = createImageCellDataBySonType(_loc5_,param4);
            _loc9_.push(_loc8_);
         }
         else if(_loc10_ == 9)
         {
            _loc7_ = _loc6_.@index;
            _loc8_ = createExpressionByIndex(_loc7_,param4);
            _loc9_.push(_loc8_);
         }
         else if(_loc10_ == 12)
         {
            _loc8_ = createGroupChatCellData(param1,param4);
            _loc9_.push(_loc8_);
         }
         else if(_loc10_ == 13)
         {
            _loc8_ = createGroupChatCellData(param1,param4);
            _loc9_.push(_loc8_);
         }
         else if(_loc10_ == 114)
         {
            _loc8_ = createTreasureCellData(param4,_loc6_.@name,_loc6_.@treasureId);
            _loc9_.push(_loc8_);
         }
         else if(_loc10_ == 116)
         {
            _loc8_ = createGroupChatCellData(param1,param4);
            _loc9_.push(_loc8_);
         }
         else if(_loc10_ == 121)
         {
            _loc8_ = createGroupChatCellData(param1,param4);
            _loc9_.push(_loc8_);
         }
         return _loc9_;
      }
      
      public static function createGroupChatCellData(param1:String, param2:int) : ChatCellData
      {
         var _loc3_:XML = new XML(param1);
         var _loc4_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc4_.type = 2;
         _loc4_.text = "[" + StringHelper.removeHtmlTagByTextField(_loc3_.@name) + "]";
         _loc4_.elementFormat = getGenralFormat(param2);
         return _loc4_;
      }
      
      private static function createExpressionByIndex(param1:String, param2:int) : ChatCellData
      {
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 17;
         _loc3_.faceLink = "chatII.Expression" + param1;
         _loc3_.elementFormat = getUserTypeFormat(param2);
         return _loc3_;
      }
      
      private static function createImageCellDataBySonType(param1:int, param2:int) : ChatCellData
      {
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         switch(param1 - 1)
         {
            case 0:
               _loc3_.type = 13;
               _loc3_.faceLink = "asset.chatII.FirstPlayer";
               break;
            case 1:
               _loc3_.type = 14;
               _loc3_.faceLink = "asset.chatII.PopularPlayer";
               break;
            case 2:
               _loc3_.type = 15;
               _loc3_.faceLink = "asset.chatII.FirstConsortia";
         }
         _loc3_.elementFormat = getUserTypeFormat(param2);
         return _loc3_;
      }
      
      public static function createVipLinkCellData(param1:int, param2:String) : ChatCellData
      {
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 12;
         _loc3_.text = param2;
         _loc3_.elementFormat = getChannelFormat(param1);
         return _loc3_;
      }
      
      public static function createStarCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc4_:StarTemplate = TempleteManager.instance.starTempalteCate.getTemplateByID(int(_loc2_.@id));
         if(!_loc4_)
         {
            return null;
         }
         var _loc3_:StarInfo = new StarInfo();
         _loc3_.grade = int(_loc2_.@grades);
         _loc3_.template = _loc4_;
         var _loc5_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc5_.type = 6;
         _loc5_.data = _loc3_;
         _loc5_.text = _loc2_.@name;
         _loc5_.elementFormat = getProfileFormat(_loc4_.Profile);
         return _loc5_;
      }
      
      public static function createGoodsCellData(param1:String) : ChatCellData
      {
         var _loc8_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:XML = new XML(param1);
         var _loc5_:String = _loc3_.@join;
         var _loc4_:String = _loc3_.@skill;
         var _loc6_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(int(_loc3_.@tempid));
         if(!_loc6_)
         {
            return null;
         }
         var _loc9_:GoodsInfo = new GoodsInfo();
         _loc9_.templateId = int(_loc3_.@tempid);
         _loc9_.id = int(_loc3_.@id);
         _loc9_.strengthenGrade = int(_loc3_.@grade);
         _loc9_.mouldGrade = int(_loc3_.@mouldGrade);
         _loc9_.isBinds = String(_loc3_.@bind) == "true";
         var _loc7_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         if(_loc6_.MasterType == 2 || _loc6_.MasterType == 4)
         {
            _loc7_.type = 3;
         }
         else if(_loc6_.MasterType == 1 || _loc6_.MasterType == 3)
         {
            _loc7_.type = 4;
            _loc8_ = _loc5_.split(",");
            _loc2_ = _loc4_.split(",");
            _loc9_.join1 = int(_loc8_[0]);
            _loc9_.join2 = int(_loc8_[1]);
            _loc9_.join3 = int(_loc8_[2]);
            _loc9_.join4 = int(_loc8_[3]);
            _loc9_.randomSkill1 = int(_loc2_[0]);
            _loc9_.randomSkill2 = int(_loc2_[1]);
            _loc9_.randomSkill3 = int(_loc2_[2]);
            _loc9_.randomSkill4 = int(_loc2_[3]);
            _loc9_.randomSkill5 = int(_loc2_[4]);
         }
         _loc7_.data = _loc9_;
         _loc7_.text = _loc3_.@name;
         _loc7_.elementFormat = getProfileFormat(_loc6_.Profile);
         return _loc7_;
      }
      
      public static function createGeneralCellData(param1:String, param2:int) : ChatCellData
      {
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 2;
         _loc3_.text = StringHelper.removeHtmlTagByTextField(param1);
         _loc3_.elementFormat = getGenralFormat(param2);
         return _loc3_;
      }
      
      public static function createTreasureCellData(param1:int, param2:String, param3:int) : ChatCellData
      {
         var _loc4_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc4_.type = 114;
         _loc4_.text = param2;
         _loc4_.userId = param3;
         _loc4_.elementFormat = getChannelFormat(param1);
         return _loc4_;
      }
      
      public static function createGMCellData(param1:int) : ChatCellData
      {
         var _loc2_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc2_.type = 10;
         _loc2_.faceLink = "asset.chatII.GmIcon";
         _loc2_.elementFormat = getUserTypeFormat(param1);
         return _loc2_;
      }
      
      public static function createGuiderCellData(param1:int) : ChatCellData
      {
         var _loc2_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc2_.type = 16;
         _loc2_.faceLink = "asset.chatII.GuiderIcon";
         _loc2_.elementFormat = getUserTypeFormat(param1);
         return _loc2_;
      }
      
      public static function createAppellCellData(param1:int, param2:int) : ChatCellData
      {
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 18;
         _loc3_.faceLink = "chat.AppellText2";
         var _loc4_:AppellInfoTemplate = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(param2);
         _loc3_.text = _loc4_.Perfix;
         _loc3_.elementFormat = getUserTypeFormat(param1);
         return _loc3_;
      }
      
      public static function createVipCellData(param1:int) : ChatCellData
      {
         var _loc2_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc2_.type = 11;
         _loc2_.faceLink = "asset.core.simpleVIPIcon";
         _loc2_.elementFormat = getUserTypeFormat(param1);
         return _loc2_;
      }
      
      public static function createPlayerCellData(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:String, param9:String = "") : ChatCellData
      {
         var _loc10_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc10_.type = 1;
         _loc10_.userId = param3;
         _loc10_.vipGrade = param5;
         _loc10_.grades = param6;
         _loc10_.consortiaId = param7;
         _loc10_.serverName = param4;
         _loc10_.data = param8;
         _loc10_.userType = param2;
         _loc10_.text = param8;
         _loc10_.uuid = param9;
         _loc10_.elementFormat = getNameFormat(param2,param5,param1);
         return _loc10_;
      }
      
      public static function createConsortiaCellData(param1:int, param2:String) : ChatCellData
      {
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 7;
         _loc3_.consortiaId = param1;
         _loc3_.text = "[" + param2 + "]，" + LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaRecruitFrame.command01");
         _loc3_.elementFormat = getConsortiaNameFormat();
         return _loc3_;
      }
      
      public static function createRoomCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc4_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         var _loc3_:RoomInfo = new RoomInfo();
         _loc3_.id = int(_loc2_.@id);
         _loc4_.type = 8;
         _loc4_.text = _loc2_.@name;
         _loc4_.elementFormat = getConsortiaNameFormat();
         _loc4_.data = _loc3_;
         return _loc4_;
      }
      
      public static function getContentCellData(param1:ConsortiaGroupChatData) : Vector.<ChatCellData>
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:ChatCellData = null;
         var _loc5_:Vector.<ChatCellData> = new Vector.<ChatCellData>();
         _loc2_ = param1.msg;
         _loc3_ = _loc2_.match(/\<([^>]*)>*/g);
         if(_loc3_.length > 0)
         {
            _loc5_ = _loc5_.concat(createExtraChatCellByContent(_loc3_,param1));
         }
         else if(param1.type == 2)
         {
            _loc4_ = createConsortiaCellData(param1.consortiaId,param1.consortiaName);
            _loc5_.push(_loc4_);
            _loc4_ = createGeneralCellData(param1.msg,param1.channel);
            _loc5_.push(_loc4_);
         }
         else
         {
            _loc4_ = createGeneralCellData(param1.msg,param1.channel);
            _loc5_.push(_loc4_);
         }
         return _loc5_;
      }
      
      public static function createChannelCellData(param1:int) : ChatCellData
      {
         var _loc2_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc2_.type = 9;
         _loc2_.channel = param1;
         _loc2_.text = "[ " + ChatChannel.getChatChannelName(param1) + " ]";
         _loc2_.elementFormat = getChannelFormat(param1);
         return _loc2_;
      }
      
      public static function createSpeakerCellData(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int, param7:int, param8:String) : Vector.<ChatCellData>
      {
         var _loc9_:ChatCellData = null;
         var _loc10_:Vector.<ChatCellData> = new Vector.<ChatCellData>();
         if(param8)
         {
            if(param2 == 2)
            {
               _loc9_ = createGMCellData(param1);
               _loc10_.push(_loc9_);
               _loc9_ = createGeneralCellData(" ",param1);
               _loc10_.push(_loc9_);
            }
            else if(param2 == 6)
            {
               _loc9_ = createGuiderCellData(param1);
               _loc10_.push(_loc9_);
               _loc9_ = createGeneralCellData(" ",param1);
               _loc10_.push(_loc9_);
            }
            else if(param5 == ArmyManager.instance.thane.userId && ArmyManager.instance.thane.appellInfo.Perfix)
            {
               _loc9_ = createAppellCellData(param1,ArmyManager.instance.thane.appellId);
               _loc10_.push(_loc9_);
            }
            _loc9_ = createGeneralCellData("[",param1);
            _loc10_.push(_loc9_);
            if(param4 > 0)
            {
               _loc9_ = createVipCellData(param1);
               _loc10_.push(_loc9_);
            }
            _loc9_ = createPlayerCellData(param1,param2,param5,param3,param4,param6,param7,param8);
            _loc10_.push(_loc9_);
            _loc9_ = createGeneralCellData(LanguageMgr.GetTranslation("public.colon","]"),param1);
            _loc10_.push(_loc9_);
         }
         return _loc10_;
      }
      
      public static function getConsortiaNameFormat() : ElementFormat
      {
         var _loc2_:FontDescription = new FontDescription();
         _loc2_.fontName = "Arial";
         var _loc1_:ElementFormat = new ElementFormat();
         _loc1_.breakOpportunity = "none";
         _loc1_.alignmentBaseline = "ideographicCenter";
         _loc1_.dominantBaseline = "ideographicCenter";
         _loc1_.baselineShift = 0;
         _loc1_.fontDescription = _loc2_;
         _loc1_.trackingRight = 1;
         _loc1_.color = 55551;
         return _loc1_;
      }
      
      public static function getProfileFormat(param1:int) : ElementFormat
      {
         var _loc3_:FontDescription = new FontDescription();
         _loc3_.fontName = "Arial";
         var _loc2_:ElementFormat = new ElementFormat();
         _loc2_.breakOpportunity = "none";
         _loc2_.alignmentBaseline = "ideographicCenter";
         _loc2_.dominantBaseline = "ideographicCenter";
         _loc2_.baselineShift = 0;
         _loc2_.fontDescription = _loc3_;
         _loc2_.trackingRight = 1;
         switch(param1 - 1)
         {
            case 0:
               _loc2_.color = 16777215;
               break;
            case 1:
               _loc2_.color = 5885249;
               break;
            case 2:
               _loc2_.color = 3318520;
               break;
            case 3:
               _loc2_.color = 11024631;
               break;
            case 4:
               _loc2_.color = 15439108;
               break;
            case 5:
               _loc2_.color = 13504271;
         }
         return _loc2_;
      }
      
      public static function getNameFormat(param1:int, param2:int, param3:int) : ElementFormat
      {
         var _loc5_:FontDescription = new FontDescription();
         _loc5_.fontName = "Arial";
         var _loc4_:ElementFormat = new ElementFormat();
         _loc4_.alignmentBaseline = "ideographicCenter";
         _loc4_.dominantBaseline = "ideographicCenter";
         if(param1 == 2)
         {
            _loc4_.color = 16711684;
         }
         else
         {
            _loc4_.color = getContentColor(param3);
         }
         _loc4_.breakOpportunity = "none";
         _loc4_.baselineShift = 0;
         _loc4_.fontDescription = _loc5_;
         _loc4_.trackingRight = 1;
         return _loc4_;
      }
      
      public static function getChannelFormat(param1:int) : ElementFormat
      {
         var _loc3_:FontDescription = new FontDescription();
         _loc3_.fontName = "Arial";
         var _loc2_:ElementFormat = new ElementFormat();
         _loc2_.breakOpportunity = "none";
         _loc2_.alignmentBaseline = "ideographicCenter";
         _loc2_.dominantBaseline = "ideographicCenter";
         _loc2_.color = getContentColor(param1);
         _loc2_.baselineShift = 0;
         _loc2_.fontDescription = _loc3_;
         _loc2_.trackingRight = 0;
         return _loc2_;
      }
      
      public static function getUserTypeFormat(param1:int) : ElementFormat
      {
         var _loc3_:FontDescription = new FontDescription();
         _loc3_.fontName = "Arial";
         var _loc2_:ElementFormat = new ElementFormat();
         _loc2_.breakOpportunity = "none";
         _loc2_.alignmentBaseline = "ideographicCenter";
         _loc2_.dominantBaseline = "ideographicCenter";
         _loc2_.color = getContentColor(param1);
         _loc2_.baselineShift = 0;
         _loc2_.fontDescription = _loc3_;
         _loc2_.trackingRight = 0;
         return _loc2_;
      }
      
      public static function getGenralFormat(param1:int) : ElementFormat
      {
         var _loc3_:FontDescription = new FontDescription();
         _loc3_.fontName = "Arial";
         var _loc2_:ElementFormat = new ElementFormat();
         _loc2_.breakOpportunity = "none";
         _loc2_.alignmentBaseline = "ideographicCenter";
         _loc2_.dominantBaseline = "ideographicCenter";
         _loc2_.color = getContentColor(param1);
         _loc2_.baselineShift = 2;
         _loc2_.fontDescription = _loc3_;
         _loc2_.trackingRight = 1;
         return _loc2_;
      }
      
      public static function getContentColor(param1:int) : int
      {
         switch(param1)
         {
            case 1:
               return 55551;
            case 10:
               return 15439108;
            case 109:
               return 15439108;
            case 2:
            case 11:
               break;
            case 3:
               return 16774656;
            case 5:
               return 5035345;
            case 6:
               return 9674239;
            case 8:
               return 16777215;
            case 12:
               return 16774656;
            case 98:
               return 323365;
            case 99:
            case 100:
               return 1842204;
            case 101:
               return 12336903;
            case 102:
               return 9471;
            default:
               return 16777215;
         }
         return 16774656;
      }
   }
}

