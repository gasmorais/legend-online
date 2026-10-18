package buildings.transferbuilding.view
{
   import buildings.transferbuilding.view.planesbag.PlanesBagFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.frame.planeswar.PlanesResourceFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PlanesListView extends Sprite implements Disposeable
   {
      
      private var _titleBg:Bitmap;
      
      private var _splitterBar:Image;
      
      private var _planesImage:Image;
      
      private var _incomeTextImage:Bitmap;
      
      private var _rightBack:Image;
      
      private var _planesCount:FilterFrameText;
      
      private var _energyCount:FilterFrameText;
      
      private var _resiText:FilterFrameText;
      
      private var addEnergyBtn:IconButton;
      
      private var getRewardBtn:BaseButton;
      
      private var sacrificeBtn:BaseButton;
      
      private var planesBagBtn:IconButton;
      
      private var itemVBox:VBox;
      
      private var rewardsGoodsHbox:HBox;
      
      private var planesList:Array;
      
      private var itemObj:Object = {};
      
      private var rewardObj:Object = {};
      
      private var energyLimitInfo:ConfigInfosTempInfo;
      
      private var energyCostInfo:ConfigInfosTempInfo;
      
      private var totalRewardDic:SimpleDictionary;
      
      private var totalPlanesRewardDic:SimpleDictionary;
      
      private var infoTipsView:MovieClip;
      
      private var _limitInfo:ConfigInfosTempInfo;
      
      private var _needGoodsInfo:ConfigInfosTempInfo;
      
      public function PlanesListView()
      {
         super();
         totalRewardDic = new SimpleDictionary();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.planesListView.titleImage");
         _splitterBar = ComponentFactory.Instance.creatComponentByStylename("planesListView.splitterBarImage");
         _planesImage = ComponentFactory.Instance.creatComponentByStylename("planesListView.planesTextImage");
         _incomeTextImage = ComponentFactory.Instance.creatBitmap("asset.planesItemView.IncomeTxt");
         _rightBack = ComponentFactory.Instance.creatComponentByStylename("planesListView.rightBack");
         _planesCount = ComponentFactory.Instance.creatComponentByStylename("planesItemView.planesCount");
         _energyCount = ComponentFactory.Instance.creatComponentByStylename("planesItemView.energyCount");
         _resiText = ComponentFactory.Instance.creatComponentByStylename("planesItemView.resiText");
         addEnergyBtn = ComponentFactory.Instance.creatComponentByStylename("planesItemView.addEnergyBtn");
         getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("planesItemView.getRewardBtn");
         sacrificeBtn = ComponentFactory.Instance.creatComponentByStylename("planesItemView.sacrificeBtn");
         planesBagBtn = ComponentFactory.Instance.creatComponentByStylename("planesListView.planesBagBtn");
         infoTipsView = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         infoTipsView.mouseChildren = infoTipsView.mouseEnabled = false;
         sacrificeBtn.addChild(infoTipsView);
         _limitInfo = TempleteManager.instance.getConfigInfoByConfigName("sacrifice_max_times");
         _needGoodsInfo = TempleteManager.instance.getConfigInfoByConfigName("sacrifice_items_reward");
         itemVBox = ComponentFactory.Instance.creatComponentByStylename("planesListView.itemVBox");
         rewardsGoodsHbox = ComponentFactory.Instance.creatComponentByStylename("planesListView.rewardsGoodsHbox");
         addChild(_rightBack);
         addChild(_titleBg);
         addChild(_splitterBar);
         addChild(_planesImage);
         addChild(_incomeTextImage);
         addChild(_planesCount);
         addChild(_energyCount);
         addChild(planesBagBtn);
         addChild(addEnergyBtn);
         addChild(getRewardBtn);
         addChild(sacrificeBtn);
         addChild(itemVBox);
         addChild(_resiText);
         addChild(rewardsGoodsHbox);
         energyLimitInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_buy_energy_limit");
         energyCostInfo = TempleteManager.instance.getConfigInfoByConfigName("planes_buy_energy");
         _planesImage.tipData = LanguageMgr.GetTranslation("planeswar.planesListView.planesTiptext");
         initItemVbox();
         refreshView(null);
         updateInfoTips(null);
      }
      
      private function updateInfoTips(param1:Event = null) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = int(_limitInfo.ConfigValue) - InfoTipsManager.instance.getValueByKey(24);
         var _loc7_:int = 0;
         var _loc3_:Array = _needGoodsInfo.ConfigValue.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = int(String(_loc3_[_loc5_]).split("&")[1]);
            _loc2_ = int(GoodsManager.instance.getGoodsNumByTempId(_loc4_));
            _loc7_ += _loc2_;
            _loc5_++;
         }
         if(_loc7_ < _loc6_)
         {
            _loc6_ = _loc7_;
         }
         infoTipsView.visible = false;
         if(_loc6_ > 0)
         {
            infoTipsView.visible = true;
            infoTipsView.txt.text = _loc6_;
         }
      }
      
      private function addEvent() : void
      {
         PlanesWarManager.instance.addEventListener("PLANES_INFO_UPDATE",refreshView);
         addEnergyBtn.addEventListener("click",__addEnergyClickHandler);
         getRewardBtn.addEventListener("click",__getRewardClickHandler);
         sacrificeBtn.addEventListener("click",__sacrificeBtnClickHandler);
         planesBagBtn.addEventListener("click",__planesBagClickHanlder);
      }
      
      private function removeEvent() : void
      {
         PlanesWarManager.instance.removeEventListener("PLANES_INFO_UPDATE",refreshView);
         if(addEnergyBtn)
         {
            addEnergyBtn.removeEventListener("click",__addEnergyClickHandler);
         }
         if(getRewardBtn)
         {
            getRewardBtn.removeEventListener("click",__getRewardClickHandler);
         }
         if(sacrificeBtn)
         {
            sacrificeBtn.removeEventListener("click",__sacrificeBtnClickHandler);
         }
         if(planesBagBtn)
         {
            planesBagBtn.removeEventListener("click",__planesBagClickHanlder);
         }
      }
      
      private function __sacrificeBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("sacrifice");
      }
      
      private function __planesBagClickHanlder(param1:MouseEvent) : void
      {
         var _loc2_:PlanesBagFrame = ComponentFactory.Instance.creatComponentByStylename("planeswar.planesListView.planesBagFrame");
         _loc2_.show();
      }
      
      private function __addEnergyClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(model.hasBuyEnergyCount > int(energyLimitInfo.ConfigValue))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planes.buyEnergy.hasEnough"));
            return;
         }
         var _loc3_:Array = energyCostInfo.ConfigValue.split(",");
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < _loc3_[0])
         {
            RechargeAlertMannager.show();
            return;
         }
         if(todayNeedAlertForBuy(SharedManager.instance.planesAddEnergyAlertDate))
         {
            showAddEnergyTips();
         }
         else
         {
            _loc2_ = 1;
            if(SharedManager.instance.planesAddEnergyUseBind)
            {
               _loc2_ = 2;
            }
            PlanesWarManager.instance.sendPlanesOpMsg(20,[_loc2_]);
         }
      }
      
      private function showAddEnergyTips() : void
      {
         var _loc5_:TodayNotAlertFrame = null;
         var _loc3_:Array = energyCostInfo.ConfigValue.split(",");
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation("planesWar.planesListView.AddEnergyTips",_loc3_[0],_loc3_[1]);
         var _loc2_:Boolean = true;
         _loc2_ = todayNeedAlertForBuy(SharedManager.instance.planesAddEnergyAlertDate);
         if(_loc2_)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc5_.show(_loc4_,_loc1_,__showAddEnergyTipResult,null,"center",2,true);
            return;
         }
      }
      
      private function __showAddEnergyTipResult(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.planesAddEnergyAlertDate = new Date();
            SharedManager.instance.saveAddEnergyAlertDate();
         }
         SharedManager.instance.planesAddEnergyUseBind = param2;
         SharedManager.instance.saveAddEnergyUseBind();
         var _loc3_:int = 1;
         if(SharedManager.instance.planesAddEnergyUseBind)
         {
            _loc3_ = 2;
         }
         PlanesWarManager.instance.sendPlanesOpMsg(20,[_loc3_]);
      }
      
      private function todayNeedAlertForBuy(param1:Date) : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         if(param1)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function __getRewardClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:PlanesResourceFrame = ComponentFactory.Instance.creatComponentByStylename("PlanesListView.PlanesResourceFrame");
         _loc2_.show();
      }
      
      private function initItemVbox() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlanesItemView = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new PlanesItemView();
            itemVBox.addChild(_loc1_);
            itemObj[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function refreshView(param1:PlanesWarEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:PlanesItemView = null;
         var _loc12_:PlanesInfo = null;
         var _loc4_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         var _loc8_:int = 0;
         planesList = model.planesInfoList;
         rewardsGoodsHbox.removeAllChild();
         var _loc9_:String = LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText");
         _planesCount.text = model.planesInfoList.length + "/" + model.maxPlanesCount;
         _energyCount.text = model.energyLeft.toString();
         var _loc10_:int = int(energyLimitInfo.ConfigValue) - model.hasBuyEnergyCount;
         addEnergyBtn.tipData = LanguageMgr.GetTranslation("planeswar.planesListView.addEnergyBtnTiptext",_loc10_);
         totalPlanesRewardDic = new SimpleDictionary();
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc2_ = itemObj[_loc6_];
            _loc12_ = planesList[_loc6_];
            if(!_loc2_)
            {
               _loc2_ = new PlanesItemView();
               itemObj[_loc6_] = _loc2_;
            }
            if(_loc6_ < planesList.length)
            {
               _loc2_.data = _loc12_;
               if(!model.checkDicIsEmpty(model.getSinglePlanesRewardsById(_loc12_.planesId)))
               {
                  totalPlanesRewardDic[_loc12_.planesId] = model.getSinglePlanesRewardsById(_loc12_.planesId);
               }
            }
            else
            {
               _loc2_.data = null;
            }
            _loc6_++;
         }
         var _loc3_:Object = {};
         _loc3_.dic = totalPlanesRewardDic;
         totalRewardDic = model.getTotalRewards();
         for(var _loc11_:String in totalRewardDic)
         {
            if(_loc11_)
            {
               if(parseInt(_loc11_) >= 1 && parseInt(_loc11_) <= 7)
               {
                  if(totalRewardDic[_loc11_] != 0)
                  {
                     _loc9_ += LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText" + _loc11_,totalRewardDic[_loc11_]) + "  ";
                  }
               }
               else
               {
                  _loc4_ = rewardObj[_loc11_];
                  if(!_loc4_)
                  {
                     _loc4_ = ComponentFactory.Instance.creatCustomObject("planesListView.BaseItemView");
                     rewardObj[_loc11_] = _loc4_;
                  }
                  _loc7_ = new GoodsInfo();
                  _loc7_.templateId = parseInt(_loc11_);
                  _loc7_.count = totalRewardDic[_loc11_];
                  _loc4_.data = _loc7_;
                  rewardsGoodsHbox.addChild(_loc4_);
               }
            }
         }
         var _loc5_:Boolean = false;
         _loc8_ = 1;
         while(_loc8_ < 8)
         {
            if(totalRewardDic[_loc8_] && totalRewardDic[_loc8_] != 0)
            {
               _loc5_ = true;
               break;
            }
            _loc8_++;
         }
         if(!_loc5_)
         {
            _resiText.htmlText = "";
         }
         else
         {
            _resiText.htmlText = _loc9_;
         }
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         model.planesInfoList = [];
         if(itemObj)
         {
            for(var _loc2_:String in itemObj)
            {
               ObjectUtils.disposeObject(itemObj[_loc2_]);
               itemObj[_loc2_] = null;
            }
            itemObj = null;
         }
         if(rewardObj)
         {
            for(var _loc1_:String in rewardObj)
            {
               ObjectUtils.disposeObject(rewardObj[_loc1_]);
               rewardObj[_loc1_] = null;
            }
            rewardObj = null;
         }
         if(_titleBg)
         {
            ObjectUtils.disposeObject(_titleBg);
         }
         _titleBg = null;
         if(_splitterBar)
         {
            ObjectUtils.disposeObject(_splitterBar);
         }
         _splitterBar = null;
         if(_planesImage)
         {
            ObjectUtils.disposeObject(_planesImage);
         }
         _planesImage = null;
         if(_incomeTextImage)
         {
            ObjectUtils.disposeObject(_incomeTextImage);
         }
         _incomeTextImage = null;
         if(_rightBack)
         {
            ObjectUtils.disposeObject(_rightBack);
         }
         _rightBack = null;
         if(_planesCount)
         {
            ObjectUtils.disposeObject(_planesCount);
         }
         _planesCount = null;
         if(_energyCount)
         {
            ObjectUtils.disposeObject(_energyCount);
         }
         _energyCount = null;
         if(_resiText)
         {
            ObjectUtils.disposeObject(_resiText);
         }
         _resiText = null;
         if(addEnergyBtn)
         {
            ObjectUtils.disposeObject(addEnergyBtn);
         }
         addEnergyBtn = null;
         if(getRewardBtn)
         {
            ObjectUtils.disposeObject(getRewardBtn);
         }
         getRewardBtn = null;
         if(itemVBox)
         {
            ObjectUtils.disposeObject(itemVBox);
         }
         itemVBox = null;
         if(rewardsGoodsHbox)
         {
            ObjectUtils.disposeObject(rewardsGoodsHbox);
         }
         rewardsGoodsHbox = null;
         if(planesBagBtn)
         {
            ObjectUtils.disposeObject(planesBagBtn);
         }
         planesBagBtn = null;
         ObjectUtils.disposeObject(infoTipsView);
         infoTipsView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

