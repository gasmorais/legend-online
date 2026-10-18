package chat.utils
{
   import chat.datas.ChatCellData;
   import chat.datas.ChatChannel;
   import chat.datas.ChatData;
   import chat.view.ExpressionChatNotic;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.engine.ContentElement;
   import flash.text.engine.ElementFormat;
   import flash.text.engine.FontDescription;
   import flash.text.engine.GraphicElement;
   import flash.text.engine.GroupElement;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextElement;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.card.MagicCardBuffInfo;
   import mvc.module.card.MagicCardInfo;
   import mvc.module.gamehall.GameHallGameInfo;
   import mvc.module.marry.MarryCampaignInfo;
   import mvc.module.room.RoomInfo;
   import mvc.module.star.StarInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MagicCardTemplateInfo;
   import yishi.datas.templates.StarTemplate;
   import yishi.manager.AppellManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.utils.StringUtil;
   import yishi.utils.WorldBossHelper;
   
   public class ChatFormat
   {
      
      public static const CONSORTIANAMEFORMAT:String = "consortianameformat";
      
      public static const PROFILEFORMAT:String = "profileformat";
      
      public static const NAMEFORMAT:String = "nameformat";
      
      public static const CHANNELFORMAT:String = "channelformat";
      
      public static const USERTYPEFORMAT:String = "usertypeformat";
      
      public static const GENRALFORMAT:String = "genralformat";
      
      private static var link3style:String = "{0}{1}{2}";
      
      private static var link2style:String = "{0}{1}";
      
      private static var _testField:FilterFrameText;
      
      private static const GAME_HALL_TYPE:int = 4;
      
      private static var index:int = 0;
      
      private static var _ge:GroupElement;
      
      private static var _gelment:GraphicElement;
      
      private static var _dis:DisplayObject;
      
      private static var _cel:int;
      
      private static var _cei:int;
      
      private static var formatDic:Dictionary = new Dictionary();
      
      private static var _elementVec:Vector.<Vector.<ContentElement>> = new Vector.<Vector.<ContentElement>>();
      
      public function ChatFormat()
      {
         super();
      }
      
      public static function createExtraChatCellByContent(param1:Array, param2:ChatData) : Vector.<ChatCellData>
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
               _loc9_ = _loc9_.concat(createSysCellDataByContent(_loc3_,param2.userType,param2.vipGrade,param2.channel,param2.senderName,param2.receiverName));
               _loc8_ = createGeneralCellData(" ",param2.channel);
               _loc9_.push(_loc8_);
            }
            else if(param2.type == 3)
            {
               _loc5_ = new XML(_loc3_);
               _loc8_ = createGeneralCellData("[",param2.channel);
               _loc9_.push(_loc8_);
               _loc8_ = createPlayerCellData(param2.channel,param2.userType,int(_loc5_.@id),_loc5_.@serverName,param2.vipGrade,int(_loc5_.@grades),int(_loc5_.@consortiaId),String(_loc5_.@name),String(_loc5_.@uuid));
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
            else
            {
               _loc9_ = _loc9_.concat(createSysCellDataByContent(_loc3_,param2.userType,param2.vipGrade,param2.channel,param2.senderName,param2.receiverName));
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
      
      public static function createSysCellDataByContent(param1:String, param2:int, param3:int, param4:int, param5:String, param6:String) : Vector.<ChatCellData>
      {
         var _loc10_:ChatCellData = null;
         var _loc8_:XML = null;
         var _loc7_:int = 0;
         var _loc9_:String = null;
         var _loc11_:Vector.<ChatCellData> = new Vector.<ChatCellData>();
         try
         {
            _loc8_ = new XML(param1);
         }
         catch(e:Error)
         {
            return _loc11_;
         }
         var _loc12_:int = int(_loc8_.@t);
         if(_loc12_ == 1)
         {
            _loc10_ = createGeneralCellData("[",param4);
            _loc11_.push(_loc10_);
            _loc10_ = createPlayerCellData(param4,param2,int(_loc8_.@id),_loc8_.@serverName,param3,int(_loc8_.@grades),int(_loc8_.@consortiaId),String(_loc8_.@name),String(_loc8_.@uuid));
            _loc11_.push(_loc10_);
            _loc10_ = createGeneralCellData("]",param4);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 2 || _loc12_ == 14)
         {
            _loc10_ = createGoodsCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 3)
         {
            _loc10_ = createStarCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 7)
         {
            _loc10_ = createVipLinkCellData(param4,_loc8_.@name);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 8)
         {
            _loc7_ = int(_loc8_.@sontype);
            _loc10_ = createImageCellDataBySonType(_loc7_,param4);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 9)
         {
            _loc9_ = _loc8_.@index;
            _loc10_ = createExpressionByIndex(_loc9_,param4);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 10)
         {
            _loc10_ = createAppellLinkCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 11)
         {
            _loc10_ = createRoseBackCellData(param1,param5,param6);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 12)
         {
            _loc10_ = createReinforceCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 100)
         {
            _loc10_ = createSeekLinkCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 101)
         {
            _loc10_ = createCardCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 15)
         {
            _loc10_ = createPetBossReinforceCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 16)
         {
            _loc10_ = createCardBackCellData(param1,param5,param6);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 102)
         {
            _loc10_ = createFishCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 110)
         {
            _loc10_ = createGoldRoadCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 111)
         {
            _loc10_ = createOuterCityBossCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 112)
         {
            _loc10_ = createPlanesHelpCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 113)
         {
            _loc10_ = createOpenSaleWinCellData(param1);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 114)
         {
            _loc10_ = createGoodsCellData(param1);
            _loc10_ = createTreasureCellData(param4,_loc8_.@name,_loc8_.@treasureId,_loc8_.@quality);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 116)
         {
            _loc10_ = creatSpaceTimefault(param4,_loc8_.@name,param5,_loc8_.@data);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 117)
         {
            _loc10_ = creatAlchemicalInvite(_loc8_.@name,_loc8_.@rewardType,_loc8_.@shareUid);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 118)
         {
            _loc10_ = creatCrisisAttcknvite(_loc8_.@userId,_loc8_.@nodeId);
            _loc11_.push(_loc10_);
         }
         else if(_loc12_ == 121)
         {
            _loc10_ = createConsortiaNewBossOpenData(param1);
            _loc11_.push(_loc10_);
         }
         return _loc11_;
      }
      
      public static function createConsortiaNewBossOpenData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 121;
         _loc3_.text = _loc2_.@name;
         _loc3_.consortiaId = _loc2_.@consortiaId;
         _loc3_.elementFormat = getConsortiaNameFormat();
         return _loc3_;
      }
      
      public static function createOuterCityBossCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 111;
         _loc3_.text = _loc2_.@name;
         _loc3_.elementFormat = getConsortiaNameFormat();
         return _loc3_;
      }
      
      public static function createPlanesHelpCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 112;
         _loc3_.text = _loc2_.@name;
         _loc3_.userId = _loc2_.@userId;
         _loc3_.elementFormat = getConsortiaNameFormat();
         return _loc3_;
      }
      
      public static function createOpenSaleWinCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 113;
         _loc3_.text = _loc2_.@name;
         _loc3_.userId = _loc2_.@userId;
         _loc3_.elementFormat = getConsortiaNameFormat();
         return _loc3_;
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
      
      public static function createTreasureCellData(param1:int, param2:String, param3:int, param4:int) : ChatCellData
      {
         var _loc5_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc5_.type = 114;
         _loc5_.text = param2;
         _loc5_.userId = param3;
         _loc5_.elementFormat = getFiveProfileFormat(param4 + 1);
         return _loc5_;
      }
      
      public static function creatSpaceTimefault(param1:int, param2:String, param3:String, param4:String) : ChatCellData
      {
         var _loc5_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc5_.type = 116;
         _loc5_.text = param2;
         _loc5_.nickName = param3;
         _loc5_.data = param4;
         _loc5_.elementFormat = getConsortiaNameFormat();
         return _loc5_;
      }
      
      public static function creatAlchemicalInvite(param1:String, param2:int, param3:int) : ChatCellData
      {
         var _loc4_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc4_.type = 117;
         _loc4_.text = LanguageMgr.GetTranslation("Alchemical.chatInvite.text" + param2) + "-" + param1;
         _loc4_.userType = param3;
         _loc4_.elementFormat = getConsortiaNameFormat();
         return _loc4_;
      }
      
      public static function creatCrisisAttcknvite(param1:int, param2:int) : ChatCellData
      {
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 118;
         _loc3_.text = LanguageMgr.GetTranslation("planeCrisis.attackBossInvate");
         _loc3_.data = [param1,param2];
         _loc3_.elementFormat = getConsortiaNameFormat();
         return _loc3_;
      }
      
      public static function createFishCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 30;
         _loc3_.text = _loc2_.@name;
         _loc3_.elementFormat = getConsortiaNameFormat();
         _loc3_.userId = _loc2_.@userId;
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
      
      public static function createCardCellData(param1:String) : ChatCellData
      {
         var _loc4_:XML = new XML(param1);
         var _loc2_:MagicCardTemplateInfo = TempleteManager.instance.magicCardTemplateCate.getInfoByIdAndGardes(int(_loc4_.@id),int(_loc4_.@grades));
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:MagicCardInfo = new MagicCardInfo();
         _loc3_.templateId = int(_loc4_.@id);
         _loc3_.grades = int(_loc4_.@grades);
         var _loc5_:MagicCardBuffInfo = new MagicCardBuffInfo();
         _loc5_.bufId = int(_loc4_.@bufId);
         _loc5_.sonType = int(_loc4_.@sonType);
         _loc5_.fixvalue = int(_loc4_.@fixValue);
         _loc5_.percent = int(_loc4_.@percent);
         var _loc6_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc6_.type = 27;
         _loc6_.data = _loc3_;
         _loc6_.text = _loc4_.@name;
         _loc6_.elementFormat = getProfileFormat(_loc2_.Profile);
         return _loc6_;
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
         _loc9_.appraisal_skill = int(_loc3_.@appSkill);
         var _loc7_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         if(_loc6_.MasterType == 2 || _loc6_.MasterType == 4)
         {
            _loc7_.type = 3;
         }
         else if(_loc6_.MasterType == 1 || _loc6_.MasterType == 3 || _loc6_.MasterType == 6 || _loc6_.MasterType == 5 || _loc6_.SonType == 232)
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
         else
         {
            _loc7_.type = 3;
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
         _loc3_.faceLink = "chatII.Appell" + AppellManager.instance.model.getPerfixStyle(param2);
         var _loc4_:AppellInfoTemplate = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(param2);
         _loc3_.text = _loc4_.Perfix;
         _loc3_.elementFormat = getUserTypeFormat(param1);
         return _loc3_;
      }
      
      public static function createVipCellData(param1:int) : ChatCellData
      {
         var _loc2_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc2_.type = 11;
         _loc2_.faceLink = "asset.chatII.VipEffect";
         _loc2_.elementFormat = getUserTypeFormat(param1);
         return _loc2_;
      }
      
      public static function createPlayerCellData(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:String, param9:String = "") : ChatCellData
      {
         var _loc10_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc10_.type = 1;
         _loc10_.channel = param1;
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
      
      public static function creatGodsEveningCellData(param1:String, param2:int) : ChatCellData
      {
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 2;
         _loc3_.text = param1;
         _loc3_.elementFormat = getGodsEveningTextFormat(param2);
         return _loc3_;
      }
      
      public static function creatGodsEveningGotoCellData(param1:Object, param2:int) : ChatCellData
      {
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 31;
         _loc3_.data = param1;
         if(param2 == GodsEveningManager.instance.model.teamId)
         {
            _loc3_.text = LanguageMgr.GetTranslation("godsEvening.chatData.noticeGoto1");
         }
         else
         {
            _loc3_.text = LanguageMgr.GetTranslation("godsEvening.chatData.noticeGoto2");
         }
         _loc3_.elementFormat = getConsortiaNameFormat();
         return _loc3_;
      }
      
      public static function createRoomCellData(param1:String) : ChatCellData
      {
         var _loc6_:GameHallGameInfo = null;
         var _loc2_:MarryCampaignInfo = null;
         var _loc3_:RoomInfo = null;
         var _loc5_:XML = new XML(param1);
         var _loc7_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         var _loc8_:int = int(_loc5_.@roomType);
         var _loc4_:int = int(_loc5_.@t);
         if(_loc4_ == 4)
         {
            _loc6_ = new GameHallGameInfo();
            _loc6_.teamId = int(_loc5_.@teamId);
            _loc6_.gameId = int(_loc5_.@gameId);
            _loc6_.difficulty = int(_loc5_.@difficulty);
            _loc7_.data = _loc6_;
            _loc7_.type = 119;
            _loc7_.text = _loc5_.@name;
            _loc7_.elementFormat = getConsortiaNameFormat();
         }
         else if(_loc4_ == 120)
         {
            _loc7_.data = int(_loc5_.@teamId);
            _loc7_.type = 120;
            _loc7_.text = _loc5_.@name;
            _loc7_.elementFormat = getConsortiaNameFormat();
         }
         else
         {
            if(_loc8_ == 4)
            {
               _loc2_ = new MarryCampaignInfo();
               _loc2_.key = String(_loc5_.@id);
               _loc2_.campaignId = int(_loc5_.@campaignId);
               _loc2_.passWord = String(_loc5_.@position);
               _loc7_.data = _loc2_;
            }
            else
            {
               _loc3_ = new RoomInfo();
               _loc3_.id = int(_loc5_.@id);
               _loc3_.campaignId = int(_loc5_.@campaignId);
               _loc3_.roomType = int(_loc5_.@roomType);
               _loc3_.isLock = int(_loc5_.@position) == 0 ? true : false;
               _loc7_.data = _loc3_;
            }
            _loc7_.type = 8;
            _loc7_.text = _loc5_.@name;
            _loc7_.elementFormat = getConsortiaNameFormat();
         }
         return _loc7_;
      }
      
      public static function createGameHallCellData(param1:String) : ChatCellData
      {
         var _loc3_:XML = new XML(param1);
         var _loc4_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         var _loc5_:int = int(_loc3_.@roomType);
         var _loc2_:RoomInfo = new RoomInfo();
         _loc2_.id = int(_loc3_.@id);
         _loc2_.campaignId = int(_loc3_.@campaignId);
         _loc2_.roomType = int(_loc3_.@roomType);
         _loc2_.isLock = int(_loc3_.@position) == 0 ? true : false;
         _loc4_.data = _loc2_;
         _loc4_.type = 119;
         _loc4_.text = _loc3_.@name;
         _loc4_.elementFormat = getConsortiaNameFormat();
         return _loc4_;
      }
      
      public static function createAppellLinkCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 19;
         _loc3_.text = LanguageMgr.GetTranslation("appell.AppellFrame.AppellLink.LinkText");
         _loc3_.elementFormat = getConsortiaNameFormat();
         _loc3_.data = _loc2_.@appellId;
         return _loc3_;
      }
      
      public static function createRoseBackCellData(param1:String, param2:String, param3:String) : ChatCellData
      {
         var _loc4_:XML = new XML(param1);
         var _loc5_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc5_.type = 20;
         _loc5_.text = LanguageMgr.GetTranslation("chat.utils.ChatFormat.presentBack");
         _loc5_.elementFormat = getConsortiaNameFormat();
         _loc5_.userId = _loc4_.@userId;
         _loc5_.itemId = _loc4_.@templateId;
         _loc5_.nickName = param2;
         _loc5_.receiverName = param3;
         return _loc5_;
      }
      
      public static function createGoldRoadCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 110;
         _loc3_.text = LanguageMgr.GetTranslation("chat.utils.ChatFormat.goldRoadJoin");
         _loc3_.elementFormat = getConsortiaNameFormat();
         return _loc3_;
      }
      
      public static function createCardBackCellData(param1:String, param2:String, param3:String) : ChatCellData
      {
         var _loc4_:XML = new XML(param1);
         var _loc5_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc5_.type = 23;
         _loc5_.text = LanguageMgr.GetTranslation("chat.utils.ChatFormat.cardBack");
         _loc5_.elementFormat = getConsortiaNameFormat();
         _loc5_.nickName = param2;
         _loc5_.receiverName = param3;
         return _loc5_;
      }
      
      public static function createReinforceCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 21;
         _loc3_.text = LanguageMgr.GetTranslation("chat.utils.Chatformat.Reinforce");
         _loc3_.elementFormat = getConsortiaNameFormat();
         _loc3_.userId = _loc2_.@userId;
         _loc3_.data = {
            "userId":_loc2_.@userId,
            "mapId":_loc2_.@mapId,
            "posX":_loc2_.@posX,
            "posY":_loc2_.@posY
         };
         return _loc3_;
      }
      
      public static function createSeekLinkCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 26;
         _loc3_.text = LanguageMgr.GetTranslation("hunt.huntLink.gotoSeek");
         _loc3_.elementFormat = getConsortiaNameFormat();
         _loc3_.userId = _loc2_.@userId;
         _loc3_.data = {
            "userId":_loc2_.@userId,
            "mapId":_loc2_.@mapId,
            "posX":_loc2_.@posX,
            "posY":_loc2_.@posY
         };
         return _loc3_;
      }
      
      public static function createPetBossReinforceCellData(param1:String) : ChatCellData
      {
         var _loc2_:XML = new XML(param1);
         var _loc3_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc3_.type = 22;
         _loc3_.text = LanguageMgr.GetTranslation("chat.utils.Chatformat.Reinforce");
         _loc3_.elementFormat = getConsortiaNameFormat();
         _loc3_.userId = _loc2_.@userId;
         _loc3_.data = {
            "userId":_loc2_.@userId,
            "mapId":_loc2_.@mapId,
            "posX":_loc2_.@posX,
            "posY":_loc2_.@posY
         };
         return _loc3_;
      }
      
      private static function getContentArr(param1:String) : Array
      {
         var _loc7_:int = 0;
         var _loc3_:Array = [];
         _testField = ComponentFactory.Instance.creatComponentByStylename("invite.InviteContent");
         _testField.width = 290;
         _testField.multiline = true;
         _testField.wordWrap = true;
         var _loc4_:ThaneInfo = ArmyManager.instance.thane;
         var _loc5_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc5_.channel = 10;
         _loc5_.uid = _loc4_.userId;
         _loc5_.senderName = _loc4_.nickName;
         _loc5_.appellId = _loc4_.appellId;
         _loc5_.msg = "";
         _loc5_.commit();
         var _loc8_:ExpressionChatNotic = new ExpressionChatNotic();
         _loc8_.data = _loc5_;
         var _loc2_:int = 290 - _loc8_.firstLineWidth;
         if(_loc4_.IsVipAndNoExpirt)
         {
            _loc2_ -= 22;
         }
         if(_loc2_ <= 0)
         {
            _loc2_ = 130;
         }
         var _loc9_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         _loc5_.channel = 10;
         _loc5_.msg = param1;
         _loc5_.commit();
         var _loc6_:ExpressionChatNotic = new ExpressionChatNotic();
         _loc6_.lineWidth = Math.abs(_loc2_);
         _loc6_.data = _loc9_;
         _loc2_ = _loc6_.firstLineWidth;
         _testField.width = _loc2_;
         _testField.text = param1;
         _loc3_.push(transferredApos(_testField.getLineText(0)));
         param1 = param1.replace(_testField.getLineText(0),"");
         _testField.width = 290;
         _testField.text = param1;
         _loc7_ = 0;
         while(_loc7_ < _testField.numLines)
         {
            _loc3_.push(transferredApos(_testField.getLineText(_loc7_)));
            _loc7_++;
         }
         _loc8_.dispose();
         _loc6_.dispose();
         return _loc3_;
      }
      
      private static function transferredApos(param1:String) : String
      {
         return StringHelper.replaceStr(param1,"\'","&apos;");
      }
      
      public static function getContentCellData(param1:ChatData) : Vector.<ChatCellData>
      {
         var _loc2_:String = null;
         var _loc28_:Array = null;
         var _loc22_:ChatCellData = null;
         var _loc30_:int = 0;
         var _loc16_:int = 0;
         var _loc19_:int = 0;
         var _loc25_:int = 0;
         var _loc17_:int = 0;
         var _loc26_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:GameHallGameInfo = null;
         var _loc10_:String = null;
         var _loc14_:String = null;
         var _loc13_:XML = null;
         var _loc3_:String = null;
         var _loc18_:Array = null;
         var _loc8_:Array = null;
         var _loc11_:String = null;
         var _loc4_:Array = null;
         var _loc15_:String = null;
         var _loc21_:Array = null;
         var _loc9_:String = null;
         var _loc31_:int = 0;
         var _loc7_:int = 0;
         var _loc34_:int = 0;
         var _loc12_:int = 0;
         var _loc32_:String = null;
         var _loc33_:Array = null;
         var _loc29_:XML = null;
         var _loc20_:int = 0;
         var _loc23_:Vector.<ChatCellData> = new Vector.<ChatCellData>();
         _loc2_ = param1.msg;
         _loc28_ = _loc2_.match(/\<([^>]*)>*/g);
         if(_loc28_.length > 0)
         {
            if(param1.type == 4)
            {
               _loc10_ = "";
               _loc14_ = "";
               for each(var _loc24_:String in _loc28_)
               {
                  _loc13_ = new XML(_loc24_);
                  _loc30_ = int(_loc13_.@t);
                  if(_loc30_ == 4)
                  {
                     _loc25_ = int(_loc13_.@teamId);
                     _loc17_ = int(_loc13_.@gameId);
                     _loc26_ = int(_loc13_.@difficulty);
                     _loc6_ = int(_loc13_.@teamCount);
                  }
                  else if(_loc30_ == 120)
                  {
                     _loc31_ = int(_loc13_.@teamId);
                     _loc14_ += _loc13_.@name;
                  }
                  else
                  {
                     _loc14_ += _loc13_.@name;
                     _loc19_ = int(_loc13_.@campaignId);
                     _loc16_ = int(_loc13_.@roomType);
                  }
               }
               if(_loc30_ == 4)
               {
                  _loc5_ = new GameHallGameInfo();
                  _loc5_.gameId = _loc17_;
                  _loc5_.difficulty = _loc26_;
                  _loc10_ = _loc5_.templateInfo.GameName;
                  if(_loc17_ == 4)
                  {
                     _loc10_ = _loc10_ + "-" + _loc5_.eastTemplateInfo.TemplateName;
                  }
                  _loc14_ += LanguageMgr.GetTranslation("room.view.invite.QuickInviteFrame.inviteNotice.gamehall",_loc10_,_loc25_,_loc6_);
               }
               else if(_loc30_ != 120)
               {
                  if(!WorldBossHelper.checkTrialTower(_loc19_) && !WorldBossHelper.checkFantasyMatrix(_loc19_))
                  {
                     if(_loc16_ == 0)
                     {
                        if(int(_loc13_.@bossCount) < 0)
                        {
                           _loc3_ = LanguageMgr.GetTranslation("yishi.manager.BaseManager.remainbossnum2");
                        }
                        else
                        {
                           _loc3_ = LanguageMgr.GetTranslation("yishi.manager.BaseManager.remainbossnum",_loc13_.@bossCount);
                        }
                        _loc3_ = " " + LanguageMgr.GetTranslation("public.parentheses1",_loc3_);
                        _loc14_ += _loc3_;
                     }
                  }
               }
               _loc18_ = getContentArr(_loc14_);
               _loc8_ = [];
               for each(var _loc27_:String in _loc18_)
               {
                  _loc13_.@name = _loc27_;
                  _loc8_.push(_loc13_.toXMLString());
               }
               _loc28_ = _loc8_;
               _loc23_ = _loc23_.concat(createExtraChatCellByContent(_loc28_,param1));
            }
            else if(param1.type == 6)
            {
               _loc4_ = [];
               _loc21_ = [];
               _loc33_ = [];
               _loc29_ = new XML(_loc28_[0]);
               _loc7_ = int(_loc29_.@type);
               _loc11_ = getGodsEveningNotice(_loc29_,1);
               _loc4_ = _loc11_.split("|");
               _loc20_ = 0;
               while(_loc20_ < _loc4_.length)
               {
                  _loc15_ = _loc4_[_loc20_];
                  _loc21_ = _loc15_.split(":");
                  if(_loc21_.length > 1)
                  {
                     _loc9_ = String(_loc21_[0]);
                     _loc31_ = int(_loc21_[1]);
                     _loc22_ = creatGodsEveningCellData(_loc9_,_loc31_);
                     _loc23_.push(_loc22_);
                  }
                  else
                  {
                     _loc9_ = String(_loc21_[0]);
                     _loc22_ = createGeneralCellData(_loc9_,param1.channel);
                     _loc23_.push(_loc22_);
                  }
                  _loc20_++;
               }
               if(_loc7_ == 5)
               {
                  _loc34_ = int(_loc29_.@position);
                  _loc12_ = int(_loc29_.@team_a);
                  _loc32_ = _loc29_.@serverName_a;
                  _loc22_ = creatGodsEveningGotoCellData({
                     "armyId":_loc34_,
                     "serverName":_loc32_
                  },_loc12_);
                  _loc23_.push(_loc22_);
               }
            }
            else
            {
               _loc23_ = _loc23_.concat(createExtraChatCellByContent(_loc28_,param1));
            }
         }
         else if(param1.type == 2)
         {
            _loc22_ = createConsortiaCellData(param1.consortiaId,param1.consortiaName);
            _loc23_.push(_loc22_);
            _loc22_ = createGeneralCellData(param1.msg,param1.channel);
            _loc23_.push(_loc22_);
         }
         else
         {
            _loc22_ = createGeneralCellData(param1.msg,param1.channel);
            _loc23_.push(_loc22_);
         }
         return _loc23_;
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
      
      public static function createChannelCellLinkData(param1:String) : ChatCellData
      {
         var _loc2_:ChatCellData = ObjectPool.getObject(ChatCellData) as ChatCellData;
         _loc2_.type = 25;
         _loc2_.text = LanguageMgr.GetTranslation("appell.AppellFrame.AppellLink.LinkText");
         _loc2_.elementFormat = getConsortiaNameFormat();
         _loc2_.data = param1;
         return _loc2_;
      }
      
      public static function createSpeakerCellData(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int, param7:int, param8:String, param9:int, param10:String = "") : Vector.<ChatCellData>
      {
         var _loc11_:ChatCellData = null;
         var _loc13_:AppellInfoTemplate = null;
         var _loc12_:Vector.<ChatCellData> = new Vector.<ChatCellData>();
         if(param8)
         {
            if(param2 == 2)
            {
               _loc11_ = createGMCellData(param1);
               _loc12_.push(_loc11_);
               _loc11_ = createGeneralCellData(" ",param1);
               _loc12_.push(_loc11_);
            }
            else if(param2 == 6)
            {
               _loc11_ = createGuiderCellData(param1);
               _loc12_.push(_loc11_);
               _loc11_ = createGeneralCellData(" ",param1);
               _loc12_.push(_loc11_);
            }
            else if(VersionSwitch.APPELL && param9 != 0)
            {
               _loc13_ = FrameControllerManager.instance.appellControler.model.getAppellInfo(param9);
               if(_loc13_.Perfix != "")
               {
                  _loc11_ = createAppellCellData(param1,param9);
                  _loc12_.push(_loc11_);
               }
            }
            _loc11_ = createGeneralCellData("[",param1);
            _loc12_.push(_loc11_);
            if(param4 > 0)
            {
               _loc11_ = createVipCellData(param1);
               _loc12_.push(_loc11_);
            }
            _loc11_ = createPlayerCellData(param1,param2,param5,param3,param4,param6,param7,param8,param10);
            _loc12_.push(_loc11_);
            _loc11_ = createGeneralCellData(LanguageMgr.GetTranslation("public.colon","]"),param1);
            _loc12_.push(_loc11_);
         }
         return _loc12_;
      }
      
      public static function getGodsEveningTextFormat(param1:int) : ElementFormat
      {
         var _loc3_:FontDescription = new FontDescription();
         _loc3_.fontName = "Arial";
         var _loc2_:ElementFormat = new ElementFormat();
         _loc2_.breakOpportunity = "none";
         _loc2_.alignmentBaseline = "ideographicCenter";
         _loc2_.dominantBaseline = "ideographicCenter";
         _loc2_.baselineShift = 2;
         _loc2_.fontDescription = _loc3_;
         _loc2_.trackingRight = 1;
         switch(param1 - 1)
         {
            case 0:
               _loc2_.color = 16711684;
               break;
            case 1:
               _loc2_.color = 55551;
               break;
            case 2:
               _loc2_.color = 12249088;
         }
         return _loc2_;
      }
      
      public static function getConsortiaNameFormat() : ElementFormat
      {
         if(formatDic["consortianameformat"])
         {
            return formatDic["consortianameformat"] as ElementFormat;
         }
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
         formatDic["consortianameformat"] = _loc1_;
         return formatDic["consortianameformat"] as ElementFormat;
      }
      
      public static function getProfileFormat(param1:int) : ElementFormat
      {
         var _loc3_:String = StringUtil.substitute(link2style,"profileformat",param1);
         if(formatDic[_loc3_])
         {
            return formatDic[_loc3_] as ElementFormat;
         }
         var _loc4_:FontDescription = new FontDescription();
         _loc4_.fontName = "Arial";
         var _loc2_:ElementFormat = new ElementFormat();
         _loc2_.breakOpportunity = "none";
         _loc2_.alignmentBaseline = "ideographicCenter";
         _loc2_.dominantBaseline = "ideographicCenter";
         _loc2_.baselineShift = 0;
         _loc2_.fontDescription = _loc4_;
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
               break;
            case 6:
               _loc2_.color = 13504271;
               break;
            case 7:
               _loc2_.color = 16744448;
         }
         formatDic[_loc3_] = _loc2_;
         return formatDic[_loc3_] as ElementFormat;
      }
      
      public static function getFiveProfileFormat(param1:int) : ElementFormat
      {
         var _loc3_:String = StringUtil.substitute(link2style,"profileformat",param1);
         if(formatDic[_loc3_])
         {
            return formatDic[_loc3_] as ElementFormat;
         }
         var _loc4_:FontDescription = new FontDescription();
         _loc4_.fontName = "Arial";
         var _loc2_:ElementFormat = new ElementFormat();
         _loc2_.breakOpportunity = "none";
         _loc2_.alignmentBaseline = "ideographicCenter";
         _loc2_.dominantBaseline = "ideographicCenter";
         _loc2_.baselineShift = 0;
         _loc2_.fontDescription = _loc4_;
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
               _loc2_.color = 16044041;
               break;
            case 6:
               _loc2_.color = 13504271;
         }
         formatDic[_loc3_] = _loc2_;
         return formatDic[_loc3_] as ElementFormat;
      }
      
      public static function getNameFormat(param1:int, param2:int, param3:int) : ElementFormat
      {
         var _loc5_:String = StringUtil.substitute(link3style,"nameformat",param1,param3);
         if(formatDic[_loc5_])
         {
            return formatDic[_loc5_] as ElementFormat;
         }
         var _loc6_:FontDescription = new FontDescription();
         _loc6_.fontName = "Arial";
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
         _loc4_.fontDescription = _loc6_;
         _loc4_.trackingRight = 1;
         formatDic[_loc5_] = _loc4_;
         return formatDic[_loc5_] as ElementFormat;
      }
      
      public static function getChannelFormat(param1:int) : ElementFormat
      {
         var _loc3_:String = StringUtil.substitute(link2style,"channelformat",param1);
         if(formatDic[_loc3_])
         {
            return formatDic[_loc3_] as ElementFormat;
         }
         var _loc4_:FontDescription = new FontDescription();
         _loc4_.fontName = "Arial";
         var _loc2_:ElementFormat = new ElementFormat();
         _loc2_.breakOpportunity = "none";
         _loc2_.alignmentBaseline = "ideographicCenter";
         _loc2_.dominantBaseline = "ideographicCenter";
         _loc2_.color = getContentColor(param1);
         _loc2_.baselineShift = 0;
         _loc2_.fontDescription = _loc4_;
         _loc2_.trackingRight = 0;
         formatDic[_loc3_] = _loc2_;
         return formatDic[_loc3_] as ElementFormat;
      }
      
      public static function getUserTypeFormat(param1:int) : ElementFormat
      {
         var _loc3_:String = StringUtil.substitute(link2style,"usertypeformat",param1);
         if(formatDic[_loc3_])
         {
            return formatDic[_loc3_] as ElementFormat;
         }
         var _loc4_:FontDescription = new FontDescription();
         _loc4_.fontName = "Arial";
         var _loc2_:ElementFormat = new ElementFormat();
         _loc2_.breakOpportunity = "none";
         _loc2_.alignmentBaseline = "ideographicCenter";
         _loc2_.dominantBaseline = "ideographicCenter";
         _loc2_.color = getContentColor(param1);
         _loc2_.baselineShift = 1;
         _loc2_.fontDescription = _loc4_;
         _loc2_.trackingRight = 0;
         formatDic[_loc3_] = _loc2_;
         return formatDic[_loc3_] as ElementFormat;
      }
      
      public static function getGenralFormat(param1:int) : ElementFormat
      {
         var _loc3_:String = StringUtil.substitute(link2style,"genralformat",param1);
         if(formatDic[_loc3_])
         {
            return formatDic[_loc3_] as ElementFormat;
         }
         var _loc4_:FontDescription = new FontDescription();
         _loc4_.fontName = "Arial";
         var _loc2_:ElementFormat = new ElementFormat();
         _loc2_.breakOpportunity = "none";
         _loc2_.alignmentBaseline = "ideographicCenter";
         _loc2_.dominantBaseline = "ideographicCenter";
         _loc2_.color = getContentColor(param1);
         _loc2_.baselineShift = 2;
         _loc2_.fontDescription = _loc4_;
         _loc2_.trackingRight = 1;
         formatDic[_loc3_] = _loc2_;
         return formatDic[_loc3_] as ElementFormat;
      }
      
      public static function getContentColor(param1:int) : int
      {
         switch(param1)
         {
            case 13:
            case 15:
               break;
            case 1:
               return 55551;
            case 10:
               return 15439108;
            case 109:
               return 15439108;
            case 2:
            case 11:
               return 16774656;
            case 3:
               return 16774656;
            case 5:
               return 5035345;
            case 6:
               return 9674239;
            case 8:
               return 16777215;
            case 12:
               return 15940607;
            case 103:
               return 12822925;
            case 104:
               return 6567940;
            case 105:
               return 16777215;
            case 106:
               return 2960685;
            case 14:
               return 16746889;
            case 107:
               return 16572072;
            case 108:
               return 65490;
            default:
               return 16777215;
         }
         return 16773121;
      }
      
      public static function getElementVector() : Vector.<ContentElement>
      {
         if(_elementVec.length > 0)
         {
            return _elementVec.pop();
         }
         var _loc1_:Vector.<ContentElement> = new Vector.<ContentElement>();
         index = index + 1;
         return _loc1_;
      }
      
      public static function recycleElementVector(param1:Vector.<ContentElement>) : void
      {
         if(param1)
         {
            param1.length = 0;
            _elementVec.push(param1);
         }
      }
      
      public static function disposeGroupElement(param1:ContentElement) : void
      {
         if(param1)
         {
            if(param1 is GroupElement)
            {
               _ge = param1 as GroupElement;
               if(_ge)
               {
                  _cel = _ge.elementCount;
                  _cei = 0;
                  while(_cei < _cel)
                  {
                     disposeGroupElement(_ge.getElementAt(_cei));
                     _cei = _cei + 1;
                  }
                  _ge.setElements(null);
                  _ge = null;
               }
            }
            else if(param1 is GraphicElement)
            {
               _gelment = param1 as GraphicElement;
               if(_gelment)
               {
                  _dis = _gelment.graphic;
                  if(_dis is MovieClip)
                  {
                     ObjectUtils.disposeViolentMc(_dis as MovieClip);
                  }
                  else if(_dis is Sprite)
                  {
                     ObjectUtils.disposeAllChildren(_dis as Sprite);
                     ObjectUtils.disposeObject(_dis);
                  }
                  else
                  {
                     ObjectUtils.disposeObject(_dis);
                  }
                  _dis = null;
                  _gelment.userData = null;
                  _gelment = null;
               }
            }
            else if(param1 is TextElement)
            {
               (param1 as TextElement).userData = null;
            }
         }
      }
      
      public static function clearTextLine(param1:TextBlock) : void
      {
         var _loc2_:ContentElement = null;
         if(!param1)
         {
            return;
         }
         param1.releaseLineCreationData();
         _loc2_ = param1.content;
         param1.content = null;
         ChatFormat.disposeGroupElement(_loc2_);
      }
      
      public static function getCorlorByType(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "#ff0004";
            case 1:
               return "#00d8ff";
            case 2:
               return "#bae800";
            default:
               return "0xffffff";
         }
      }
      
      public static function getGodsEveningNotice(param1:XML, param2:int) : String
      {
         var _loc6_:int = 0;
         var _loc3_:String = null;
         var _loc13_:int = 0;
         var _loc4_:String = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc17_:String = null;
         var _loc9_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:String = null;
         var _loc11_:String = null;
         var _loc8_:String = null;
         var _loc10_:String = null;
         var _loc12_:String = null;
         var _loc14_:XML = new XML(param1);
         _loc6_ = int(_loc14_.@type);
         _loc13_ = int(_loc14_.@team_a);
         _loc3_ = LanguageMgr.GetTranslation("godsEvening.chatData.team" + _loc13_);
         _loc15_ = int(_loc14_.@team_b);
         _loc16_ = int(_loc14_.@newTimeId);
         if(_loc16_ != 0)
         {
            _loc4_ = LanguageMgr.GetTranslation("godsEvening.chatData.team" + _loc16_);
         }
         else
         {
            _loc4_ = LanguageMgr.GetTranslation("godsEvening.chatData.team" + _loc15_);
         }
         if(_loc16_ != 0)
         {
            _loc15_ = _loc16_;
         }
         _loc5_ = _loc14_.@nickName_a;
         _loc7_ = _loc14_.@nickName_b;
         _loc17_ = _loc14_.@text;
         _loc9_ = int(_loc14_.@score);
         _loc18_ = int(_loc14_.@position);
         if(param2 == 1)
         {
            _loc8_ = "godsEvening.chatData.notice" + _loc6_;
            if(_loc6_ == 1)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc13_,_loc5_,_loc13_,_loc17_,_loc9_);
            }
            else if(_loc6_ == 2)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc13_,_loc5_,_loc13_,_loc4_,_loc15_,_loc7_,_loc15_,_loc9_);
            }
            else if(_loc6_ == 3)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc13_,_loc5_,_loc13_,_loc4_,_loc15_,_loc4_,_loc15_);
            }
            else if(_loc6_ == 4)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc13_,_loc3_,_loc13_);
            }
            else if(_loc6_ == 5)
            {
               if(_loc13_ == GodsEveningManager.instance.model.teamId)
               {
                  _loc11_ = LanguageMgr.GetTranslation(_loc8_ + "_2",_loc3_,_loc13_,_loc5_,_loc13_,_loc4_,_loc15_);
               }
               else
               {
                  _loc11_ = LanguageMgr.GetTranslation(_loc8_ + "_1",_loc3_,_loc13_,_loc5_,_loc13_,_loc4_,_loc15_);
               }
            }
            else if(_loc6_ == 6)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc13_,_loc5_,_loc13_,_loc4_,_loc15_);
            }
            else if(_loc6_ == 7)
            {
               _loc19_ = LanguageMgr.GetTranslation("godsEvening.chatData.team" + _loc15_);
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc13_,_loc5_,_loc13_,_loc4_,_loc15_,_loc3_,_loc13_,_loc19_,_loc15_);
            }
            else if(_loc6_ == 8)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc13_,_loc5_,_loc13_,_loc4_,_loc15_,_loc4_,_loc15_);
            }
            else if(_loc6_ == 9)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc13_,_loc5_,_loc13_,_loc15_,5 * _loc15_);
            }
         }
         else
         {
            _loc8_ = "godsEvening.mseeageTip.notice" + _loc6_;
            _loc10_ = getCorlorByType(_loc13_);
            _loc12_ = getCorlorByType(_loc15_);
            if(_loc6_ == 1)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc10_,_loc5_,_loc10_,_loc17_,_loc9_);
            }
            else if(_loc6_ == 2)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc10_,_loc5_,_loc10_,_loc4_,_loc12_,_loc7_,_loc12_);
            }
            else if(_loc6_ == 3)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc10_,_loc5_,_loc10_,_loc4_,_loc12_,_loc4_,_loc12_);
            }
            else if(_loc6_ == 4)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc10_);
            }
            else if(_loc6_ == 5)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc10_,_loc5_,_loc10_,_loc4_,_loc12_);
            }
            else if(_loc6_ == 6)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc10_,_loc5_,_loc10_,_loc4_,_loc12_);
            }
            else if(_loc6_ == 7)
            {
               _loc19_ = LanguageMgr.GetTranslation("godsEvening.chatData.team" + _loc15_);
               _loc12_ = getCorlorByType(_loc15_);
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc10_,_loc5_,_loc10_,_loc19_,_loc12_);
            }
            else if(_loc6_ == 8)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc10_,_loc5_,_loc10_,_loc4_,_loc12_,_loc4_,_loc12_);
            }
            else if(_loc6_ == 9)
            {
               _loc11_ = LanguageMgr.GetTranslation(_loc8_,_loc3_,_loc10_,_loc5_,_loc10_);
            }
         }
         return _loc11_;
      }
   }
}

