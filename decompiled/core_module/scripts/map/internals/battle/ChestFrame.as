package map.internals.battle
{
   import battle.BattleManager;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.pb.helper.item.ItemHelper;
   import com.road.yishi.proto.campaign.CampaignTakeCardsMsg;
   import com.road.yishi.proto.item.CampaignCardsMsg;
   import com.road.yishi.proto.item.ItemInfoMsg;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.event.CampaignMapEvent;
   import yishi.SwitchPageHelp;
   import yishi.datas.BattleModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.BaseManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.component.TimerButton;
   import yishi.view.frame.TodayNotAlertFrame;
   import yzhkof.debug.log;
   
   public class ChestFrame extends Sprite implements Disposeable, IManualSize
   {
      
      private var _backMc:MovieClip;
      
      private var _content:MovieClip;
      
      private var _numBitmapData:BitmapData;
      
      private var _confirmBtn:IconButton;
      
      private var _exitBtn:IconButton;
      
      private var _againBtn:IconButton;
      
      private var _washBtn:TimerButton;
      
      private var _time:Timer;
      
      private var _msg:CampaignCardsMsg;
      
      private var _showWash:Boolean;
      
      private var _isReStart:Boolean;
      
      private var _dict:Dictionary = new Dictionary(true);
      
      private var _timeId:int;
      
      private var curBattleType:int;
      
      public function ChestFrame()
      {
         super();
      }
      
      public function show(param1:CampaignCardsMsg, param2:Boolean = false) : void
      {
         _msg = param1;
         _showWash = param2;
         var _loc3_:BattleModel = BattleManager.getInstance().battleModel;
         curBattleType = _loc3_ ? _loc3_.battleType : -1;
         CheckUIModuleUtil.instance.tryCall("chest",initShow);
      }
      
      private function initShow() : void
      {
         initView();
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         initData();
      }
      
      private function initView() : void
      {
         _backMc = ComponentFactory.Instance.creatCustomObject("chest.BackMc");
         _content = ComponentFactory.Instance.creatCustomObject("chest.ContentMc");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("chest.ChestOKBtn");
         _exitBtn = ComponentFactory.Instance.creatComponentByStylename("chest.ChestExitBtn");
         _againBtn = ComponentFactory.Instance.creatComponentByStylename("chest.ChestAgainBtn");
         _washBtn = ComponentFactory.Instance.creatCustomObject("chest.TimerBtn");
         _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.chest.battleinvite.BattleInviteNumberAsset");
         _confirmBtn.enable = false;
         _exitBtn.visible = false;
         _againBtn.visible = false;
         _backMc.gotoAndStop(1);
         _content.gotoAndStop(1);
         NotificationManager.instance.addEventListener("UPDATE_CHEST_INFO",__updateCardHandler);
         _confirmBtn.addEventListener("click",__confirmBtnHandler);
         _exitBtn.addEventListener("click",__confirmBtnHandler);
         _againBtn.addEventListener("click",__againHandler);
         _washBtn.addEventListener("click",__washHandler);
         _washBtn.addEventListener("complete",__washTimeCompleteHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("UPDATE_CHEST_INFO",__updateCardHandler);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmBtnHandler);
         }
         if(_exitBtn)
         {
            _exitBtn.removeEventListener("click",__confirmBtnHandler);
         }
         if(_againBtn)
         {
            _againBtn.removeEventListener("click",__againHandler);
         }
         if(_washBtn)
         {
            _washBtn.removeEventListener("click",__washHandler);
         }
         if(_washBtn)
         {
            _washBtn.removeEventListener("complete",__washTimeCompleteHandler);
         }
         if(_content)
         {
            _content.removeEventListener("complete",__showCompleteHandler);
            _content.removeEventListener("change",__completeHandler);
         }
         if(_time)
         {
            _time.stop();
            _time.reset();
            _time.removeEventListener("timer",__timerHandler);
         }
         for each(var _loc1_:ChestItemView in _dict)
         {
            _loc1_.removeEventListener("click",__clickHandler);
         }
      }
      
      private function __confirmBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __againHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [againBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("map.internals.battle.ChestFrame.againContent");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
      }
      
      private function againBack(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(showThewAlert())
         {
            return;
         }
         campaignAgain();
      }
      
      private function campaignAgain() : void
      {
         var _loc1_:String = SceneManager.instance.currentType;
         if(_loc1_ == "CAMPAIGN_MAP_SCENE")
         {
            disposeCampaign();
            CampaignSocketOutManager.instance.sendCampaignFinish(2);
            _isReStart = true;
         }
      }
      
      private function disposeCampaign() : void
      {
         RoomManager.instance.dispose();
         CampaignManager.instance.dispose();
      }
      
      private function showThewAlert() : Boolean
      {
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = PlayerManager.instance.currentPlayerModel.playerInfo.weary < 20;
         var _loc4_:Date = SharedManager.instance.thewCheckDate;
         var _loc5_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc6_:Boolean = SharedManager.instance.thewCheck;
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc1_ = true;
         }
         if(_loc3_ && _loc1_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("core.TodayNotAlertFrame");
            _loc7_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist02");
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc2_,alerrBack);
            _loc8_.containerY = 36;
         }
         return _loc3_ && _loc1_;
      }
      
      private function alerrBack(param1:Boolean) : void
      {
         SharedManager.instance.thewCheck = param1;
         SharedManager.instance.thewCheckDate = new Date();
         SharedManager.instance.saveThewCheck();
         campaignAgain();
      }
      
      private function __washTimeCompleteHandler(param1:Event) : void
      {
         _washBtn.removeEventListener("click",__washHandler);
         _washBtn.removeEventListener("complete",__washTimeCompleteHandler);
         playWash();
      }
      
      private function __washHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _washBtn.removeEventListener("click",__washHandler);
         _washBtn.removeEventListener("complete",__washTimeCompleteHandler);
         playWash();
      }
      
      private function playWash() : void
      {
         ObjectUtils.disposeAllChildren(_backMc["button_pos2"]);
         _backMc["button_pos2"].addChild(_confirmBtn);
         _content.gotoAndPlay("back_f");
         for each(var _loc1_:ChestItemView in _dict)
         {
            _loc1_.playReverseBack();
         }
      }
      
      private function initData() : void
      {
         var _loc1_:ChestItemView = null;
         var _loc2_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc3_:ItemInfoMsg = null;
         _loc2_ = 1;
         while(_loc2_ <= _msg.cardCount)
         {
            _loc1_ = new ChestItemView();
            _loc1_.index = _loc2_ - 1;
            if(_showWash)
            {
               _loc4_ = new GoodsInfo();
               _loc3_ = _msg.dropItems[_loc2_ - 1] as ItemInfoMsg;
               _loc4_ = ItemHelper.readGoodsInfo(_loc3_,_loc4_);
               _loc1_.data = _loc4_;
            }
            _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
            _content["pos_" + _loc2_].addChild(_loc1_);
            _dict[_loc2_ - 1] = _loc1_;
            _loc2_++;
         }
         _content.addEventListener("complete",__showCompleteHandler);
         _content.addEventListener("change",__completeHandler);
         addChild(_backMc);
         addChild(_content);
         _backMc.gotoAndPlay(1);
         if(_showWash)
         {
            _content.gotoAndPlay("show_f");
            for each(_loc1_ in _dict)
            {
               _loc1_.mouseChildren = _loc1_.mouseEnabled = true;
            }
         }
         else
         {
            for each(_loc1_ in _dict)
            {
               _loc1_.playDefaut();
            }
            if(_msg.sceneType == "SINGLE_CAMPAIGN_MAP_SCENE")
            {
               if(thane.grades < 30 || CampaignManager.instance.mapId == 4401 || campaignTemp.DifficultyGrade == 2)
               {
                  _exitBtn.x = -38;
                  _backMc["button_pos2"].addChild(_exitBtn);
               }
               else
               {
                  _backMc["button_pos1"].addChild(_exitBtn);
                  _backMc["button_pos3"].addChild(_againBtn);
               }
            }
            else
            {
               _backMc["button_pos2"].addChild(_confirmBtn);
            }
            _content.gotoAndPlay("normal_f");
         }
      }
      
      private function __showCompleteHandler(param1:Event) : void
      {
         _content.removeEventListener("complete",__showCompleteHandler);
         _backMc["button_pos2"].addChild(_washBtn);
         _washBtn.time = 30;
      }
      
      private function __completeHandler(param1:Event) : void
      {
         _time = new Timer(1000,18);
         _time.addEventListener("timer",__timerHandler);
         _time.start();
         for each(var _loc2_:ChestItemView in _dict)
         {
            _loc2_.buttonMode = _loc2_.mouseChildren = _loc2_.mouseEnabled = true;
            _loc2_.addEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ChestItemView = param1.currentTarget as ChestItemView;
         if(BaseManager.instance.isSelect || _loc2_.timeout)
         {
            return;
         }
         SoundManager.instance.play("007",true);
         var _loc3_:int = ArmyManager.instance.army.id;
         CampaignSocketOutManager.instance.sendCampaignCard(_loc2_.isPay,_loc2_.index,_loc3_);
         _time.stop();
      }
      
      public function __updateCardHandler(param1:CampaignMapEvent) : void
      {
         var _loc3_:ChestItemView = null;
         var _loc2_:CampaignTakeCardsMsg = param1.data as CampaignTakeCardsMsg;
         if(_loc2_.playerId == thane.userId)
         {
            if(_time && _time.running)
            {
               _time.removeEventListener("timer",__timerHandler);
            }
            if(_backMc)
            {
               ObjectUtils.disposeAllChildren(_backMc["time_pos"]);
            }
            _timeId = setTimeout(dispose,8000);
            _confirmBtn.enable = true;
         }
         _loc3_ = _dict[_loc2_.index] as ChestItemView;
         if(!_loc3_)
         {
            log({},"收到翻牌协议，翻牌位置是：" + _loc2_.index);
            _confirmBtn.enable = true;
            _exitBtn.visible = true;
            _againBtn.visible = true;
            _loc2_ = null;
            return;
         }
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.count = _loc2_.count;
         _loc4_.templateId = _loc2_.templateId;
         _loc4_.isBinds = _loc2_.bind;
         _loc4_.randomSkill1 = _loc2_.randomSkill_1;
         _loc4_.randomSkill2 = _loc2_.randomSkill_2;
         _loc4_.randomSkill3 = _loc2_.randomSkill_3;
         _loc4_.randomSkill4 = _loc2_.randomSkill_4;
         _loc4_.randomSkill5 = _loc2_.randomSkill_5;
         _loc3_.updateData(_loc2_.playerId,_loc2_.name,_loc4_);
         _exitBtn.visible = true;
         _againBtn.visible = true;
         _loc2_ = null;
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:int = 11 - _time.currentCount;
         if(_loc2_ <= 0)
         {
            _loc2_ = 0;
            autoChest();
            _time.stop();
         }
         NumberViewUtils.refreshValue(_loc2_,_backMc["time_pos"],_numBitmapData);
      }
      
      private function autoChest() : void
      {
         var _loc2_:int = ArmyManager.instance.army.id;
         for each(var _loc1_:ChestItemView in _dict)
         {
            if(!_loc1_.isChested)
            {
               CampaignSocketOutManager.instance.sendCampaignCard(true,_loc1_.index,_loc2_);
               return;
            }
         }
      }
      
      public function dispose() : void
      {
         clearTimeout(_timeId);
         _timeId = 0;
         removeEvent();
         LayerManager.Instance.getLayerByType(4).visible = true;
         KeyBoardRegister.instance.keyEnable = true;
         if(_confirmBtn)
         {
            _confirmBtn.dispose();
         }
         _confirmBtn = null;
         if(_exitBtn)
         {
            _exitBtn.dispose();
         }
         _exitBtn = null;
         if(_washBtn)
         {
            _washBtn.dispose();
         }
         _washBtn = null;
         if(_numBitmapData)
         {
            _numBitmapData.dispose();
         }
         _numBitmapData = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _time = null;
         _confirmBtn = null;
         var _loc2_:String = SceneManager.instance.currentType;
         if(_loc2_ == "CAMPAIGN_MAP_SCENE" && !_isReStart)
         {
            CampaignSocketOutManager.instance.sendCampaignFinish(1);
         }
         else if(_loc2_ == "BATTLE_SCENE" && curBattleType == 16)
         {
            if(!_isReStart)
            {
               SwitchPageHelp.returnToSpace({"isOpenColosseum":true},false,true);
            }
            BattleManager.preScene = "";
         }
         ObjectUtils.disposeViolentMc(_backMc);
         _backMc = null;
         ObjectUtils.disposeViolentMc(_content);
         _content = null;
         for each(var _loc1_:ChestItemView in _dict)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _dict = null;
         _msg = null;
         if(_againBtn)
         {
            _againBtn.dispose();
         }
         _againBtn = null;
      }
      
      private function get campaignTemp() : CampaignTemplate
      {
         return TempleteManager.instance.getCampaignTemplateById(CampaignManager.instance.mapModel.mapTempInfo.CampaignId);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1250,345);
      }
   }
}

