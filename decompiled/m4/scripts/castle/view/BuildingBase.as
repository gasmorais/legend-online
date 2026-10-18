package castle.view
{
   import castle.view.layer.CastleNameLayer;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.BuildingEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import mvc.module.buildings.BuildInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IStopEffect;
   import yishi.manager.BuildingManager;
   import yishi.manager.NotificationManager;
   
   public class BuildingBase extends Component implements IBaseMouseEvent, IStopEffect
   {
      
      protected var _curViewContainer:Component;
      
      protected var _curView:DisplayObject;
      
      protected var _effectView:DisplayObject;
      
      protected var _buildingInfo:BuildInfo;
      
      protected var _nameContain:Sprite;
      
      protected var _nameBack:ScaleBitmapImage;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _levelTxt:FilterFrameText;
      
      private var _nameLayer:CastleNameLayer;
      
      public function BuildingBase(param1:CastleNameLayer)
      {
         super();
         _nameLayer = param1;
         _curViewContainer = new Component();
         _curViewContainer.mouseChildren = false;
         _curViewContainer.mouseEnabled = false;
         addChild(_curViewContainer);
         _nameContain = new Sprite();
         _nameContain.mouseEnabled = false;
         _nameContain.mouseChildren = false;
         addEvent();
         tipDirctions = "4,6,5,7";
         isFollowMouse = false;
         tipGapV = tipGapH = 0;
      }
      
      protected function initTipStyle() : void
      {
         tipStyle = "yishi.view.tips.BuildTip";
      }
      
      override public function get height() : Number
      {
         if(_curView)
         {
            return _curView["effect_area"].height;
         }
         return 0;
      }
      
      override public function get width() : Number
      {
         if(_curView)
         {
            return _curView["effect_area"].width;
         }
         return 0;
      }
      
      protected function addEvent() : void
      {
         BuildingManager.instance.addEventListener("building_name_show_hide",_changeBuildName);
         NotificationManager.instance.addEventListener("STOP_EFFECT",__notificationHandler);
      }
      
      protected function removeEvent() : void
      {
         BuildingManager.instance.removeEventListener("building_name_show_hide",_changeBuildName);
         NotificationManager.instance.removeEventListener("STOP_EFFECT",__notificationHandler);
      }
      
      private function __notificationHandler(param1:NotificationEvent) : void
      {
         if(param1.data)
         {
            startEffet();
         }
         else
         {
            stopEffect();
         }
      }
      
      public function stopEffect() : void
      {
         if(_effectView)
         {
            (_effectView as MovieClip).stop();
         }
      }
      
      public function startEffet() : void
      {
         if(_effectView)
         {
            (_effectView as MovieClip).play();
         }
      }
      
      private function _changeBuildName(param1:BuildingEvent) : void
      {
         showName = BuildingManager.instance.isShowBuildingName;
      }
      
      public function addChildByScale(param1:Number) : void
      {
         _nameContain.x = int(_buildingInfo.templeteInfo.TitleX * param1);
         _nameContain.y = int(_buildingInfo.templeteInfo.TitleY * param1);
         _nameContain.scaleX = _nameContain.scaleY = 1 / param1;
         addChildAt(_nameContain,numChildren);
      }
      
      public function removeName() : void
      {
         if(_nameContain.parent)
         {
            _nameContain.parent.removeChild(_nameContain);
         }
      }
      
      protected function clean() : void
      {
      }
      
      protected function refreshView() : void
      {
         if(!_buildingInfo || _buildingInfo.templateId < 0)
         {
            return;
         }
         _nameContain.x = _buildingInfo.templeteInfo.TitleX;
         _nameContain.y = _buildingInfo.templeteInfo.TitleY;
         addChild(_nameContain);
         if(!_nameBack)
         {
            if(_buildingInfo.templeteInfo.SonType >= 1501)
            {
               _nameBack = ComponentFactory.Instance.creatComponentByStylename("castle.NameBack2");
               _nameTxt = ComponentFactory.Instance.creatComponentByStylename("castle.BuildNameTxt2");
               _nameTxt.text = _buildingInfo.templeteInfo.BuildingName;
               _nameContain.addChild(_nameBack);
               _nameContain.addChild(_nameTxt);
               _nameBack.width = _nameTxt.textWidth + 12;
            }
            else
            {
               _nameBack = ComponentFactory.Instance.creatComponentByStylename("castle.NameBack1");
               _nameTxt = ComponentFactory.Instance.creatComponentByStylename("castle.BuildNameTxt1");
               _levelTxt = ComponentFactory.Instance.creatComponentByStylename("castle.BuildLevelTxt");
               _nameContain.addChild(_nameBack);
               _nameContain.addChild(_nameTxt);
               _nameContain.addChild(_levelTxt);
               _nameTxt.text = _buildingInfo.templeteInfo.BuildingName;
               _levelTxt.text = _buildingInfo.templeteInfo.BuildingGrade.toString();
               _nameBack.width = _nameTxt.textWidth + 27;
            }
         }
         else if(_buildingInfo.templeteInfo.SonType < 1501)
         {
            _nameTxt.text = _buildingInfo.templeteInfo.BuildingName;
            _levelTxt.text = _buildingInfo.templeteInfo.BuildingGrade.toString();
         }
         showName = BuildingManager.instance.isShowBuildingName;
      }
      
      protected function initTipData() : void
      {
      }
      
      public function set buildingInfo(param1:BuildInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         _buildingInfo = param1;
         initTipStyle();
         initTipData();
         refreshView();
      }
      
      public function get buildingInfo() : BuildInfo
      {
         return _buildingInfo;
      }
      
      public function set showName(param1:Boolean) : void
      {
         if(_nameContain && _buildingInfo.templateId > 0)
         {
            _nameContain.visible = param1;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_curView && _curView.parent)
         {
            _curView.parent.removeChild(_curView);
         }
         _curView = null;
         if(_effectView)
         {
            ObjectUtils.disposeObject(_effectView);
            _effectView = null;
         }
         _buildingInfo = null;
         if(_nameBack)
         {
            if(_nameBack.parent)
            {
               _nameBack.parent.removeChild(_nameBack);
            }
            _nameBack.dispose();
         }
         _nameBack = null;
         if(_nameTxt)
         {
            if(_nameTxt.parent)
            {
               _nameTxt.parent.removeChild(_nameTxt);
            }
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_levelTxt)
         {
            if(_levelTxt.parent)
            {
               _levelTxt.parent.removeChild(_levelTxt);
            }
            _levelTxt.dispose();
         }
         _levelTxt = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
   }
}

