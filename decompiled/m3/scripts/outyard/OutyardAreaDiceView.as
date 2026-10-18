package outyard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardAreaDiceView extends Component
   {
      
      private var _progressMc:MovieClip;
      
      private var _addBtn:BaseButton;
      
      private var _progressCon:Sprite;
      
      private var _diceBg:MovieClip;
      
      private var _diceView1:StripView;
      
      private var _diceView2:StripView;
      
      private var _diceView3:StripView;
      
      private var _diceBtn1:MovieClip;
      
      private var _diceBtn2:MovieClip;
      
      private var _diceBtn3:MovieClip;
      
      private var _exploreTxt:FilterFrameText;
      
      private var _maxPoint:int;
      
      private var _timeId:int;
      
      private var _isAnimation:Boolean;
      
      private var _clickId:int;
      
      private var _cost:int;
      
      public function OutyardAreaDiceView()
      {
         super();
         _maxPoint = ConfigInfoManager.instance.getHugeHeadExplorePoint();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _progressMc = ComponentFactory.Instance.creatCustomObject("asset.outyard.ProgressExploreMc");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.addBtn");
         _diceBg = ComponentFactory.Instance.creatCustomObject("asset.outyard.diceBtnBg");
         _diceView1 = ComponentFactory.Instance.creatCustomObject("outyard.diceBtnStripView1");
         _diceView2 = ComponentFactory.Instance.creatCustomObject("outyard.diceBtnStripView2");
         _diceView3 = ComponentFactory.Instance.creatCustomObject("outyard.diceBtnStripView3");
         _diceBtn1 = ComponentFactory.Instance.creatCustomObject("outyard.diceBtnImage1");
         _diceBtn2 = ComponentFactory.Instance.creatCustomObject("outyard.diceBtnImage2");
         _diceBtn3 = ComponentFactory.Instance.creatCustomObject("outyard.diceBtnImage3");
         _exploreTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardAreaDiceView.exploreTxt");
         _progressCon = new Sprite();
         _progressCon.addChild(_progressMc);
         _progressCon.addChild(_addBtn);
         _progressCon.addChild(_exploreTxt);
         addChild(_diceBg);
         addChild(_progressCon);
         _diceView1.addChild(_diceBtn1);
         _diceView2.addChild(_diceBtn2);
         _diceView3.addChild(_diceBtn3);
         _diceBg.addChild(_diceView1);
         _diceBg.addChild(_diceView2);
         _diceBg.addChild(_diceView3);
         var _loc1_:int = int(OutyardManager.instance.model.getActiveRateByType(3));
         _cost = Math.ceil(ConfigInfoManager.instance.getHugeHeadExploreDiceCost() * (_loc1_ / 100));
         _diceView1.tipData = LanguageMgr.GetTranslation("outyard.OutyardAreaDiceView.diceNeedExplore",_cost);
         _diceView2.tipData = LanguageMgr.GetTranslation("outyard.OutyardAreaDiceView.diceNeedExplore",_cost);
         _diceView3.tipData = LanguageMgr.GetTranslation("outyard.OutyardAreaDiceView.diceNeedExplore",_cost);
      }
      
      private function addEvent() : void
      {
         _addBtn.addEventListener("click",__addClickHandler);
         _diceBtn1.addEventListener("click",__diceClickHandler);
         _diceBtn2.addEventListener("click",__diceClickHandler);
         _diceBtn3.addEventListener("click",__diceClickHandler);
         NotificationManager.instance.addEventListener("UPDATE_AREA_DICE",__updateDiceHandler);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__extraDiceHandler);
         updateDiceHandler();
         __extraDiceHandler(null);
      }
      
      private function removeEvent() : void
      {
         _addBtn.removeEventListener("click",__addClickHandler);
         _diceBtn1.removeEventListener("click",__diceClickHandler);
         _diceBtn2.removeEventListener("click",__diceClickHandler);
         _diceBtn3.removeEventListener("click",__diceClickHandler);
         NotificationManager.instance.removeEventListener("UPDATE_AREA_DICE",__updateDiceHandler);
         NotificationManager.instance.removeEventListener("PLAYER_EXTRA_FIELD",__extraDiceHandler);
      }
      
      private function __addClickHandler(param1:MouseEvent) : void
      {
         if(OutyardManager.instance.areaModel.exploreNum >= ConfigInfoManager.instance.getHugeHeadExplorePoint())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.scene.OutyardAreaDiceView.exploreMax"));
            return;
         }
         SoundManager.instance.play("022");
         showPromptAlert();
      }
      
      private function showPromptAlert() : void
      {
         var _loc3_:Array = ConfigInfoManager.instance.hugeHeadExploreChargePoint();
         SimpleAlertHelper.instance.data = [showPromptAlertBack,_loc3_[0]];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("outyard.OutyardFrame.addExploreTxt",_loc3_[0],_loc3_[1]);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc1_,_loc2_,true,true,false,2,"USEBINDPOINT_ALERT");
      }
      
      private function showPromptAlertBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc5_ = 0;
            if(param2)
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            else
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            }
            if(_loc5_ < param3)
            {
               RechargeAlertMannager.show();
            }
            else
            {
               _loc4_ = param2 ? 0 : 1;
               OutyardManager.instance.OperateArea(4,0,null,_loc4_);
            }
         }
      }
      
      private function __updateDiceHandler(param1:NotificationEvent) : void
      {
         var e:NotificationEvent = param1;
         this["_diceBtn" + _clickId].play();
         _isAnimation = true;
         _timeId = setTimeout(function():void
         {
            clearTimeout(_timeId);
            updateDiceHandler();
            _isAnimation = false;
         },500);
      }
      
      private function updateDiceHandler() : void
      {
         var _loc1_:Dictionary = OutyardManager.instance.areaModel.diceDic;
         if(_diceBtn1)
         {
            _diceBtn1.gotoAndStop(_loc1_[0].point);
         }
         if(_diceBtn2)
         {
            _diceBtn2.gotoAndStop(_loc1_[1].point);
         }
         if(_diceBtn3)
         {
            _diceBtn3.gotoAndStop(_loc1_[2].point);
         }
      }
      
      private function __extraDiceHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = OutyardManager.instance.areaModel.exploreNum / _maxPoint * 100;
         _progressMc.gotoAndStop(_loc2_);
         _exploreTxt.text = LanguageMgr.GetTranslation("outyard.OutyardAreaDiceView.exploreTxt",OutyardManager.instance.areaModel.exploreNum,_maxPoint);
      }
      
      private function __diceClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_isAnimation)
         {
            return;
         }
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         switch(_loc2_)
         {
            case _diceBtn1:
               _clickId = 1;
               break;
            case _diceBtn2:
               _clickId = 2;
               break;
            case _diceBtn3:
               _clickId = 3;
         }
         var _loc3_:int = _clickId - 1;
         if(OutyardManager.instance.areaModel.isWalking)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardAreaDiceView.isMove"));
            return;
         }
         if(OutyardManager.instance.areaModel.exploreNum < _cost)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardMapFrame.notEnoughExplore"));
            return;
         }
         OutyardManager.instance.areaModel.exploreNum -= _cost;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("PLAYER_EXTRA_FIELD"));
         OutyardManager.instance.areaModel.isWalking = true;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("DICE_STEP_CLICK",_loc3_));
      }
      
      public function adjustPos(param1:int, param2:int) : void
      {
         if(param2 >= 800)
         {
            _progressCon.y = -(param2 - 800) / 2;
            _diceBg.y = (param2 - 800) / 2 + 614;
         }
         else
         {
            _progressCon.y = (800 - param2) / 2;
            _diceBg.y = -(800 - param2) / 2 + 614;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearTimeout(_timeId);
         ObjectUtils.disposeViolentMc(_progressMc);
         _progressMc = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeAllChildren(_progressCon);
         ObjectUtils.disposeObject(_progressCon);
         _progressCon = null;
         ObjectUtils.disposeViolentMc(_diceBg);
         _diceBg = null;
         ObjectUtils.disposeObject(_diceBtn1);
         _diceBtn1 = null;
         ObjectUtils.disposeObject(_diceBtn2);
         _diceBtn2 = null;
         ObjectUtils.disposeObject(_diceBtn3);
         _diceBtn3 = null;
         ObjectUtils.disposeObject(_diceView1);
         _diceView1 = null;
         ObjectUtils.disposeObject(_diceView2);
         _diceView2 = null;
         ObjectUtils.disposeObject(_diceView3);
         _diceView3 = null;
         ObjectUtils.disposeObject(_exploreTxt);
         _exploreTxt = null;
         super.dispose();
      }
   }
}

