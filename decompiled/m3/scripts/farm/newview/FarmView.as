package farm.newview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.data.FarmInfo;
   import farm.event.FarmEvent;
   import farm.net.FarmSocketSendManager;
   import farm.view.FarmLandLayer;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import water.view.WaterView;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.ArmyManager;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.tips.MessageTipManager;
   
   public class FarmView extends Component
   {
      
      private var _data:FarmInfo;
      
      private var _farmLandLayer:FarmLandLayer;
      
      private var _farmWaterView:WaterView;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      private var _landUpBtn:BaseButton;
      
      private var _landUpNameBg:MutipleImage;
      
      private var _landUpNameTxt:FilterFrameText;
      
      private var _landUpLevelTxt:FilterFrameText;
      
      private var _buildingFilter:SimpleBuildingFilter;
      
      public function FarmView()
      {
         super();
         initView();
         initBufferView();
         addEvent();
      }
      
      private function initView() : void
      {
         _farmLandLayer = ComponentFactory.Instance.creatCustomObject("farm.FarmLandLayer");
         _farmWaterView = ComponentFactory.Instance.creatCustomObject("farm.FarmWaterLayer");
         _landUpBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmBuildLayerLandUpBtn");
         _landUpNameBg = ComponentFactory.Instance.creatComponentByStylename("farm.BuildNameBg1");
         _landUpNameTxt = ComponentFactory.Instance.creatComponentByStylename("farm.BuildNameTxt1");
         _landUpLevelTxt = ComponentFactory.Instance.creatComponentByStylename("farm.BuildLevelTxt");
         addChild(_farmWaterView);
         addChild(_farmLandLayer);
         addChild(_landUpBtn);
         addChild(_landUpNameBg);
         addChild(_landUpNameTxt);
         addChild(_landUpLevelTxt);
         _landUpNameTxt.text = LanguageMgr.GetTranslation("farm.view.FarmBuildLayer.landUp");
         _buildingFilter = new SimpleBuildingFilter();
      }
      
      private function initBufferView() : void
      {
         var _loc1_:String = null;
         var _loc2_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(2);
         if(_loc2_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc2_);
            _bufferView.stopTimer();
            _loc1_ = LanguageMgr.GetTranslation("home.farmNewFrame.bufferText",_loc2_.tempInfo.AddValue);
            _bufferView.setDescText(_loc1_);
            _bufferView.x = 20;
            _bufferView.y = 80;
            addChild(_bufferView);
         }
      }
      
      private function addEvent() : void
      {
         _landUpBtn.addEventListener("click",__onLandUpClick);
         _landUpBtn.addEventListener("rollOver",__onBuildingOver);
         _landUpBtn.addEventListener("rollOut",__onBuildingOut);
      }
      
      private function removeEvent() : void
      {
         _landUpBtn.removeEventListener("click",__onLandUpClick);
         _landUpBtn.removeEventListener("rollOver",__onBuildingOver);
         _landUpBtn.removeEventListener("rollOut",__onBuildingOut);
         if(_data)
         {
            _data.removeEventListener("LAND_GRADE_CHANGE",__farmInfoUpdateHandler);
         }
      }
      
      private function __onLandUpClick(param1:MouseEvent) : void
      {
         if(_data)
         {
            if(_data.grade < 30)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.view.FarmBuildLayer.landUpOpenTip"));
               return;
            }
            if(_data.landGrade >= 10)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.view.FarmBuildLayer.maxLandLevelTip"));
               return;
            }
            FarmSocketSendManager.sendLandUp(_data.landGrade);
         }
      }
      
      public function set data(param1:FarmInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         if(_data)
         {
            _data.removeEventListener("LAND_GRADE_CHANGE",__farmInfoUpdateHandler);
         }
         _data = param1;
         _data.addEventListener("LAND_GRADE_CHANGE",__farmInfoUpdateHandler);
         refreshView();
      }
      
      private function __farmInfoUpdateHandler(param1:FarmEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         if(_data.userId == ArmyManager.instance.thane.userId)
         {
            _landUpBtn.mouseChildren = _landUpBtn.mouseEnabled = true;
            _landUpBtn.tipData = _data;
            if(_bufferView && _bufferView.parent)
            {
               _bufferView.resetTimer();
               _bufferView.visible = true;
            }
         }
         else
         {
            if(_bufferView && _bufferView.parent)
            {
               _bufferView.stopTimer();
               _bufferView.visible = false;
            }
            _landUpBtn.mouseChildren = _landUpBtn.mouseEnabled = false;
         }
         _landUpLevelTxt.text = _data.landGrade.toString();
      }
      
      private function __onBuildingOver(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOverFilter(param1.currentTarget as DisplayObject);
      }
      
      private function __onBuildingOut(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOutFilter(param1.currentTarget as DisplayObject);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_farmLandLayer)
         {
            ObjectUtils.disposeObject(_farmLandLayer);
         }
         _farmLandLayer = null;
         if(_farmWaterView)
         {
            ObjectUtils.disposeObject(_farmWaterView);
         }
         _farmWaterView = null;
         if(_landUpBtn)
         {
            ObjectUtils.disposeObject(_landUpBtn);
         }
         _landUpBtn = null;
         if(_landUpNameBg)
         {
            ObjectUtils.disposeObject(_landUpNameBg);
         }
         _landUpNameBg = null;
         if(_landUpNameTxt)
         {
            ObjectUtils.disposeObject(_landUpNameTxt);
         }
         _landUpNameTxt = null;
         if(_landUpLevelTxt)
         {
            ObjectUtils.disposeObject(_landUpLevelTxt);
         }
         _landUpLevelTxt = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         _buildingFilter = null;
         super.dispose();
      }
   }
}

