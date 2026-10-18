package perkinlab
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.PerkinLabManager;
   import mvc.module.perkinlab.PerkinLabKengInfo;
   import mvc.module.perkinlab.PerkinLabModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class PerkinLabKengView extends Component
   {
      
      private var kengMc:MovieClip;
      
      private var tipContiner:Component;
      
      private var getRewardBtn:IconButton;
      
      private var robImage:Bitmap;
      
      private var robOverImage:Bitmap;
      
      private var lookPlayerContiner:Component;
      
      private var nameText:FilterFrameText;
      
      private var lookBack:Bitmap;
      
      private var lookBtn:BaseButton;
      
      private var _data:PerkinLabKengInfo;
      
      private var type:int = -1;
      
      private var _buildingFilter:SimpleBuildingFilter;
      
      private var robMaxCount:int;
      
      private var _timer:Timer;
      
      private var tipObj:Object = {};
      
      public function PerkinLabKengView(param1:int)
      {
         super();
         robMaxCount = ConfigInfoManager.instance.getPerkibnRobMaxCount();
         type = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         kengMc = ComponentFactory.Instance.creatCustomObject("PerkinLabKengView.kengMc" + type);
         getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("PerkinLabKengView.getRewardBtn");
         robImage = ComponentFactory.Instance.creatBitmap("asset.PerkinLabKengView.robBtnImage");
         robOverImage = ComponentFactory.Instance.creatBitmap("asset.PerkinLabKengView.robOverImage");
         lookPlayerContiner = ComponentFactory.Instance.creatComponentByStylename("PerkinLabKengView.lookPlayerContiner");
         lookBack = ComponentFactory.Instance.creatBitmap("asset.PerkinLabKengView.lookBack");
         nameText = ComponentFactory.Instance.creatComponentByStylename("PerkinLabKengView.robNameText");
         lookBtn = ComponentFactory.Instance.creatComponentByStylename("PerkinLabKengView.lookBtn");
         tipContiner = ComponentFactory.Instance.creatComponentByStylename("PerkinLabKengView.tipContiner");
         addChild(tipContiner);
         addChild(getRewardBtn);
         getRewardBtn.visible = false;
         addChild(lookPlayerContiner);
         lookPlayerContiner.addChild(lookBack);
         lookPlayerContiner.addChild(nameText);
         lookPlayerContiner.addChild(lookBtn);
         tipContiner.addChild(kengMc);
         tipContiner.addChild(robImage);
         tipContiner.addChild(robOverImage);
         lookPlayerContiner.mouseEnabled = false;
         lookBtn.tipData = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.info");
         _buildingFilter = new SimpleBuildingFilter();
         _timer = new Timer(1000);
         clean();
         setHitArea();
      }
      
      private function setHitArea() : void
      {
         var _loc2_:Sprite = null;
         var _loc1_:BitmapData = null;
         if(kengMc["effect_area"])
         {
            _loc1_ = new BitmapData(kengMc["effect_area"].width,kengMc["effect_area"].height,true,0);
            _loc1_.draw(kengMc["effect_area"]);
            _loc2_ = DisplayUtils.getHitArea(_loc1_,5);
            tipContiner.hitArea = _loc2_;
            tipContiner.addChild(_loc2_);
            tipContiner.mouseChildren = false;
            kengMc.mouseChildren = kengMc.mouseEnabled = false;
         }
      }
      
      private function addEvent() : void
      {
         getRewardBtn.addEventListener("click",__getRewardClickHandler);
         lookBtn.addEventListener("click",__lookClickHandler);
         tipContiner.addEventListener("mouseOver",mouseOverHandler);
         tipContiner.addEventListener("mouseOut",mouseOutHandler);
         tipContiner.addEventListener("click",mouseClickHandler);
      }
      
      private function giveHandler() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("perkinlab.giveUp.Alert",LanguageMgr.GetTranslation("PerkinLabEventItem.event.sizeText"));
         SimpleAlertHelper.instance.data = [giveUpResultHandler];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc1_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
      }
      
      private function giveUpResultHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            PerkinLabManager.instance.sendLabOperate(3,_data.index);
         }
      }
      
      private function __getRewardClickHandler(param1:MouseEvent) : void
      {
         PerkinLabManager.instance.sendLabOperate(4,_data.index);
      }
      
      private function robHandler() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = robMaxCount - model.robCount;
         if(_loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PerkinLabKengView.robBtn.alert"));
            return;
         }
         _loc1_ = LanguageMgr.GetTranslation("perkinlab.rob.Alert",_data.thane.nickName,LanguageMgr.GetTranslation("PerkinLabEventItem.event.sizeText"));
         SimpleAlertHelper.instance.data = [robResultHandler];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc1_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true,true);
      }
      
      private function robResultHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            PerkinLabManager.instance.sendLabOperate(5,_data.index);
         }
      }
      
      private function __lookClickHandler(param1:MouseEvent) : void
      {
         PlayerInfoManager.instance.show(_data.thane,10000);
      }
      
      private function __updateHarvestTimeHandler(param1:TimerEvent) : void
      {
         if(playerModel.sysSecond >= _data.harvestTime)
         {
            getRewardBtn.visible = true;
            _timer.removeEventListener("timer",__updateHarvestTimeHandler);
            _timer.stop();
         }
         else
         {
            getRewardBtn.visible = false;
         }
         refreshTipData();
      }
      
      public function set data(param1:PerkinLabKengInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         clean();
         if(!_data)
         {
            return;
         }
         if(type == 0)
         {
            __updateHarvestTimeHandler(null);
            _timer.addEventListener("timer",__updateHarvestTimeHandler);
            _timer.reset();
            _timer.start();
         }
         else
         {
            lookPlayerContiner.visible = true;
            nameText.text = _data.thane.nickName;
            if(_data.robState == 0)
            {
               tipContiner.buttonMode = true;
               robImage.visible = false;
            }
            else
            {
               tipContiner.buttonMode = false;
               robOverImage.visible = true;
            }
         }
         refreshTipData();
      }
      
      private function refreshTipData() : void
      {
         if(!_data)
         {
            return;
         }
         tipObj.type = type;
         if(playerModel.sysSecond >= _data.harvestTime)
         {
            tipObj.time = LanguageMgr.GetTranslation("PerkinLabKengTip.timeText.text",LanguageMgr.GetTranslation("PerkinLabKengView.harvestTime.text"));
         }
         else
         {
            tipObj.time = LanguageMgr.GetTranslation("PerkinLabKengTip.timeText.text",DateFormatter.getFullTimeString(_data.harvestTime - playerModel.sysSecond));
         }
         if(type == 1)
         {
            tipObj.reward = _data.robReward;
         }
         else
         {
            tipObj.reward = model.getRewardStrByMissing(_data.missingReward);
         }
         tipContiner.tipData = tipObj;
      }
      
      private function clean() : void
      {
         getRewardBtn.visible = false;
         lookPlayerContiner.visible = false;
         robImage.visible = false;
         robOverImage.visible = false;
         if(_timer)
         {
            _timer.removeEventListener("timer",__updateHarvestTimeHandler);
            _timer.stop();
         }
         tipData = null;
      }
      
      private function removeEvent() : void
      {
         if(getRewardBtn)
         {
            getRewardBtn.removeEventListener("click",__getRewardClickHandler);
         }
         if(tipContiner)
         {
            tipContiner.removeEventListener("mouseOver",mouseOverHandler);
            tipContiner.removeEventListener("mouseOut",mouseOutHandler);
            tipContiner.removeEventListener("click",mouseClickHandler);
         }
         if(_timer)
         {
            _timer.removeEventListener("timer",__updateHarvestTimeHandler);
         }
      }
      
      private function get model() : PerkinLabModel
      {
         return PerkinLabManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function mouseClickHandler(param1:MouseEvent) : void
      {
         if(model.robCdTime > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("perkinlab.rob.cdAlert"));
            return;
         }
         if(_data && _data.robState == 0 && type == 1)
         {
            robHandler();
         }
      }
      
      public function mouseOverHandler(param1:MouseEvent) : void
      {
         refreshTipData();
         if(_data && _data.robState == 0 && type == 1)
         {
            robImage.visible = true;
         }
         if(kengMc && kengMc["effect_area"])
         {
            _buildingFilter.setBuildingOverFilter(this.kengMc["effect_area"]);
         }
      }
      
      public function mouseOutHandler(param1:MouseEvent) : void
      {
         robImage.visible = false;
         if(kengMc && kengMc["effect_area"])
         {
            _buildingFilter.setBuildingOutFilter(this.kengMc["effect_area"]);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(getRewardBtn)
         {
            ObjectUtils.disposeObject(getRewardBtn);
         }
         getRewardBtn = null;
         if(robImage)
         {
            ObjectUtils.disposeObject(robImage);
         }
         robImage = null;
         if(robOverImage)
         {
            ObjectUtils.disposeObject(robOverImage);
         }
         robOverImage = null;
         if(nameText)
         {
            ObjectUtils.disposeObject(nameText);
         }
         nameText = null;
         if(lookBack)
         {
            ObjectUtils.disposeObject(lookBack);
         }
         lookBack = null;
         if(lookBtn)
         {
            ObjectUtils.disposeObject(lookBtn);
         }
         lookBtn = null;
         if(lookPlayerContiner)
         {
            ObjectUtils.disposeAllChildren(lookPlayerContiner);
            ObjectUtils.disposeObject(lookPlayerContiner);
            lookPlayerContiner = null;
         }
         if(kengMc)
         {
            ObjectUtils.disposeViolentMc(kengMc);
         }
         kengMc = null;
         if(tipContiner)
         {
            ObjectUtils.disposeAllChildren(tipContiner);
            ObjectUtils.disposeObject(tipContiner);
            tipContiner = null;
         }
         _timer = null;
         _buildingFilter = null;
         tipObj = null;
         super.dispose();
      }
   }
}

