package outyard.scene
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.hugehead.StackHeadSelfMsg;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardInfoTopView extends Component
   {
      
      private var _bgTop:Bitmap;
      
      private var _landMapName:ScaleFrameImage;
      
      private var _landInfoImage1:ScaleFrameImage;
      
      private var _topBack:Bitmap;
      
      private var _zhanlingshuBmp:Bitmap;
      
      private var _occupyStrip:StripView;
      
      private var _forceNameTxt:FilterFrameText;
      
      private var _occupyNumTxt:FilterFrameText;
      
      private var _dikuangBmp:ScaleBitmapImage;
      
      private var _tansuoliBmp:Bitmap;
      
      private var _xingdongliBmp:Bitmap;
      
      private var _numBg1:Image;
      
      private var _numBg2:Image;
      
      private var _shopBtn:BaseButton;
      
      private var _addBtn1:BaseButton;
      
      private var _addBtn2:BaseButton;
      
      private var _tansuoNumTxt:FilterFrameText;
      
      private var _xingdongNumTxt:FilterFrameText;
      
      private var _executionStrip:StripView;
      
      private var _exploreStrip:StripView;
      
      public function OutyardInfoTopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bgTop = ComponentFactory.Instance.creatBitmap("asset.outyard.landInfoBgYellow");
         _topBack = ComponentFactory.Instance.creatBitmap("asset.outyard.topBack");
         _occupyStrip = ComponentFactory.Instance.creatCustomObject("outyard.occupyStrip");
         _zhanlingshuBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.zhanlingshuBmp");
         _landMapName = ComponentFactory.Instance.creatComponentByStylename("outyard.landMapName");
         _landInfoImage1 = ComponentFactory.Instance.creatComponentByStylename("outyard.landInfoImage1");
         _forceNameTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.forceNameTxt");
         _occupyNumTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoView.occupyNumTxt");
         _occupyStrip.setHitArea(0,0,100,23);
         _dikuangBmp = ComponentFactory.Instance.creatComponentByStylename("outyard.dikuangxiaoBmp");
         _tansuoliBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.tansuoliBmp");
         _xingdongliBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.xingdongliBmp");
         _numBg1 = ComponentFactory.Instance.creatComponentByStylename("outyard.tansuoliBg1");
         _numBg2 = ComponentFactory.Instance.creatComponentByStylename("outyard.tansuoliBg2");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.waiyushangdianBmp");
         _addBtn1 = ComponentFactory.Instance.creatComponentByStylename("outyard.goumaijiaBmp1");
         _addBtn2 = ComponentFactory.Instance.creatComponentByStylename("outyard.goumaijiaBmp2");
         _tansuoNumTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoTopView.tansuoNumTxt");
         _xingdongNumTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardInfoTopView.xingdongNumTxt");
         _executionStrip = ComponentFactory.Instance.creatCustomObject("outyard.OutyardInfoTopView.executionStrip");
         _exploreStrip = ComponentFactory.Instance.creatCustomObject("outyard.OutyardInfoTopView.exploreStrip");
         addChild(_bgTop);
         addChild(_topBack);
         addChild(_zhanlingshuBmp);
         addChild(_occupyStrip);
         addChild(_landMapName);
         addChild(_landInfoImage1);
         addChild(_forceNameTxt);
         addChild(_occupyNumTxt);
         addChild(_dikuangBmp);
         addChild(_tansuoliBmp);
         addChild(_xingdongliBmp);
         addChild(_numBg1);
         addChild(_numBg2);
         addChild(_shopBtn);
         addChild(_addBtn1);
         addChild(_addBtn2);
         addChild(_tansuoNumTxt);
         addChild(_xingdongNumTxt);
         addChild(_executionStrip);
         addChild(_exploreStrip);
         setTips();
      }
      
      private function addEvent() : void
      {
         _addBtn1.addEventListener("click",__addClickHandler1);
         _addBtn2.addEventListener("click",__addClickHandler2);
         _shopBtn.addEventListener("click",__shopBtnHandler);
         NotificationManager.instance.addEventListener("PLAYER_EXTRA_FIELD",__refreshHandler);
         NotificationManager.instance.addEventListener("OUTYARD_SELF_INFO",__refreshHandler);
         __refreshHandler(null);
      }
      
      private function removeEvent() : void
      {
         _addBtn1.removeEventListener("click",__addClickHandler1);
         _addBtn2.removeEventListener("click",__addClickHandler2);
         _shopBtn.removeEventListener("click",__shopBtnHandler);
         NotificationManager.instance.removeEventListener("PLAYER_EXTRA_FIELD",__refreshHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_SELF_INFO",__refreshHandler);
      }
      
      private function __addClickHandler1(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(OutyardManager.instance.areaModel.exploreNum >= ConfigInfoManager.instance.getHugeHeadExplorePoint())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.scene.OutyardAreaDiceView.exploreMax"));
            return;
         }
         showRefreshAlertAlert();
      }
      
      private function showRefreshAlertAlert() : void
      {
         var _loc3_:Array = ConfigInfoManager.instance.hugeHeadExploreChargePoint();
         var _loc4_:int = int(_loc3_[0]);
         SimpleAlertHelper.instance.data = [showRefreshAlertAlertBack,_loc4_];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("outyard.OutyardFrame.addExploreTxt",_loc4_,_loc3_[1]);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc1_,_loc2_,true,true,false,2,"USEBINDPOINT_ALERT");
      }
      
      private function showRefreshAlertAlertBack(param1:Boolean, param2:Boolean, param3:int) : void
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
      
      private function __addClickHandler2(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         SoundManager.instance.play("022");
         var _loc7_:int = int(ConfigInfoManager.instance.getStackHeadChargePoint());
         var _loc8_:Array = ConfigInfoManager.instance.getStackHeadActionPoint();
         var _loc5_:String = "";
         if(thane.grades >= 1 && thane.grades <= 79)
         {
            _loc5_ = _loc8_[0];
         }
         else if(thane.grades == 80)
         {
            if(ArmyManager.instance.thane.vocationGrades <= 0)
            {
               _loc5_ = _loc8_[1];
            }
            else
            {
               _loc5_ = _loc8_[2];
            }
         }
         var _loc4_:int = int(_loc5_.split(",")[0]);
         var _loc6_:StackHeadSelfMsg = OutyardManager.instance.crystalModel.selfMsg;
         if(_loc6_.actionPoint >= _loc4_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardFrame.limitCannotBuy"));
            return;
         }
         if(_loc7_ > PlayerManager.instance.currentPlayerModel.playerInfo.point)
         {
            RechargeAlertMannager.show();
            return;
         }
         SimpleAlertHelper.instance.data = [__alertOutyardHandler];
         _loc2_ = LanguageMgr.GetTranslation("public.confirm");
         _loc3_ = LanguageMgr.GetTranslation("public.cancel");
         _loc9_ = LanguageMgr.GetTranslation("public.prompt");
         _loc10_ = LanguageMgr.GetTranslation("outyard.OutyardFrame.addExecutionTxt",_loc7_,_loc4_);
         SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc10_,_loc2_,_loc3_,true);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __alertOutyardHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            OutyardManager.instance.OperateOutyard(10);
         }
      }
      
      private function __shopBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",1004);
      }
      
      private function __refreshHandler(param1:Event) : void
      {
         _tansuoNumTxt.text = OutyardManager.instance.areaModel.exploreNum + "";
         if(OutyardManager.instance.crystalModel.selfMsg)
         {
            _xingdongNumTxt.text = OutyardManager.instance.crystalModel.selfMsg.actionPoint + "";
         }
      }
      
      public function setMapId(param1:int) : void
      {
         if(!OutyardManager.instance.model.myForce)
         {
            return;
         }
         _forceNameTxt.text = LanguageMgr.GetTranslation("outyard.scene.OutyardInfoView.forceName" + OutyardManager.instance.model.myForce.forceIndex);
         _occupyNumTxt.text = OutyardManager.instance.model.occupyNum + "";
         _landInfoImage1.setFrame(OutyardManager.instance.model.myForce.forceIndex);
         _landMapName.setFrame(param1);
      }
      
      private function setTips() : void
      {
         var _loc6_:Array = ConfigInfoManager.instance.getStackHeadActionPoint();
         var _loc2_:String = "";
         if(thane.grades >= 1 && thane.grades <= 79)
         {
            _loc2_ = _loc6_[0];
         }
         else if(thane.grades == 80)
         {
            if(ArmyManager.instance.thane.vocationGrades <= 0)
            {
               _loc2_ = _loc6_[1];
            }
            else
            {
               _loc2_ = _loc6_[2];
            }
         }
         var _loc1_:int = int(_loc2_.split(",")[0]);
         var _loc3_:int = int(_loc2_.split(",")[1]);
         var _loc4_:int = int(ConfigInfoManager.instance.getStackHeadChargePoint());
         _executionStrip.setHitArea(0,0,56,20);
         _executionStrip.tipData = LanguageMgr.GetTranslation("outyard.OutyardFrame.limitExecutionTxt",_loc1_,_loc3_);
         _exploreStrip.setHitArea(0,0,56,20);
         _exploreStrip.tipData = LanguageMgr.GetTranslation("outyard.OutyardFrame.exploreTxt");
         var _loc5_:String = LanguageMgr.GetTranslation("outyard.OutyardMapFrame.occupyStrip");
         _occupyStrip.tipData = _loc5_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bgTop);
         _bgTop = null;
         ObjectUtils.disposeObject(_topBack);
         _topBack = null;
         ObjectUtils.disposeObject(_zhanlingshuBmp);
         _zhanlingshuBmp = null;
         ObjectUtils.disposeObject(_occupyStrip);
         _occupyStrip = null;
         ObjectUtils.disposeObject(_landMapName);
         _landMapName = null;
         ObjectUtils.disposeObject(_landInfoImage1);
         _landInfoImage1 = null;
         ObjectUtils.disposeObject(_forceNameTxt);
         _forceNameTxt = null;
         ObjectUtils.disposeObject(_occupyNumTxt);
         _occupyNumTxt = null;
         ObjectUtils.disposeObject(_dikuangBmp);
         _dikuangBmp = null;
         ObjectUtils.disposeObject(_tansuoliBmp);
         _tansuoliBmp = null;
         ObjectUtils.disposeObject(_xingdongliBmp);
         _xingdongliBmp = null;
         ObjectUtils.disposeObject(_numBg1);
         _numBg1 = null;
         ObjectUtils.disposeObject(_numBg2);
         _numBg2 = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_addBtn1);
         _addBtn1 = null;
         ObjectUtils.disposeObject(_addBtn2);
         _addBtn2 = null;
         ObjectUtils.disposeObject(_tansuoNumTxt);
         _tansuoNumTxt = null;
         ObjectUtils.disposeObject(_xingdongNumTxt);
         _xingdongNumTxt = null;
         ObjectUtils.disposeObject(_executionStrip);
         _executionStrip = null;
         ObjectUtils.disposeObject(_exploreStrip);
         _exploreStrip = null;
         super.dispose();
      }
   }
}

