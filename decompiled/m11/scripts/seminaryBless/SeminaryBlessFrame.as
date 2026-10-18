package seminaryBless
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.player.BlessingMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SeminaryBlessFrame extends Frame
   {
      
      private static const NEEDCRYSTAL:int = 2000;
      
      private static const Max_SeminaryEffect:int = 200;
      
      private var _effect:Bitmap;
      
      private var _effectBack:Bitmap;
      
      private var _effectTip:FilterFrameText;
      
      private var _percent:Bitmap;
      
      private var _leftTime:Bitmap;
      
      private var _effectCon:MovieClip;
      
      private var _numStopEffect_1:MovieClip;
      
      private var _numStopEffect_2:MovieClip;
      
      private var _numStopEffect_3:MovieClip;
      
      private var _confirmBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _numBitData1:BitmapData;
      
      private var _numBitData2:BitmapData;
      
      private var _leftCrystalBack:Bitmap;
      
      private var _currenLeftCrystal:FilterFrameText;
      
      private var _isIncrease:Boolean = false;
      
      private var _currentSeminaryEffect:int = 0;
      
      private var _oldSeminaryEffect:int = 0;
      
      public var num1:int = 0;
      
      public var num2:int = 0;
      
      public var num3:int = 0;
      
      private var _timeid:int;
      
      private var _timeid2:int;
      
      private var _timeid3:int;
      
      public function SeminaryBlessFrame()
      {
         super();
         initView();
         initEvent();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _effect = ComponentFactory.Instance.creatBitmap("asset.seminaryBless.BlessEffectAssetII");
         _effectBack = ComponentFactory.Instance.creatBitmap("asset.seminaryBless.BlessBackAsset");
         _effectTip = ComponentFactory.Instance.creatComponentByStylename("seminaryBless.BlessFrame.EffectTipTxt");
         _percent = ComponentFactory.Instance.creatBitmap("asset.seminaryBless.BlessFrame.PercentAsset");
         _leftTime = ComponentFactory.Instance.creatBitmap("asset.seminaryBless.BlessLectTimeAssetII");
         _effectCon = ComponentFactory.Instance.creatCustomObject("seminaryBless.BlessFrame.EffectContain");
         _numStopEffect_1 = ComponentFactory.Instance.creatCustomObject("seminaryBless.BlessFrame.BlessStopEffectContain1");
         _numStopEffect_2 = ComponentFactory.Instance.creatCustomObject("seminaryBless.BlessFrame.BlessStopEffectContain2");
         _numStopEffect_3 = ComponentFactory.Instance.creatCustomObject("seminaryBless.BlessFrame.BlessStopEffectContain3");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("seminaryBless.BlessFrame.ConfirmBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("seminaryBless.BlessFrame.HelpBtn");
         _leftCrystalBack = ComponentFactory.Instance.creatBitmap("asset.seminaryBless.BlessCrystalCostAssetII");
         _currenLeftCrystal = ComponentFactory.Instance.creatComponentByStylename("seminaryBless.BlessFrame.CurrentLeftCrystalValueTxt");
         _effectTip.text = LanguageMgr.GetTranslation("seminaryBless.SeminaryBlessFrame.EffectTip");
         _numStopEffect_1.gotoAndStop(1);
         _numStopEffect_2.gotoAndStop(1);
         _numStopEffect_3.gotoAndStop(1);
         addToContent(_effectBack);
         addToContent(_effect);
         addToContent(_effectTip);
         addToContent(_leftTime);
         addToContent(_leftCrystalBack);
         addToContent(_currenLeftCrystal);
         addToContent(_effectCon);
         addToContent(_confirmBtn);
         addToContent(_helpBtn);
         addToContent(_numStopEffect_1);
         addToContent(_numStopEffect_2);
         addToContent(_numStopEffect_3);
         _effectCon.gotoAndStop(1);
         _effectCon.addChild(_percent);
         _numBitData1 = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_07").clone();
         _numBitData2 = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_08").clone();
         NumberViewUtils.refreshValue(int(playerInfo.seminaryEffect / 100),_numStopEffect_1["n6"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(int(playerInfo.seminaryEffect % 100 / 10),_numStopEffect_2["n6"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(int(playerInfo.seminaryEffect % 10),_numStopEffect_3["n6"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(playerInfo.seminaryEffect,_effectCon["pre_txt"],_numBitData2,13,19,9,13,"0123456789");
         _percent.x = _effectCon["pre_txt"].x + _effectCon["pre_txt"].width;
         _percent.y = _effectCon["pre_txt"].y + 2;
         _currenLeftCrystal.text = ResourceManager.instance.waterCrystal.count.toString();
         if(ResourceManager.instance.waterCrystal.count < 2000)
         {
            _currenLeftCrystal.setFrame(2);
         }
         titleText = LanguageMgr.GetTranslation("buildings.seminary.view.blessHelpTitle");
         _helpBtn.tipData = LanguageMgr.GetTranslation("buildings.SeminaryFrame.HelpBtn.Tipdata");
         _oldSeminaryEffect = playerInfo.seminaryEffect;
         if(_oldSeminaryEffect >= 200)
         {
            _confirmBtn.enable = false;
         }
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpHandler);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _numStopEffect_1.addEventListener("complete",__completeHandler);
         _effectCon.addEventListener("complete",__effectComplete);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4391,__refreshBlessHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpHandler);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _numStopEffect_1.removeEventListener("complete",__completeHandler);
         _effectCon.removeEventListener("complete",__effectComplete);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4391,__refreshBlessHandler);
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("core.BlessHelpFrame");
         _loc2_.show();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      private function __refreshBlessHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:BlessingMsg = new BlessingMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as BlessingMsg;
         _currentSeminaryEffect = _oldSeminaryEffect + _loc2_.increase;
         if(_currentSeminaryEffect >= 200)
         {
            _confirmBtn.enable = false;
         }
         if(_oldSeminaryEffect < _currentSeminaryEffect)
         {
            _isIncrease = true;
            _oldSeminaryEffect = _currentSeminaryEffect;
            if(_oldSeminaryEffect >= 200)
            {
               _oldSeminaryEffect = 200;
            }
         }
         _percent.visible = true;
         _currenLeftCrystal.text = ResourceManager.instance.waterCrystal.count.toString();
         if(ResourceManager.instance.waterCrystal.count < 2000)
         {
            _currenLeftCrystal.setFrame(2);
         }
         var _loc3_:int = _oldSeminaryEffect / 100;
         var _loc5_:int = _oldSeminaryEffect % 100 / 10;
         var _loc6_:int = _oldSeminaryEffect % 100 % 10;
         _timeid = setTimeout(playStopEffect3,2000,_loc6_,_loc5_,_loc3_);
      }
      
      private function playStopEffect(param1:int) : void
      {
         clearTimeout(_timeid3);
         _numStopEffect_1.gotoAndStop("stopEffect");
         NumberViewUtils.refreshValue(getNum(param1 - 5),_numStopEffect_1["n1"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 4),_numStopEffect_1["n2"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 3),_numStopEffect_1["n3"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 2),_numStopEffect_1["n4"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 1),_numStopEffect_1["n5"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1),_numStopEffect_1["n6"],_numBitData1,30,26,30,30,"0123456789");
         _numStopEffect_1.play();
      }
      
      private function playStopEffect2(param1:int, param2:int) : void
      {
         clearTimeout(_timeid2);
         _numStopEffect_2.gotoAndStop("stopEffect");
         NumberViewUtils.refreshValue(getNum(param1 - 5),_numStopEffect_2["n1"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 4),_numStopEffect_2["n2"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 3),_numStopEffect_2["n3"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 2),_numStopEffect_2["n4"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 1),_numStopEffect_2["n5"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1),_numStopEffect_2["n6"],_numBitData1,30,26,30,30,"0123456789");
         _numStopEffect_2.play();
         _timeid3 = setTimeout(playStopEffect,500,param2);
      }
      
      private function playStopEffect3(param1:int, param2:int, param3:int) : void
      {
         clearTimeout(_timeid);
         _numStopEffect_3.gotoAndStop("stopEffect");
         NumberViewUtils.refreshValue(getNum(param1 - 5),_numStopEffect_3["n1"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 4),_numStopEffect_3["n2"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 3),_numStopEffect_3["n3"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 2),_numStopEffect_3["n4"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1 - 1),_numStopEffect_3["n5"],_numBitData1,30,26,30,30,"0123456789");
         NumberViewUtils.refreshValue(getNum(param1),_numStopEffect_3["n6"],_numBitData1,30,26,30,30,"0123456789");
         _numStopEffect_3.play();
         _timeid2 = setTimeout(playStopEffect2,1000,param2,param3);
      }
      
      private function __completeHandler(param1:Event) : void
      {
         _closeButton.enable = true;
         if(_oldSeminaryEffect < 200)
         {
            _confirmBtn.enable = true;
         }
         if(_isIncrease)
         {
            _isIncrease = false;
            _effectCon.play();
         }
      }
      
      private function __effectComplete(param1:Event) : void
      {
         _effectCon.gotoAndStop(1);
         NumberViewUtils.refreshValue(_oldSeminaryEffect,_effectCon["pre_txt"],_numBitData2,13,19,9,13,"0123456789");
         _percent.x = _effectCon["pre_txt"].x + _effectCon["pre_txt"].width;
         _percent.y = _effectCon["pre_txt"].y + 2;
      }
      
      private function expendCrystalCall() : void
      {
         var _loc1_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc3_:String = null;
         if(ResourceManager.instance.waterCrystal.count < 2000)
         {
            _loc1_ = LanguageMgr.GetTranslation("buildings.seminary.view.crystalLack");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.sysCurtime.getHours());
         var _loc7_:Boolean = _loc2_ <= 5 && 5 - _loc2_ <= 2;
         if(_loc7_)
         {
            SimpleAlertHelper.instance.data = [sendBlessBack];
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc3_ = LanguageMgr.GetTranslation("buildings.seminary.view.blessNearTime");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc3_,_loc4_,_loc5_);
         }
         else
         {
            sendBless();
         }
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(expendCrystalAlert(expendCrystalAlertBack))
         {
            return;
         }
         expendCrystalCall();
      }
      
      private function expendCrystalAlert(param1:Function = null) : Boolean
      {
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc4_:Date = SharedManager.instance.expendCrystalCheckDate;
         var _loc5_:Date = new Date();
         var _loc2_:Boolean = false;
         var _loc6_:Boolean = Boolean(SharedManager.instance.expendCrystal);
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("seminaryBless.ExpendCrystalAlertFrame");
            _loc7_ = LanguageMgr.GetTranslation("seminaryBless.expendCrystal.content2");
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc3_,expendCrystalAlertBack);
         }
         return _loc2_;
      }
      
      private function expendCrystalAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.expendCrystal = param1;
         SharedManager.instance.expendCrystalCheckDate = new Date();
         SharedManager.instance.saveExpendCrystalCheck();
         expendCrystalCall();
      }
      
      private function sendBlessBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            sendBless();
         }
      }
      
      private function sendBless() : void
      {
         var _loc1_:PackageOut = new PackageOut(8489);
         SocketSendManager.instance.send(_loc1_);
         _numStopEffect_1.gotoAndPlay("roll");
         _numStopEffect_2.gotoAndPlay("roll");
         _numStopEffect_3.gotoAndPlay("roll");
         _closeButton.enable = false;
         _confirmBtn.enable = false;
      }
      
      private function getNum(param1:int) : int
      {
         if(param1 >= 0)
         {
            return param1;
         }
         switch(param1 - -5)
         {
            case 0:
               return 5;
            case 1:
               return 6;
            case 2:
               return 7;
            case 3:
               return 8;
            case 4:
               return 9;
            default:
               return 0;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         clearTimeout(_timeid);
         clearTimeout(_timeid2);
         clearTimeout(_timeid3);
         ObjectUtils.disposeObject(_leftCrystalBack);
         _leftCrystalBack = null;
         ObjectUtils.disposeObject(_currenLeftCrystal);
         _currenLeftCrystal = null;
         removeEvent();
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
      }
   }
}

