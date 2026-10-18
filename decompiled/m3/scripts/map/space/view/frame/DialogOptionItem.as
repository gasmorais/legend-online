package map.space.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RingTaskEvent;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.FashionManager;
   import managers.FreedomTeamManager;
   import managers.MarryManager;
   import managers.MonopolySocketOutManager;
   import managers.RapidThroughPassManager;
   import managers.RemotePetManager;
   import managers.RingTaskManager;
   import managers.SkyboxRoadManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.view.ui.molong.MolongSocketOut;
   import map.internals.data.SpaceNode;
   import map.space.helper.hero.SpaceArmyViewHelper;
   import map.space.manager.SpaceSocketOutManager;
   import mvc.controler.PlaneCrisisController;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import sandbox.SandboxManager;
   import yishi.SwitchPageHelp;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.BirthdayManager;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class DialogOptionItem extends Sprite implements Disposeable
   {
      
      public static const VEHICLE:int = 4;
      
      public static const STORY_TASK:int = 7;
      
      public static const PET_PVP:int = 9;
      
      public static const RING_TASK:int = 11;
      
      public static const START_OFF:int = 12;
      
      public static const TREASURE_MAP:int = 13;
      
      public static const SINGLE_PASS:int = 14;
      
      public static const TRANSFER:int = 15;
      
      public static const MOLONG:int = 16;
      
      public static const MARRY_QUALITY:int = 17;
      
      public static const ENTER_WEDDING:int = 19;
      
      public static const MARRY_DIVORCE:int = 20;
      
      public static const ACCEPT_MARRY_TASK:int = 21;
      
      public static const HOOK:int = 22;
      
      public static const RIDE_MARRY_CAR:int = 23;
      
      public static const HEART_QUESTION:int = 25;
      
      public static const MONOPOLY:int = 26;
      
      public static const CHILD:int = 27;
      
      public static const CHILD_HAND_IN:int = 29;
      
      public static const LIFESKILL:int = 33;
      
      public static const BIRTHDAY_WISH:int = 36;
      
      public static const BIRTHDAY_ACTIVITY:int = 37;
      
      public static const BIRTHDAY_REWARD:int = 38;
      
      public static const MARRY_PROPOSE:int = 90;
      
      public static const MARRY_DIVORCE3:int = 91;
      
      public static const MARRY_DIVORCE1:int = 92;
      
      public static const MARRY_DIVORCE2:int = 93;
      
      public static const OPEN_BAG:int = 94;
      
      public static const GO_NOW:int = 95;
      
      public static const MARRY_TASK_COMPONENT:int = 96;
      
      public static const MARRY_TASK:int = 97;
      
      public static const COMPONENT_TASK:int = 98;
      
      public static const LEAVE:int = 99;
      
      public static const OUTERCITYSHOP:int = 100;
      
      public static const REMOTEPET:int = 101;
      
      public static const CHILDPVE:int = 102;
      
      public static const CHILDARENA:int = 103;
      
      public static const CHANGE_JOB:int = 104;
      
      public static const CHILD_PATROL:int = 105;
      
      public static const HOLIDAY_CAMPAIGN_ENTER:int = 106;
      
      public static const HOLIDAY_GOODS_EXCHANGE:int = 107;
      
      public static const GLORY_ROAD:int = 108;
      
      public static const RAPID_THROUGH:int = 109;
      
      public static const RAPID_RANK:int = 110;
      
      public static const GAME_BOX:int = 111;
      
      public static const ALCHEMICAL:int = 112;
      
      public static const CHILD_ESAL:int = 113;
      
      public static const FASHION_BOX:int = 114;
      
      public static const MOUNT_BOX:int = 115;
      
      public static const LORD_TRIAL:int = 117;
      
      public static const TITAN_TEMPLE:int = 118;
      
      public static const SHUTTLE:int = 119;
      
      public static const ABYSM:int = 130;
      
      public static const TIMEVORTEX:int = 131;
      
      public static const PLANE_CRISIS:int = 132;
      
      public static const ECLIPTIC_PALACE:int = 133;
      
      public static const DEMON_LAND:int = 134;
      
      public static const GAME_HALL:int = 135;
      
      public static const MONSTER_EXPLORE:int = 136;
      
      public static const PERSONAL_PARTY:int = 137;
      
      public static const CREATE_PARTY:int = 138;
      
      public static const JOIN_PARTY:int = 139;
      
      public static const PARTY_SHOP:int = 140;
      
      public static const PARTY_UP:int = 141;
      
      public static const GAME_LLK:int = 142;
      
      public static const GAME_MEMORY:int = 143;
      
      public static const GAME_POKER:int = 144;
      
      public static const REVENGE_ROAD:int = 145;
      
      public static const AVENGER_TASK:int = 146;
      
      public static const REDEMPTION_ROAD:int = 147;
      
      public static const HELL_ABYSM:int = 148;
      
      public static const INCREASINGLY_ROAD:int = 149;
      
      public static const SPIRIT_EXPEDITION:int = 150;
      
      public static const YL_EXPEDITION:int = 151;
      
      public static const SHADOW_LAND:int = 152;
      
      public static const DARK_MAZE_SHOP:int = 153;
      
      public static const HOLY_TASK:int = 154;
      
      public static const REMAINS_EXPLORE:int = 155;
      
      public static const ROYALTY_BOSS:int = 156;
      
      public static const POSEIDON_SHOP:int = 157;
      
      public static const FORBIDDEN_BOSS:int = 158;
      
      public static const SECRET_EXPLOR:int = 159;
      
      public static const WARSOULTOWER:int = 160;
      
      public static const FINALROAD:int = 161;
      
      public static const GOD_PVP:int = 162;
      
      public static const CHILD_NS_WAR:int = 163;
      
      public static const THESS_TOWER:int = 165;
      
      public static const THESS_BOX:int = 166;
      
      public static const DUNGEONEXPLO:int = 167;
      
      private var _selectedBg:Bitmap;
      
      private var _icon:Bitmap;
      
      private var _option:FilterFrameText;
      
      private var _type:int;
      
      private var _title:String;
      
      private var _level:int;
      
      private var _param:int;
      
      private var _showNext1:Boolean;
      
      private var _showNext2:Boolean;
      
      private var _nextStep:Function;
      
      private var _nextStepParam:Object;
      
      private var _format:TextFormat;
      
      private var _format_2:TextFormat;
      
      private var _nodeInfo:SpaceNode;
      
      public function DialogOptionItem(param1:int, param2:String, param3:int = 0, param4:int = 0, param5:Function = null, param6:Object = null)
      {
         super();
         _format = ComponentFactory.Instance.model.getSet("map.space.SpaceDialogFrame.OptionItem_t3");
         _format_2 = ComponentFactory.Instance.model.getSet("map.space.SpaceDialogFrame.OptionItem_t4");
         _type = param1;
         _title = StringHelper.trimLeft(param2);
         _level = param3;
         _param = param4;
         _nextStep = param5;
         _nextStepParam = param6;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         buttonMode = true;
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.space.SpaceDialogFrame.SelectedBg");
         _icon = ComponentFactory.Instance.creatBitmap("asset.space.SpaceDialogFrame.Arrow");
         _option = ComponentFactory.Instance.creatComponentByStylename("map.space.DialogOptionItem.TitleText");
         addChild(_selectedBg);
         addChild(_icon);
         addChild(_option);
         _selectedBg.visible = false;
         _option.text = _title;
         if(_type == 13)
         {
            _loc1_ = _title.indexOf(LanguageMgr.GetTranslation("ui.tasktracebar.view.DialogOptionItem.index2"));
            _loc2_ = _title.indexOf(")");
            _option.setTextFormat(_format,_loc1_ + 9,_loc2_);
         }
         createHitArea();
      }
      
      private function createHitArea() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.clear();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,394,24);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__optionBtnClickHandler);
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
         RingTaskManager.instance.addEventListener("ADDRINGTASK",__showTalkNext1);
         MsgMan.addObserver("MarryEventType.TASK_UPDATE",this,__showTalkNext2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__optionBtnClickHandler);
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
         RingTaskManager.instance.removeEventListener("ADDRINGTASK",__showTalkNext1);
         MsgMan.removeObserver("MarryEventType.TASK_UPDATE",this,__showTalkNext2);
      }
      
      private function __optionBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc13_:BaseArmy = null;
         var _loc12_:DivorceAlert = null;
         var _loc9_:DivorceAlert = null;
         var _loc7_:DivorceAlert = null;
         var _loc8_:String = null;
         var _loc2_:String = null;
         var _loc11_:String = null;
         var _loc6_:String = null;
         var _loc10_:String = null;
         SoundManager.instance.play("022");
         if(_level > ArmyManager.instance.thane.grades)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("store.view.StoreFrame.command01",_level));
            return;
         }
         switch(_type)
         {
            case 1:
            case 2:
            case 3:
            case 5:
            case 8:
            case 10:
            case 9:
            case 13:
               SpaceArmyViewHelper.openNodeFrame(_type);
               break;
            case 4:
               if(ArmyManager.instance.thane.grades < 13)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command01"));
               }
               else
               {
                  SandboxManager.instance.requestState();
               }
               break;
            case 22:
               FrameControllerManager.instance.openControllerByInfo("hook");
               break;
            case 14:
               SkyboxRoadManager.instance.getData();
               break;
            case 149:
               SwitchPageHelp.openIncreasinglyRoad();
               break;
            case 6:
               SocketSendManager.instance.enterPetLand(_param);
               break;
            case 7:
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
               break;
            case 11:
               if(ArmyManager.instance.thane.grades >= 35)
               {
                  _showNext1 = true;
                  if(_param == 17)
                  {
                     RingTaskManager.instance.accessRingTask();
                  }
                  else
                  {
                     _nextStep(_nextStepParam);
                  }
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.Level"));
               }
               break;
            case 12:
               if(this.parent.parent.parent is Frame)
               {
                  Frame(this.parent.parent.parent).dispose();
               }
               SwitchPageHelp.skipPageByTaskCondictionType(RingTaskManager.instance.getRingTask(),null);
               break;
            case 98:
               if(this.parent.parent.parent is Frame)
               {
                  Frame(this.parent.parent.parent).dispose();
               }
               NotificationManager.instance.dispatchEvent(new NotificationEvent("TALKRINGTASK_COMPLETE"));
               break;
            case 15:
               if(this.parent.parent.parent is Frame)
               {
                  Frame(this.parent.parent.parent).dispose();
               }
               PlayerManager.instance.sendDragonSoulTransfer();
               break;
            case 16:
               MolongSocketOut.clickMolongMap();
               break;
            case 17:
               MarryManager.instance.creatQualitySelectFrame();
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
               break;
            case 90:
               if(FreedomTeamManager.instance.model == null || FreedomTeamManager.instance.model.allMembers.length > 2)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.propose.overLimit"));
                  return;
               }
               if(FreedomTeamManager.instance.model.captainId != PlayerManager.instance.currentPlayerModel.playerInfo.userId)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.propose.onlyCaptain"));
                  return;
               }
               _loc3_ = FreedomTeamManager.instance.model.allMembers;
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc13_ = _loc3_[_loc4_] as BaseArmy;
                  if(_loc13_.baseHero.userId != playerModel.userInfo.userId)
                  {
                     _loc5_ = int(_loc13_.baseHero.userId);
                  }
                  _loc4_++;
               }
               MarryManager.instance.creatProposeQuestFrame(_loc5_);
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
               break;
            case 19:
               MarryManager.instance.creatRoomListFrame();
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
               break;
            case 20:
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
               break;
            case 92:
               if(marryModel.isMarry)
               {
                  _loc12_ = ComponentFactory.Instance.creatComponentByStylename("Divorce.SimpleAlert",[92]);
                  _loc12_.backCall = divorceHandler;
                  LayerManager.Instance.addToLayer(_loc12_,3,true,true,1);
               }
               else if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
                  if(marryModel.isSingle)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.quality.MarryConfirmFrame.noLover"));
                  }
               }
               break;
            case 93:
               if(marryModel.isMarry)
               {
                  if(FreedomTeamManager.instance.model == null)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.needTeam2"));
                  }
                  else if(FreedomTeamManager.instance.model.captainId != PlayerManager.instance.currentPlayerModel.playerInfo.userId)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.onlyForCaptain2"));
                  }
                  else
                  {
                     _loc9_ = ComponentFactory.Instance.creatComponentByStylename("Divorce.SimpleAlert",[93]);
                     _loc9_.backCall = divorceHandler;
                     LayerManager.Instance.addToLayer(_loc9_,3,true,true,1);
                  }
               }
               else if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
                  if(marryModel.isSingle)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.quality.MarryConfirmFrame.noLover"));
                  }
               }
               break;
            case 91:
               if(marryModel.isMarry)
               {
                  _loc7_ = ComponentFactory.Instance.creatComponentByStylename("Divorce.SimpleAlert",[91]);
                  _loc7_.backCall = divorceHandler;
                  LayerManager.Instance.addToLayer(_loc7_,3,true,true,1);
               }
               else if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
                  if(marryModel.isSingle)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.quality.MarryConfirmFrame.noLover"));
                  }
               }
               break;
            case 21:
               if(marryModel.isMarry)
               {
                  _showNext2 = true;
                  MarrySender.opMarryTask(2001);
               }
               break;
            case 97:
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
               break;
            case 96:
               MarrySender.opMarryTask(2005);
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
               break;
            case 25:
               if(FreedomTeamManager.instance.model == null)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.needTeam"));
               }
               else if(FreedomTeamManager.instance.model.captainId != PlayerManager.instance.currentPlayerModel.playerInfo.userId)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.onlyForCaptain"));
                  if(_nextStep != null)
                  {
                     _nextStep(_nextStepParam);
                  }
               }
               else
               {
                  SimpleAlertHelper.instance.data = [heartCallback];
                  _loc8_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc2_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc11_ = LanguageMgr.GetTranslation("marry.income.MarryHeartFrame.titleText");
                  _loc6_ = LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.heartTipContent");
                  SimpleAlertHelper.instance.popAlerFrame(_loc11_,_loc6_,_loc8_,_loc2_,false,true,true);
               }
               break;
            case 23:
               MarrySender.rideHorse();
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
               break;
            case 94:
               if(FashionManager.instance.fashionIdentityProgress <= 0)
               {
                  SharedManager.instance.fashionIdentityProgress = 1;
               }
               FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL);
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
               break;
            case 95:
               if(marryModel.getMarryTask())
               {
                  SwitchPageHelp.skipPageByTaskCondictionType(marryModel.getMarryTask());
               }
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
               break;
            case 26:
               MonopolySocketOutManager.sendEnterCampaign();
               break;
            case 33:
               if(ArmyManager.instance.thane.grades < 35)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.sapce.view.frame.DialogOptionItem.lifeskillTips"));
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("store","SKILL");
               break;
            case 27:
               ChildManager.instance.checkForExchangeChild();
               break;
            case 29:
               if(ChildManager.instance.model.childList.length <= 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
               }
               else
               {
                  ChildManager.instance.openHandInFrame();
               }
               break;
            case 100:
               if(ArmyManager.instance.thane.grades < 26)
               {
                  _loc10_ = LanguageMgr.GetTranslation("auction.view.supermarket.MysteryShopView.gradesTipData");
                  MessageTipManager.instance().show(_loc10_);
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("outercityshop");
               break;
            case 36:
            case 37:
            case 38:
               birthdayItemsHandler(_type);
               break;
            case 101:
               if(ArmyManager.instance.thane.grades < 50)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.sapce.view.frame.DialogOptionItem.remotePetTips"));
                  return;
               }
               if(PlayerManager.instance.currentPlayerModel.sysCurtime.getHours() < 1 || PlayerManager.instance.currentPlayerModel.sysCurtime.getHours() >= 23)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.sapce.view.frame.DialogOptionItem.remotePetTips2"));
                  return;
               }
               if(RemotePetManager.instance.model.isFrist)
               {
                  FrameControllerManager.instance.remotePetController.startFrameByType(1);
               }
               else
               {
                  FrameControllerManager.instance.remotePetController.startFrameByType(2);
               }
               break;
            case 102:
               if(ArmyManager.instance.thane.grades < 70)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.sapce.view.frame.DialogOptionItem.childpveTips"));
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("childpve");
               break;
            case 103:
               SwitchPageHelp.gotoChildArenaFrame();
               break;
            case 104:
               FrameControllerManager.instance.openControllerByInfo("changejob");
               break;
            case 105:
               if(ArmyManager.instance.thane.grades < 70)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.sapce.view.frame.DialogOptionItem.childArenaTips"));
                  return;
               }
               if(ChildManager.instance.model.childList.length <= 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
                  return;
               }
               if(!SwitchPageHelp.checkScene())
               {
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("childpatrol",1);
               break;
            case 106:
               if(!ConfigManager.info.NEW_YEAR_MODULE || !ConfigManager.info.NEW_YEAR_BEGIN_DATE || !ConfigManager.info.NEW_YEAR_END_DATE || ConfigManager.info.NEW_YEAR_BEGIN_DATE.time > playerModel.nowDate || ConfigManager.info.NEW_YEAR_END_DATE.time <= playerModel.nowDate)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.data.ConsortiaDemonInfo.unopenTip"));
                  return;
               }
               if(!SwitchPageHelp.checkScene())
               {
                  return;
               }
               CampaignSocketOutManager.instance.sendEnterActiveVehicle();
               break;
            case 107:
               if(!ConfigManager.info.NEW_YEAR_MODULE || !ConfigManager.info.NEW_YEAR_BEGIN_DATE || !ConfigManager.info.NEW_YEAR_END_DATE || ConfigManager.info.NEW_YEAR_BEGIN_DATE.time > playerModel.nowDate || ConfigManager.info.NEW_YEAR_END_DATE.time <= playerModel.nowDate)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.data.ConsortiaDemonInfo.unopenTip"));
                  return;
               }
               if(!checkGoodsCount())
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("DialogOptionItem.exchage.goodsNot.text"));
                  return;
               }
               SpaceSocketOutManager.instance.sendHolidayExchange(nodeInfo.nodeId,_param);
               break;
            case 108:
               if(ArmyManager.instance.thane.grades < 15)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("DialogOptionItem.gloryroad.grade.text",15));
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("gloryroad");
               break;
            case 109:
               if(ArmyManager.instance.thane.grades < 36)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("DialogOptionItem.gloryroad.grade.text",36));
                  return;
               }
               if(!SwitchPageHelp.checkScene())
               {
                  return;
               }
               RapidThroughPassManager.instance.requestEnterRapidPass();
               break;
            case 110:
               if(ArmyManager.instance.thane.grades < 36)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("DialogOptionItem.gloryroad.grade.text",36));
                  return;
               }
               SoundManager.instance.play("015",true);
               FrameControllerManager.instance.openControllerByInfo("rapidthrough",1);
               break;
            case 111:
               SoundManager.instance.play("015",true);
               if(ArmyManager.instance.thane.grades < 28)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("DialogOptionItem.gloryroad.grade.text",28));
                  return;
               }
               FrameControllerManager.instance.openControllerByInfo("gamebox");
               break;
            case 112:
               SwitchPageHelp.openAlchemicalFrame();
               break;
            case 113:
               SwitchPageHelp.openChildEsalFrame();
               break;
            case 114:
               SwitchPageHelp.openFashionBoxFrame();
               break;
            case 115:
               SwitchPageHelp.openMountBoxFrame();
               break;
            case 117:
               SwitchPageHelp.openLordTrailFrame();
               break;
            case 118:
               SwitchPageHelp.openTitanTemple();
               break;
            case 119:
               SwitchPageHelp.openShuttleFrame();
               break;
            case 130:
               SwitchPageHelp.openAbysmFrame();
               break;
            case 167:
               SwitchPageHelp.opendungeonexploFrame();
               break;
            case 131:
               SwitchPageHelp.openTimeVortexFrame();
               break;
            case 132:
               openCrisisEnterFrame();
               break;
            case 133:
               SwitchPageHelp.openEclipticPalaceFrame();
               break;
            case 134:
               SwitchPageHelp.openDemonLandFrame();
               break;
            case 135:
               SwitchPageHelp.openGameHallFrame();
               break;
            case 136:
               SwitchPageHelp.openMonsterExploreFrame();
               break;
            case 137:
               SwitchPageHelp.enterAirGardenCampaign(ArmyManager.instance.thane.userId);
               break;
            case 138:
               SwitchPageHelp.airGardenCreateParty();
               break;
            case 139:
               SwitchPageHelp.airGardenJoinParty();
               break;
            case 140:
               FrameControllerManager.instance.openControllerByInfo("shop",1018);
               break;
            case 141:
               SwitchPageHelp.airGardenCampaignUp();
               break;
            case 142:
               SwitchPageHelp.joinAirGardenPartyGame(1);
               break;
            case 143:
               SwitchPageHelp.joinAirGardenPartyGame(2);
               break;
            case 144:
               SwitchPageHelp.joinAirGardenPartyGame(3);
               break;
            case 145:
               SwitchPageHelp.openRevengeRoad();
               break;
            case 146:
               if(this.parent.parent.parent is Frame)
               {
                  Frame(this.parent.parent.parent).dispose();
               }
               PlayerManager.instance.sendAvengerTransfer();
               break;
            case 147:
               SwitchPageHelp.openRedemptionRoad();
               break;
            case 148:
               SwitchPageHelp.openHellAbysmFrame();
               break;
            case 150:
               SwitchPageHelp.openSpiritExpeditionFrame();
               break;
            case 151:
               SwitchPageHelp.openYLExpeditionFrame();
               break;
            case 152:
               SwitchPageHelp.openShadowLandFrame();
               break;
            case 153:
               SwitchPageHelp.openDarkMazeShopFrame();
               break;
            case 154:
               if(this.parent.parent.parent is Frame)
               {
                  Frame(this.parent.parent.parent).dispose();
               }
               PlayerManager.instance.sendFourTransfer();
               break;
            case 155:
               SwitchPageHelp.openRemainsExploreFrame();
               break;
            case 156:
               SwitchPageHelp.openRoyaltyBossFrame();
               break;
            case 157:
               SwitchPageHelp.openPoseidonFrame();
               break;
            case 158:
               SwitchPageHelp.openForbiddenBossFrame();
               break;
            case 159:
               SwitchPageHelp.openSecretFrame();
               break;
            case 160:
               SwitchPageHelp.openWarSoulTowerFrame();
               break;
            case 161:
               SwitchPageHelp.openFinalRoadFrame();
               break;
            case 162:
               SwitchPageHelp.openGodPvpFrame();
               break;
            case 163:
               SwitchPageHelp.openChildNsWar();
               break;
            case 165:
               SwitchPageHelp.openThessTower();
               break;
            case 166:
               SwitchPageHelp.openThessBox();
               break;
            default:
               if(_nextStep != null)
               {
                  _nextStep(_nextStepParam);
               }
         }
      }
      
      private function openCrisisEnterFrame() : void
      {
         if(!VersionSwitch.PLANE_CRISIS_OPEN)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.will.openFunTip"));
            return;
         }
         if(_nextStep != null)
         {
            _nextStep(_nextStepParam);
         }
         FrameControllerManager.instance.openControllerByInfo("planecrisis",PlaneCrisisController.ENTER_CRISIS);
      }
      
      private function checkGoodsCount() : Boolean
      {
         var _loc2_:Array = null;
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         if(nodeInfo.ItemExchange)
         {
            _loc2_ = _nodeInfo.ItemExchange.split("|");
            if(_loc2_ && _loc2_[_param])
            {
               _loc1_ = _loc2_[_param].split("#")[0].split(",");
               _loc3_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc1_[0]));
               return _loc3_ >= _loc1_[1];
            }
            return false;
         }
         return false;
      }
      
      private function birthdayItemsHandler(param1:uint) : void
      {
         var _loc2_:Boolean = Boolean(BirthdayManager.instance.checkActiveHandler());
         if(_loc2_)
         {
            switch(int(param1) - 36)
            {
               case 0:
                  FrameControllerManager.instance.openControllerByInfo("birthday","MESSAGE_BOARD_FRAME");
                  break;
               case 1:
                  FrameControllerManager.instance.openControllerByInfo("funny");
                  break;
               case 2:
                  BirthdayManager.instance.sendOperationToServer(102,1);
                  break;
               default:
                  return;
            }
         }
      }
      
      private function heartCallback(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.space.view.frame.DialogOptionItem.waitFor"));
            MarrySender.opMarryHeartOp(3001);
            if(_nextStep != null)
            {
               _nextStep(_nextStepParam);
            }
         }
      }
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function divorceHandler() : void
      {
         if(_nextStep != null)
         {
            _nextStep(_nextStepParam);
         }
      }
      
      private function __showTalkNext1(param1:RingTaskEvent) : void
      {
         if(_showNext1)
         {
            _showNext1 = false;
            _nextStep(_nextStepParam);
         }
      }
      
      private function __showTalkNext2(param1:String, param2:Object) : void
      {
         if(_showNext2 && marryModel.getMarryTask())
         {
            _showNext2 = false;
            _nextStep(_nextStepParam);
         }
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _selectedBg.visible = true;
         _option.setFrame(2);
         if(_type == 13)
         {
            _loc2_ = _title.indexOf(LanguageMgr.GetTranslation("ui.tasktracebar.view.DialogOptionItem.index2"));
            _loc3_ = _title.indexOf(")");
            _option.setTextFormat(_format_2,_loc2_ + 9,_loc3_);
         }
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _selectedBg.visible = false;
         _option.setFrame(1);
         if(_type == 13)
         {
            _loc2_ = _title.indexOf(LanguageMgr.GetTranslation("ui.tasktracebar.view.DialogOptionItem.index2"));
            _loc3_ = _title.indexOf(")");
            _option.setTextFormat(_format,_loc2_ + 9,_loc3_);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get nodeInfo() : SpaceNode
      {
         return _nodeInfo;
      }
      
      public function set nodeInfo(param1:SpaceNode) : void
      {
         _nodeInfo = param1;
      }
      
      public function dispose() : void
      {
         _showNext1 = false;
         removeEvent();
         _format = null;
         _format_2 = null;
         if(_selectedBg)
         {
            ObjectUtils.disposeObject(_selectedBg);
            _selectedBg = null;
         }
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
         if(_option)
         {
            ObjectUtils.disposeObject(_option);
            _option = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

