package outyard.scene
{
   import battle.utils.Int64Utils;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.hugehead.HugeHeadMySignInStateMsg;
   import com.road.yishi.proto.hugehead.HugeHeadOpenTimeMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import map.campaign.data.OutyardForceInfo;
   import mvc.module.outyard.LandPoint;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardInfoView extends Component
   {
      
      private var _info:LandPoint;
      
      private var _bgVs:Bitmap;
      
      private var _bgPeace:Bitmap;
      
      private var _bgCrystal:Bitmap;
      
      private var _landInfoImage2:ScaleFrameImage;
      
      private var _landInfoSword:Bitmap;
      
      private var _vsBmp:Bitmap;
      
      private var _stateImage:ScaleFrameImage;
      
      private var _blockImage1:ScaleFrameImage;
      
      private var _blockImage2:ScaleFrameImage;
      
      private var _kenengBmp:Bitmap;
      
      private var _bukeBmp:Bitmap;
      
      private var _hepingzhuangtaiBmp:Bitmap;
      
      private var _xuanzhantonggaoBmp:Bitmap;
      
      private var _nodeForceTxt:FilterFrameText;
      
      private var _crystalInformationTxt:FilterFrameText;
      
      private var _leftCountTxt:FilterFrameText;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _joinTxt:FilterFrameText;
      
      private var _joinTxt2:FilterFrameText;
      
      private var _jinxingxuanzhanBtn:IconButton;
      
      private var _hepingguanbiBtn:IconButton;
      
      private var _guanbiBtn:IconButton;
      
      private var _caijiBtn:IconButton;
      
      private var _keyicanzhanBtn:IconButton;
      
      private var _keyicanzhanBtn2:IconButton;
      
      private var _jinruBtn:IconButton;
      
      private var _clickTime:int = 0;
      
      public function OutyardInfoView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bgVs = ComponentFactory.Instance.creatBitmap("asset.outyard.landInfoBgVs");
         _bgPeace = ComponentFactory.Instance.creatBitmap("asset.outyard.landInfoBgPeace");
         _bgCrystal = ComponentFactory.Instance.creatBitmap("asset.outyard.landInfoBgCrystal");
         _landInfoImage2 = ComponentFactory.Instance.creatComponentByStylename("outyard.landInfoImage2");
         _landInfoSword = ComponentFactory.Instance.creatBitmap("asset.outyard.landInfoSword");
         _vsBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.landInfoVs");
         _stateImage = ComponentFactory.Instance.creatComponentByStylename("outyard.landInfoStateImage");
         _blockImage1 = ComponentFactory.Instance.creatComponentByStylename("outyard.landInfoBlockBmp1");
         _blockImage2 = ComponentFactory.Instance.creatComponentByStylename("outyard.landInfoBlockBmp2");
         _kenengBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.kenengBmp");
         _bukeBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.bukeBmp");
         _hepingzhuangtaiBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.hepingzhuangtaiBmp");
         _xuanzhantonggaoBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.landInfoNoticeNote");
         _leftCountTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.leftCountTxt");
         _nodeForceTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.nodeForceTxt");
         _crystalInformationTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.crystalInformationTxt");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.leftTimeTxt");
         _joinTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.joinTxt");
         _joinTxt2 = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.joinTxt2");
         _jinxingxuanzhanBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.jinxingxuanzhanBtn");
         _guanbiBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.guanbiBtn");
         _hepingguanbiBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.hepingguanbiBtn");
         _caijiBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.caijiBtn");
         _keyicanzhanBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.keyicanzhanBtn");
         _keyicanzhanBtn2 = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.keyicanzhanBtn2");
         _jinruBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.jinruBtn");
         addChild(_bgVs);
         addChild(_bgPeace);
         addChild(_bgCrystal);
         addChild(_landInfoImage2);
         addChild(_landInfoSword);
         addChild(_vsBmp);
         addChild(_stateImage);
         addChild(_blockImage1);
         addChild(_blockImage2);
         addChild(_kenengBmp);
         addChild(_bukeBmp);
         addChild(_hepingzhuangtaiBmp);
         addChild(_xuanzhantonggaoBmp);
         addChild(_leftCountTxt);
         addChild(_nodeForceTxt);
         addChild(_crystalInformationTxt);
         addChild(_leftTimeTxt);
         addChild(_joinTxt);
         addChild(_joinTxt2);
         addChild(_jinxingxuanzhanBtn);
         addChild(_hepingguanbiBtn);
         addChild(_guanbiBtn);
         addChild(_caijiBtn);
         addChild(_keyicanzhanBtn);
         addChild(_keyicanzhanBtn2);
         addChild(_jinruBtn);
      }
      
      private function addEvent() : void
      {
         _guanbiBtn.addEventListener("click",__guanbiClickHandler);
         _hepingguanbiBtn.addEventListener("click",__guanbiClickHandler);
         _jinxingxuanzhanBtn.addEventListener("click",__declareClickHandler);
         _keyicanzhanBtn.addEventListener("click",__addBattleClickHandler);
         _keyicanzhanBtn2.addEventListener("click",__addBattleClickHandler);
         _caijiBtn.addEventListener("click",__caijiClickHandler);
         _jinruBtn.addEventListener("click",__jinruClickHandler);
         NotificationManager.instance.addEventListener("UPDATE_LAND_NODE",__updateNodeHandler);
         NotificationManager.instance.addEventListener("OUTYARD_SIGNIN",__mySignHandler);
      }
      
      private function removeEvent() : void
      {
         if(_guanbiBtn)
         {
            _guanbiBtn.removeEventListener("click",__guanbiClickHandler);
         }
         if(_hepingguanbiBtn)
         {
            _hepingguanbiBtn.removeEventListener("click",__guanbiClickHandler);
         }
         if(_jinxingxuanzhanBtn)
         {
            _jinxingxuanzhanBtn.removeEventListener("click",__declareClickHandler);
         }
         if(_keyicanzhanBtn)
         {
            _keyicanzhanBtn.removeEventListener("click",__addBattleClickHandler);
         }
         if(_keyicanzhanBtn2)
         {
            _keyicanzhanBtn2.removeEventListener("click",__addBattleClickHandler);
         }
         if(_caijiBtn)
         {
            _caijiBtn.removeEventListener("click",__caijiClickHandler);
         }
         if(_jinruBtn)
         {
            _jinruBtn.removeEventListener("click",__jinruClickHandler);
         }
         NotificationManager.instance.removeEventListener("UPDATE_LAND_NODE",__updateNodeHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_SIGNIN",__mySignHandler);
      }
      
      private function __guanbiClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CLICK_LAND_NODE",null));
      }
      
      private function __addBattleClickHandler(param1:MouseEvent) : void
      {
         if(getTimer() - _clickTime < 1000)
         {
            return;
         }
         _clickTime = getTimer();
         SoundManager.instance.play("022");
         var _loc2_:IconButton = param1.currentTarget as IconButton;
         switch(_loc2_)
         {
            case _keyicanzhanBtn:
               OutyardManager.instance.OperateMapOutyard(5,_info.id,1);
               break;
            case _keyicanzhanBtn2:
               OutyardManager.instance.OperateMapOutyard(5,_info.id,2);
         }
      }
      
      private function __caijiClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         OutyardManager.instance.OperateMapOutyard(8);
      }
      
      private function __jinruClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:Number = NaN;
         var _loc3_:Date = null;
         var _loc4_:String = null;
         var _loc2_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         if(!_loc2_.stackHeadState)
         {
            _loc5_ = Number(_loc2_.stackHeadNextOpenTime[0] ? Int64Utils.int64ToNumber(_loc2_.stackHeadNextOpenTime[0].startTime) : 0);
            _loc3_ = new Date(_loc5_);
            _loc4_ = DateFormatter.timeFormat1(_loc3_);
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.TopToolsBar.nextOpenDate",_loc4_));
         }
         else
         {
            SoundManager.instance.play("022");
            FrameControllerManager.instance.openControllerByInfo("outyard");
         }
      }
      
      private function __declareClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:OutyardForceInfo = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(FrameControllerManager.instance.consortiaController.model.consortiaInfo.chairmanID == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            _loc6_ = OutyardManager.instance.model.myForce;
            if(_loc6_.remainAttackCount <= 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.scene.OutyardInfoView.declareNotEnough"));
            }
            else
            {
               SimpleAlertHelper.instance.data = [__declareOutyardHandler];
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc4_ = LanguageMgr.GetTranslation("public.prompt");
               _loc5_ = LanguageMgr.GetTranslation("outyard.scene.OutyardInfoView.declareClick",_loc6_.remainAttackCount);
               SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardFrame.consortiaDeclare"));
         }
      }
      
      private function __declareOutyardHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            OutyardManager.instance.OperateMapOutyard(4,_info.id);
         }
      }
      
      private function __mySignHandler(param1:NotificationEvent) : void
      {
         info = _info;
      }
      
      private function __updateNodeHandler(param1:NotificationEvent) : void
      {
         info = _info;
      }
      
      public function set info(param1:LandPoint) : void
      {
         var _loc10_:OutyardForceInfo = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc13_:LandPoint = null;
         var _loc14_:String = null;
         var _loc11_:String = null;
         var _loc16_:String = null;
         var _loc5_:String = null;
         var _loc3_:HugeHeadMySignInStateMsg = null;
         var _loc2_:HugeHeadStateMsg = null;
         var _loc9_:int = 0;
         var _loc4_:HugeHeadOpenTimeMsg = null;
         var _loc12_:int = 0;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc15_:int = 0;
         _info = param1;
         _bgVs.visible = false;
         _bgPeace.visible = false;
         _bgCrystal.visible = false;
         _landInfoImage2.visible = false;
         _landInfoSword.visible = false;
         _kenengBmp.visible = false;
         _bukeBmp.visible = false;
         _hepingzhuangtaiBmp.visible = false;
         _xuanzhantonggaoBmp.visible = false;
         _stateImage.visible = false;
         _vsBmp.visible = false;
         _nodeForceTxt.text = LanguageMgr.GetTranslation("outyard.scene.OutyardInfoView.forceName" + _info.forceIndex);
         _crystalInformationTxt.text = "";
         _leftCountTxt.text = "";
         _leftTimeTxt.text = "";
         _joinTxt.text = "";
         _joinTxt2.text = "";
         _landInfoImage2.setFrame(_info.forceIndex);
         _blockImage1.visible = false;
         _blockImage2.visible = false;
         _jinxingxuanzhanBtn.visible = false;
         _hepingguanbiBtn.visible = false;
         _guanbiBtn.visible = false;
         _caijiBtn.visible = false;
         _keyicanzhanBtn.visible = false;
         _keyicanzhanBtn2.visible = false;
         _jinruBtn.visible = false;
         if(_info.nodeType == 1)
         {
            _bgPeace.visible = true;
            _landInfoImage2.visible = true;
            _bukeBmp.visible = true;
            _hepingzhuangtaiBmp.visible = true;
            _xuanzhantonggaoBmp.visible = true;
            _jinxingxuanzhanBtn.visible = true;
            _hepingguanbiBtn.visible = true;
         }
         else if(_info.nodeType == 2)
         {
            if(_info.nodeState == 0)
            {
               _bgPeace.visible = true;
               _landInfoImage2.visible = true;
               _kenengBmp.visible = true;
               _bukeBmp.visible = true;
               _hepingzhuangtaiBmp.visible = true;
               _xuanzhantonggaoBmp.visible = true;
               _jinxingxuanzhanBtn.visible = true;
               _hepingguanbiBtn.visible = true;
               _leftCountTxt.text = LanguageMgr.GetTranslation("outyard.OutyardInfoView.remainAttackCount",OutyardManager.instance.model.myForce.remainAttackCount);
               _loc10_ = OutyardManager.instance.model.myForce;
               _loc6_ = _loc10_.forceIndex != _info.forceIndex;
               _loc8_ = 0;
               while(_loc8_ < _info.lineArr.length)
               {
                  _loc13_ = OutyardManager.instance.model.nodeDic[_info.lineArr[_loc8_]];
                  if(_loc13_.forceIndex == _loc10_.forceIndex)
                  {
                     _loc7_ = true;
                  }
                  _loc8_++;
               }
               _kenengBmp.visible = _loc6_ && _loc7_;
               _bukeBmp.visible = !_kenengBmp.visible;
            }
            else if(_info.nodeState == 2)
            {
               _bgVs.visible = true;
               _landInfoImage2.visible = true;
               _landInfoSword.visible = true;
               _vsBmp.visible = true;
               _stateImage.visible = true;
               _blockImage1.visible = true;
               _blockImage2.visible = true;
               _stateImage.setFrame(1);
               _blockImage1.setFrame(_info.attackForce);
               _blockImage2.setFrame(_info.defenceForce);
               _keyicanzhanBtn.visible = true;
               _keyicanzhanBtn2.visible = true;
               _guanbiBtn.visible = true;
               _leftTimeTxt.text = _info.leftTime;
               _loc14_ = LanguageMgr.GetTranslation("outyard.scene.OutyardInfoView.forceName" + _info.attackForce);
               _joinTxt.htmlText = LanguageMgr.GetTranslation("outyard.OutyardInfoView.joinTxt1",_loc14_,_info.attackCount);
               _loc11_ = LanguageMgr.GetTranslation("outyard.scene.OutyardInfoView.forceName" + _info.defenceForce);
               _joinTxt2.htmlText = LanguageMgr.GetTranslation("outyard.OutyardInfoView.joinTxt2",_loc11_,_info.defenceCount);
            }
            else if(_info.nodeState == 3)
            {
               _bgVs.visible = true;
               _landInfoImage2.visible = true;
               _landInfoSword.visible = true;
               _vsBmp.visible = true;
               _stateImage.visible = true;
               _blockImage1.visible = true;
               _blockImage2.visible = true;
               _stateImage.setFrame(2);
               _blockImage1.setFrame(_info.attackForce);
               _blockImage2.setFrame(_info.defenceForce);
               _keyicanzhanBtn.visible = true;
               _keyicanzhanBtn2.visible = true;
               _guanbiBtn.visible = true;
               _leftTimeTxt.text = _info.leftTime;
               _loc16_ = LanguageMgr.GetTranslation("outyard.scene.OutyardInfoView.forceName" + _info.attackForce);
               _joinTxt.htmlText = LanguageMgr.GetTranslation("outyard.OutyardInfoView.joinTxt1",_loc16_,_info.attackCount);
               _loc5_ = LanguageMgr.GetTranslation("outyard.scene.OutyardInfoView.forceName" + _info.defenceForce);
               _joinTxt2.htmlText = LanguageMgr.GetTranslation("outyard.OutyardInfoView.joinTxt2",_loc5_,_info.defenceCount);
            }
         }
         else if(_info.nodeType == 3)
         {
            _bgCrystal.visible = true;
            _landInfoSword.visible = true;
            _stateImage.visible = true;
            _jinruBtn.visible = true;
            _caijiBtn.visible = true;
            _nodeForceTxt.text = "";
            _loc3_ = OutyardManager.instance.model.signInMsg;
            _crystalInformationTxt.text = LanguageMgr.GetTranslation("outyard.OutyardInfoView.crystalInformationTxt",_loc3_.digTodayRemainCount + _loc3_.digExtraCount);
            _loc2_ = OutyardManager.instance.model.stateMsg;
            if(_loc2_.stackHeadState == 2)
            {
               _stateImage.setFrame(1);
            }
            else if(_loc2_.stackHeadState == 3)
            {
               _stateImage.setFrame(2);
            }
            else
            {
               _stateImage.setFrame(3);
            }
            _loc9_ = _loc2_.stackHeadSession - 1 < 0 ? 0 : _loc2_.stackHeadSession - 1;
            _loc4_ = _loc2_.stackHeadOpenTime[_loc9_] as HugeHeadOpenTimeMsg;
            if(!_loc4_)
            {
               return;
            }
            _loc17_ = Number(Int64Utils.int64ToNumber(_loc4_.startTime));
            _loc18_ = Number(Int64Utils.int64ToNumber(_loc4_.endTime));
            if(_loc17_ / 1000 > playerModel.sysSecond)
            {
               _loc12_ = _loc17_ / 1000 - playerModel.sysSecond;
            }
            else
            {
               _loc12_ = _loc18_ / 1000 - playerModel.sysSecond;
            }
            _loc15_ = _loc12_ / 60;
            if(_loc15_ <= 0)
            {
               _loc15_ = 0;
            }
            _leftTimeTxt.text = LanguageMgr.GetTranslation("map.internals.view.frame.FieldInfoView.remainintTimeFrameTextText") + ":" + (int(_loc15_ / 60) <= 0 ? LanguageMgr.GetTranslation("public.needMinutes",_loc15_ % 60) : LanguageMgr.GetTranslation("public.needHM",int(_loc15_ / 60),_loc15_ % 60));
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bgVs);
         _bgVs = null;
         ObjectUtils.disposeObject(_bgPeace);
         _bgPeace = null;
         ObjectUtils.disposeObject(_bgCrystal);
         _bgCrystal = null;
         ObjectUtils.disposeObject(_landInfoImage2);
         _landInfoImage2 = null;
         ObjectUtils.disposeObject(_landInfoSword);
         _landInfoSword = null;
         ObjectUtils.disposeObject(_stateImage);
         _stateImage = null;
         ObjectUtils.disposeObject(_blockImage1);
         _blockImage1 = null;
         ObjectUtils.disposeObject(_blockImage2);
         _blockImage2 = null;
         ObjectUtils.disposeObject(_vsBmp);
         _vsBmp = null;
         ObjectUtils.disposeObject(_kenengBmp);
         _kenengBmp = null;
         ObjectUtils.disposeObject(_bukeBmp);
         _bukeBmp = null;
         ObjectUtils.disposeObject(_hepingzhuangtaiBmp);
         _hepingzhuangtaiBmp = null;
         ObjectUtils.disposeObject(_xuanzhantonggaoBmp);
         _xuanzhantonggaoBmp = null;
         ObjectUtils.disposeObject(_nodeForceTxt);
         _nodeForceTxt = null;
         ObjectUtils.disposeObject(_crystalInformationTxt);
         _crystalInformationTxt = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_joinTxt);
         _joinTxt = null;
         ObjectUtils.disposeObject(_joinTxt2);
         _joinTxt2 = null;
         ObjectUtils.disposeObject(_jinxingxuanzhanBtn);
         _jinxingxuanzhanBtn = null;
         ObjectUtils.disposeObject(_hepingguanbiBtn);
         _hepingguanbiBtn = null;
         ObjectUtils.disposeObject(_guanbiBtn);
         _guanbiBtn = null;
         ObjectUtils.disposeObject(_caijiBtn);
         _caijiBtn = null;
         ObjectUtils.disposeObject(_keyicanzhanBtn);
         _keyicanzhanBtn = null;
         ObjectUtils.disposeObject(_keyicanzhanBtn2);
         _keyicanzhanBtn2 = null;
         ObjectUtils.disposeObject(_jinruBtn);
         _jinruBtn = null;
         _info = null;
         super.dispose();
      }
   }
}

