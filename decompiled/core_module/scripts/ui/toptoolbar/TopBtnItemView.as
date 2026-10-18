package ui.toptoolbar
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.CustomizedVipManager;
   import managers.FoisonHornManager;
   import managers.GameHallManager;
   import managers.LuckyLotteryManager;
   import managers.MonthCardManager;
   import managers.MopupManager;
   import managers.MvpShopManager;
   import managers.StokesOreManager;
   import managers.SuperSigninCardManager;
   import managers.WholeRebateManager;
   import managers.WishPoolManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.PetBossModel;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import ui.toptoolbar.view.TimeActiveBoxOpenTime;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.TopToolBtnTempInfo;
   import yishi.manager.ApexManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.ChristmasManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.GoldenSheepManager;
   import yishi.manager.LandMineManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.SkyTreasureManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.component.MovieButton;
   
   public class TopBtnItemView extends Component implements IManualSize
   {
      
      private var btn:MovieButton;
      
      private var btnImage:Bitmap;
      
      private var stateText:FilterFrameText;
      
      private var infoTipMc:MovieClip;
      
      private var _data:TopToolBtnTempInfo;
      
      private var btnImageDic:Dictionary;
      
      private var timer:Timer;
      
      private var leftTimeNum:int;
      
      private var leftTime:String = "";
      
      public function TopBtnItemView()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,75,75);
      }
      
      private function initView() : void
      {
         btn = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.topBtn");
         stateText = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.topBtn.stateText");
         addChild(btn);
         addChild(stateText);
         stateText.text = "";
         btnImageDic = new Dictionary();
      }
      
      private function addEvent() : void
      {
         if(btn)
         {
            btn.addEventListener("click",__btnClickHandler);
         }
         MsgMan.addObserver("REFRESH_BTN_TEXT",this,onRefreshBtnText);
         MsgMan.addObserver("REFRESH_TIPSBTN_TEXT",this,onRefreshBtnTipsText);
      }
      
      private function removeEvent() : void
      {
         if(btn)
         {
            btn.removeEventListener("click",__btnClickHandler);
         }
         MsgMan.removeObserver("REFRESH_BTN_TEXT",this,onRefreshBtnText);
         MsgMan.removeObserver("REFRESH_TIPSBTN_TEXT",this,onRefreshBtnTipsText);
      }
      
      public function get data() : TopToolBtnTempInfo
      {
         return _data;
      }
      
      public function checkActiveFlash() : void
      {
         if(_data == null)
         {
            return;
         }
         if(btn && btn.movie && btn.movie.movie)
         {
            if(_data.boxFlash)
            {
               btn.movie.movie["effect"]["effect_01"].play();
            }
            else
            {
               btn.movie.movie["effect"].stop();
               btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
            }
         }
      }
      
      public function set data(param1:TopToolBtnTempInfo) : void
      {
         if(_data != null && _data == param1)
         {
            return;
         }
         _data = param1;
         if(btnImage && btnImage.parent)
         {
            btnImage.parent.removeChild(btnImage);
         }
         if(infoTipMc && infoTipMc.parent)
         {
            infoTipMc.parent.removeChild(infoTipMc);
         }
         removeEvent();
         if(data)
         {
            addEvent();
            this.visible = true;
            btnImage = btnImageDic[data.BtnKey];
            if(btnImage == null)
            {
               btnImage = ComponentFactory.Instance.creatBitmap("asset.toptoolbar.topIcon_" + data.BtnKey);
               btnImageDic[data.BtnKey] = btnImage;
            }
            if(btnImage)
            {
               btn.movie.movie["icon"].addChild(btnImage);
            }
            if(TopBtnType.REMOVE_EFFECT_DATA.indexOf(data.BtnKey) != -1 || data.IsTimeTemp && !data.isOpen)
            {
               btn.movie.movie["effect"].stop();
               btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
            }
            else if(!data.hasClick)
            {
               btn.movie.movie["effect"]["effect_01"].play();
            }
            if(data.BtnKey == "wholerebate")
            {
               if(WholeRebateManager.instance.model.percent > 0)
               {
                  btn.movie.movie["effect"].stop();
                  btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
               }
               else if(!data.hasClick)
               {
                  btn.movie.movie["effect"]["effect_01"].play();
               }
            }
            else if(data.BtnKey == "luckylottery")
            {
               if(!LuckyLotteryManager.instance.model.openLuckyLottery)
               {
                  btn.movie.movie["effect"].stop();
                  btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
               }
               else if(!data.hasClick)
               {
                  btn.movie.movie["effect"]["effect_01"].play();
               }
            }
            else if(data.BtnKey == "landmine")
            {
               if(!LandMineManager.instance.model.hasRewardCount)
               {
                  btn.movie.movie["effect"].stop();
                  btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
               }
               else if(!data.hasClick)
               {
                  btn.movie.movie["effect"]["effect_01"].play();
               }
            }
            else if(data.BtnKey == "stokesore")
            {
               if(!StokesOreManager.instance.model.openStokesOre)
               {
                  btn.movie.movie["effect"].stop();
                  btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
               }
               else if(!data.hasClick)
               {
                  btn.movie.movie["effect"]["effect_01"].play();
               }
            }
            else if(data.BtnKey == "gamehall")
            {
               if(!GameHallManager.instance.model.eastIsOpen)
               {
                  btn.movie.movie["effect"].stop();
                  btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
               }
               else if(!data.hasClick)
               {
                  btn.movie.movie["effect"]["effect_01"].play();
               }
            }
            else if(data.BtnKey == "wishpool")
            {
               if(!WishPoolManager.instance.model.wishPoolIsOpen)
               {
                  btn.movie.movie["effect"].stop();
                  btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
               }
               else if(!data.hasClick)
               {
                  btn.movie.movie["effect"]["effect_01"].play();
               }
            }
            else if(data.BtnKey == "customizedvip")
            {
               if(!CustomizedVipManager.instance.model.isTopBtnFlicker)
               {
                  btn.movie.movie["effect"].stop();
                  btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
               }
               else if(!data.hasClick)
               {
                  btn.movie.movie["effect"]["effect_01"].play();
               }
            }
            else if(data.BtnKey == "skytreasure1")
            {
               if(!SkyTreasureManager.Instance.modelNew.getAllred())
               {
                  btn.movie.movie["effect"].stop();
                  btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
               }
               else if(!data.hasClick)
               {
                  btn.movie.movie["effect"]["effect_01"].play();
               }
            }
            if(TopToolsBar.instance.isUnEnableType(data.BtnKey) && MopupManager.instance.model.isMopup)
            {
               btn.enable = false;
            }
            else
            {
               btn.enable = true;
            }
            btn.tipData = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_" + data.BtnKey);
            setBtnText();
            setNewBtnTips();
            return;
         }
         btn.movie.movie["effect"].stop();
         btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         this.visible = false;
      }
      
      private function setBtnText() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         switch(data.BtnKey)
         {
            case "matelords":
               _loc2_ = TopToolsBar.instance.matelordsState;
               stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText" + _loc2_);
               stateText.setFrame(_loc2_ + 1);
               break;
            case "areslords":
               _loc2_ = TopToolsBar.instance.areslordsState;
               stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText" + _loc2_);
               stateText.setFrame(_loc2_ + 1);
               break;
            case "braveleg":
               _loc2_ = TopToolsBar.instance.braveLegState;
               stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText" + _loc2_);
               stateText.setFrame(_loc2_ + 1);
               break;
            case "worldboss":
               _loc2_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(2);
               if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[2])
               {
                  stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText0");
                  stateText.setFrame(_loc2_ + 1);
                  MsgMan.notifyObserver("REFRESH_TIPSBTN_TEXT","timebox1");
               }
               break;
            case "pvp":
               _loc2_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(0);
               if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[2])
               {
                  stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText0");
                  stateText.setFrame(_loc2_ + 1);
                  MsgMan.notifyObserver("REFRESH_TIPSBTN_TEXT","timebox1");
               }
               break;
            case "rvr1":
               _loc2_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(1);
               if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[2])
               {
                  stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText0");
                  stateText.setFrame(_loc2_ + 1);
                  MsgMan.notifyObserver("REFRESH_TIPSBTN_TEXT","timebox1");
               }
               break;
            case "vehicel":
               _loc2_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(3);
               if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[2])
               {
                  stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText0");
                  stateText.setFrame(_loc2_ + 1);
                  MsgMan.notifyObserver("REFRESH_TIPSBTN_TEXT","timebox1");
               }
               break;
            case "giftwill":
               _loc2_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(7);
               if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[2])
               {
                  stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText0");
                  stateText.setFrame(_loc2_ + 1);
                  MsgMan.notifyObserver("REFRESH_TIPSBTN_TEXT","timebox1");
               }
               break;
            case "petboss":
               _loc2_ = CampaignManager.instance.petBossModel.isOpen ? 2 : 0;
               if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[2])
               {
                  stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText0");
                  stateText.setFrame(_loc2_ + 1);
                  MsgMan.notifyObserver("REFRESH_TIPSBTN_TEXT","timebox1");
               }
               break;
            case "crossgvg":
               _loc2_ = CrossGuildManager.instance.model.state;
               if(_loc2_ == 2 || _loc2_ == 4 || _loc2_ == 6)
               {
                  if(CrossGuildManager.instance.model.signType)
                  {
                     if(_loc2_ == 2)
                     {
                        stateText.text = LanguageMgr.GetTranslation("braveleg.Tip.sign");
                        stateText.setFrame(2);
                     }
                     else
                     {
                        stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.crossGuild.stateText" + _loc2_);
                        stateText.setFrame(1);
                     }
                  }
                  else
                  {
                     stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText2");
                     stateText.setFrame(3);
                  }
               }
               else
               {
                  stateText.text = "";
               }
               break;
            case "childArena":
               if(ChildManager.instance.arenaModel.curstate == 0 && !ChildManager.instance.arenaModel.isSign)
               {
                  stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateText2");
                  stateText.setFrame(3);
               }
               else if(ChildManager.instance.arenaModel.isGuessState && ChildManager.instance.arenaModel.guessIndex == -1)
               {
                  stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.childArena.stateGuessText");
                  stateText.setFrame(3);
               }
               else
               {
                  stateText.text = "";
               }
               break;
            case "unrealshooting":
               _loc2_ = TopToolsBar.instance.unrealshootingState;
               stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.matelords.stateNewText" + _loc2_);
               stateText.setFrame(_loc2_ + 1);
               break;
            case "apex":
               stateText.multiline = true;
               stateText.height = 60;
               _loc2_ = TopToolsBar.instance.apexState;
               if(thane.fightingCapacity < 1000000 && _loc2_ != 2)
               {
                  stateText.text = "";
               }
               else if(_loc2_ == 1 && ApexManager.instance.model.isSign)
               {
                  stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.apex.stateText1_1");
               }
               else
               {
                  stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.apex.stateText" + _loc2_);
                  if(_loc2_ == 1)
                  {
                     _loc1_ = 0;
                     if(ApexManager.instance.model.myTeam)
                     {
                        _loc1_ = int(ApexManager.instance.model.myTeam.members.length);
                     }
                     if(_loc1_)
                     {
                        stateText.text += LanguageMgr.GetTranslation("toptoolbar.topBtn.apex.stateText1_add",_loc1_);
                     }
                  }
               }
               stateText.setFrame(_loc2_ + 1);
               break;
            case "darkmaze":
               _loc2_ = TopToolsBar.instance.darkmazeStatus;
               stateText.text = LanguageMgr.GetTranslation("toptoolbar.topBtn.darkmaze.stateNewText" + _loc2_);
               stateText.setFrame(1);
               break;
            default:
               stateText.text = "";
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function getLastTArr(param1:String, param2:int) : String
      {
         var _loc6_:int = param1.indexOf(":");
         var _loc4_:int = int(param1.substring(0,_loc6_));
         var _loc5_:int = int(param1.substring(_loc6_ + 1));
         var _loc3_:int = _loc5_ + param2;
         if(_loc3_ >= 60)
         {
            _loc4_ += 1;
         }
         return _loc4_ + ":" + _loc3_;
      }
      
      private function setNewBtnTips() : void
      {
         var _loc22_:ConfigInfosTempInfo = null;
         var _loc13_:ConfigInfosTempInfo = null;
         var _loc24_:Array = null;
         var _loc15_:Array = null;
         var _loc21_:String = null;
         var _loc10_:int = 0;
         var _loc1_:String = null;
         var _loc11_:int = 0;
         var _loc23_:Array = null;
         var _loc4_:int = 0;
         var _loc6_:Date = null;
         var _loc20_:String = null;
         var _loc25_:String = null;
         var _loc9_:String = null;
         var _loc5_:Date = null;
         var _loc2_:String = null;
         var _loc7_:Date = null;
         var _loc19_:String = null;
         var _loc26_:String = null;
         var _loc18_:Date = null;
         var _loc14_:String = null;
         var _loc3_:Date = null;
         var _loc12_:String = null;
         var _loc8_:String = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData");
         var _loc16_:int = 0;
         if(data.BtnKey == "secretwar")
         {
            _loc22_ = TempleteManager.instance.getConfigInfoByConfigName("secret_war_open_time");
            _loc13_ = TempleteManager.instance.getConfigInfoByConfigName("secret_war_keep_time");
            if(_loc22_ && _loc13_)
            {
               _loc24_ = _loc22_.ConfigValue.split("|");
               _loc15_ = _loc13_.ConfigValue.split(",");
               _loc21_ = "";
               _loc10_ = int(_loc24_.length);
               _loc16_ = 0;
               while(_loc16_ < _loc10_)
               {
                  _loc1_ = getLastTArr(_loc24_[_loc16_],int(_loc15_[1]));
                  _loc8_ += "\n" + _loc24_[_loc16_] + "-" + _loc1_;
                  _loc16_++;
               }
               btn.tipData = _loc8_;
            }
         }
         var _loc17_:int = TopBtnType.TIME_ACTIVE_BTNS.indexOf(data.BtnKey);
         if(_loc17_ != -1)
         {
            _loc11_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(_loc17_);
            _loc23_ = TimeActiveBoxOpenTime.instance.getOpenTimeByIndex(_loc17_);
            _loc16_ = 0;
            while(_loc16_ < _loc23_.length)
            {
               _loc8_ += "\n" + _loc23_[_loc16_].replace(",","-");
               btn.tipData = _loc8_;
               _loc16_++;
            }
            if(data.BtnKey == "childArena")
            {
               btn.tipData = LanguageMgr.GetTranslation("ChildArenaSignFrame.signText1.text",childPvpTimeArr[0],childPvpTimeArr[1]) + "\n" + LanguageMgr.GetTranslation("ChildArenaSignFrame.warText1.text",childPvpTimeArr[3],childPvpTimeArr[4]);
            }
            else if(data.BtnKey == "crossmuticampaign")
            {
               btn.tipData = LanguageMgr.GetTranslation("card.CardFrame.MultiCampaign");
            }
         }
         else if(data.BtnKey == "wholerebate")
         {
            btn.tipData = LanguageMgr.GetTranslation("wholerebate.wholerebateframe.time2") + "\n" + LanguageMgr.GetTranslation("wholerebate.wholerebateframe.time3",WholeRebateManager.instance.model.startTimeShort,WholeRebateManager.instance.model.endTimeShort);
         }
         else if(data.BtnKey == "timebox1")
         {
            _loc11_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(2);
            _loc4_ = 0;
            _loc21_ = LanguageMgr.GetTranslation("topbtntimeTip1") + "\n";
            if(_loc11_ == TopBtnType.TIME_ACTIVE_STATE[2])
            {
               _loc21_ += LanguageMgr.GetTranslation("topbtntimeTip11") + "\n";
               _loc4_++;
            }
            _loc11_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(0);
            if(_loc11_ == TopBtnType.TIME_ACTIVE_STATE[2])
            {
               _loc21_ += LanguageMgr.GetTranslation("topbtntimeTip2") + "\n";
               _loc4_++;
            }
            _loc11_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(1);
            if(_loc11_ == TopBtnType.TIME_ACTIVE_STATE[2])
            {
               _loc21_ += LanguageMgr.GetTranslation("topbtntimeTip3") + "\n";
               _loc4_++;
            }
            _loc11_ = TimeActiveBoxOpenTime.instance.getOpenStateByIndex(7);
            if(_loc11_ == TopBtnType.TIME_ACTIVE_STATE[2])
            {
               _loc21_ += LanguageMgr.GetTranslation("topbtntimeTip5") + "\n";
               _loc4_++;
            }
            if(_loc4_ == 0)
            {
               _loc21_ = "";
            }
            btn.tipData = _loc21_;
         }
         else if(data.BtnKey == "monthcard")
         {
            btn.tipData = LanguageMgr.GetTranslation("wholerebate.wholerebateframe.time2") + MonthCardManager.instance.model.openTime + "\n" + LanguageMgr.GetTranslation("MonthCardGiftItem.overActive.text") + MonthCardManager.instance.model.stopTime;
         }
         else if(data.BtnKey == "foisonhorn")
         {
            btn.tipData = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData") + FoisonHornManager.instance.model.openTime + "\n" + LanguageMgr.GetTranslation("MonthCardGiftItem.overActive.text") + FoisonHornManager.instance.model.stopTime;
         }
         else if(data.BtnKey == "goldensheep")
         {
            _loc6_ = GoldenSheepManager.instance.model.openTime;
            _loc20_ = LanguageMgr.GetTranslation("public.dateFormat");
            _loc25_ = DateFormatter.format(_loc6_,_loc20_);
            btn.tipData = LanguageMgr.GetTranslation("ui.toptoolbar.TopBtnItemView.goldenSheepTips",_loc25_);
         }
         else if(data.BtnKey == "mvpshop")
         {
            btn.tipData = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData") + MvpShopManager.instance.model.openTime + "\n" + LanguageMgr.GetTranslation("MonthCardGiftItem.overActive.text") + MvpShopManager.instance.model.stopTime;
         }
         else if(data.BtnKey == "stokesore")
         {
            _loc9_ = LanguageMgr.GetTranslation("public.dateFormat");
            _loc5_ = StokesOreManager.instance.model.startDate;
            _loc2_ = DateFormatter.format(_loc5_,_loc9_);
            _loc7_ = StokesOreManager.instance.model.endDate;
            _loc19_ = DateFormatter.format(_loc7_,_loc9_);
            btn.tipData = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData") + _loc2_ + "\n" + LanguageMgr.GetTranslation("MonthCardGiftItem.overActive.text") + _loc19_;
         }
         else if(data.BtnKey == "wishpool")
         {
            _loc26_ = LanguageMgr.GetTranslation("public.dateFormat");
            _loc18_ = WishPoolManager.instance.model.startDate;
            _loc14_ = DateFormatter.format(_loc18_,_loc26_);
            _loc3_ = WishPoolManager.instance.model.endDate;
            _loc12_ = DateFormatter.format(_loc3_,_loc26_);
            btn.tipData = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData") + _loc14_ + "\n" + LanguageMgr.GetTranslation("MonthCardGiftItem.overActive.text") + _loc12_;
         }
         else if(data.BtnKey == "supersignincard")
         {
            btn.tipData = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData") + SuperSigninCardManager.instance.model.openTime;
         }
         else if(data.BtnKey == "kingback")
         {
            btn.tipData = LanguageMgr.GetTranslation("kingback.frame.title");
         }
         else if(data.BtnKey == "platinum")
         {
            btn.tipData = LanguageMgr.GetTranslation("platinum.frame.title");
         }
         else if(data.BtnKey == "crossmuticampaign")
         {
            btn.tipData = LanguageMgr.GetTranslation("card.CardFrame.MultiCampaign");
         }
         else if(data.BtnKey != "darkmaze")
         {
            if(data.BtnKey == "oldplayerreturn" || data.BtnKey == "oldplayerreturn2")
            {
               btn.tipData = LanguageMgr.GetTranslation("OldPlayerReturnFrame.open.text",oldPlayerReturnModel.startDate) + "\n" + LanguageMgr.GetTranslation("OldPlayerReturnFrame.close.text",oldPlayerReturnModel.stopDate) + "\n" + LanguageMgr.GetTranslation("OldPlayerReturnFrame.shop.text",oldPlayerReturnModel.shopDate);
            }
            else if(data.BtnKey == "christmas")
            {
               btn.tipData = LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData") + ChristmasManager.instance.model.openTime + "\n" + LanguageMgr.GetTranslation("MonthCardGiftItem.overActive.text") + ChristmasManager.instance.model.stopTime;
            }
            else if(data.BtnKey == "petboss")
            {
               if(!timer)
               {
                  timer = new Timer(1000);
                  timer.start();
                  timer.addEventListener("timer",__updateLeftTimeHandler);
               }
               if(btn)
               {
                  btn.tipData = leftTime;
               }
            }
         }
      }
      
      private function __updateLeftTimeHandler(param1:TimerEvent) : void
      {
         var _loc2_:Number = petBossModel.getNearlyOpenTimeSecond();
         if(_loc2_ > 0 && !petBossModel.isOpen)
         {
            _loc2_--;
            leftTime = LanguageMgr.GetTranslation("topbtntimeTip6") + "\n" + DateFormatter.getConsortiaCountDate(_loc2_);
         }
         else
         {
            leftTime = LanguageMgr.GetTranslation("topbtntimeTip7");
         }
         setNewBtnTips();
      }
      
      private function get petBossModel() : PetBossModel
      {
         return CampaignManager.instance.petBossModel;
      }
      
      private function onRefreshBtnText(param1:String, param2:Object) : void
      {
         if(String(param2) == _data.BtnKey)
         {
            setBtnText();
         }
      }
      
      private function onRefreshBtnTipsText(param1:String, param2:Object) : void
      {
         if(String(param2) == _data.BtnKey)
         {
            setNewBtnTips();
         }
      }
      
      public function get movieBtn() : MovieButton
      {
         return btn;
      }
      
      public function addShowChild(param1:MovieClip) : void
      {
         if(!data)
         {
            return;
         }
         infoTipMc = param1;
         btn.addChild(infoTipMc);
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         SoundManager.instance.play("015");
         btn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         if(needChangeClickStatus())
         {
            data.hasClick = true;
         }
         MsgMan.notifyObserver("TOPTOOLBAR_BUTTON_CLICK",data);
      }
      
      private function needChangeClickStatus() : Boolean
      {
         var _loc1_:Boolean = false;
         if(!data)
         {
            return false;
         }
         if(data.BtnKey == "godsevening")
         {
            if(TopToolsBar.instance.godsEveningLightState == 0)
            {
               _loc1_ = false;
            }
            else if(TopToolsBar.instance.godsEveningLightState == 1)
            {
               _loc1_ = true;
            }
         }
         else if(data.BtnKey == "wholerebate")
         {
            if(WholeRebateManager.instance.model.percent > 0)
            {
               _loc1_ = true;
            }
            else
            {
               _loc1_ = false;
            }
         }
         else if(data.BtnKey == "customizedvip")
         {
            if(!CustomizedVipManager.instance.model.isTopBtnFlicker)
            {
               _loc1_ = true;
            }
            else
            {
               _loc1_ = false;
            }
         }
         else
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function get childPvpTimeArr() : Array
      {
         return ConfigInfoManager.instance.getChildPvpTimes();
      }
      
      private function get oldPlayerReturnModel() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(btnImage);
         btnImage = null;
         ObjectUtils.disposeObject(stateText);
         stateText = null;
         ObjectUtils.disposeObject(infoTipMc);
         infoTipMc = null;
         ObjectUtils.disposeObject(btn);
         btn = null;
         LogicUtils.disposeDisplayCollection(btnImageDic);
         btnImageDic = null;
         super.dispose();
      }
   }
}

