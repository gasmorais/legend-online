package navigation
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationBoatInfo;
   import mvc.module.navigation.NavigationModel;
   import mvc.module.navigation.NavigationPortInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.TimeDownView;
   
   public class NavigationBuildView extends Component
   {
      
      private var buildImage:Image;
      
      private var nameText:GradientText;
      
      private var nameBack:ScaleFrameImage;
      
      private var leftText:FilterFrameText;
      
      private var leftTime:TimeDownView;
      
      private var _buildingFilter:SimpleBuildingFilter;
      
      private var _data:Object;
      
      private var _viewType:int;
      
      private var _buildType:int;
      
      public function NavigationBuildView(param1:int)
      {
         super();
         _buildingFilter = new SimpleBuildingFilter();
         _viewType = param1;
         _buildType = _viewType == 0 ? 1 : 2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         buildImage = ComponentFactory.Instance.creatComponentByStylename("NavigationBuildView.buildImage" + _viewType);
         nameBack = ComponentFactory.Instance.creatComponentByStylename("NavigationBuildView.nameBack");
         nameText = ComponentFactory.Instance.creatComponentByStylename("NavigationBuildView.nameText" + _buildType);
         leftText = ComponentFactory.Instance.creatComponentByStylename("NavigationBuildView.leftText");
         leftTime = ComponentFactory.Instance.creatComponentByStylename("NavigationBuildView.leftTimeTime");
         addChild(buildImage);
         addChild(nameBack);
         addChild(nameText);
         addChild(leftText);
         addChild(leftTime);
         nameBack.setFrame(_buildType);
         nameText.mouseEnabled = nameBack.mouseEnabled = false;
         leftText.text = "";
         leftTime.timeCount = 0;
         leftTime.visible = false;
         nameText.text = LanguageMgr.GetTranslation("NavigationBuildView.nameText.text" + _viewType);
         setViewPos();
         setHitArea();
      }
      
      private function setViewPos() : void
      {
         var _loc1_:Array = [[18,149],[412,10],[595,128],[452,352]];
         var _loc4_:Array = [[73,159],[412,110],[550,263],[437,327]];
         var _loc2_:Array = [[68,164],[412,112],[550,265],[437,329]];
         var _loc3_:Array = [[0,0],[412,135],[550,288],[452,352]];
         buildImage.x = _loc1_[_viewType][0];
         buildImage.y = _loc1_[_viewType][1];
         nameBack.x = _loc4_[_viewType][0];
         nameBack.y = _loc4_[_viewType][1];
         nameText.x = _loc2_[_viewType][0];
         nameText.y = _loc2_[_viewType][1];
         leftText.x = _loc3_[_viewType][0];
         leftText.y = _loc3_[_viewType][1];
         leftTime.y = leftText.y;
      }
      
      private function setHitArea() : void
      {
         var _loc2_:Sprite = null;
         var _loc1_:BitmapData = new BitmapData(buildImage.width,buildImage.height,true,0);
         _loc1_.draw(buildImage);
         _loc2_ = DisplayUtils.getHitArea(_loc1_,5);
         this.hitArea = _loc2_;
      }
      
      private function addEvent() : void
      {
         leftTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         addEventListener("mouseOver",mouseOverHandler);
         addEventListener("mouseOut",mouseOutHandler);
         addEventListener("click",mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(leftTime)
         {
            leftTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         }
         removeEventListener("mouseOver",mouseOverHandler);
         removeEventListener("mouseOut",mouseOutHandler);
         removeEventListener("click",mouseClickHandler);
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         leftText.text = "";
         leftTime.timeCount = 0;
         leftTime.visible = false;
      }
      
      public function mouseClickHandler(param1:MouseEvent) : void
      {
         if(_viewType == 0)
         {
            SoundManager.instance.play("022");
            FrameControllerManager.instance.openControllerByInfo("navigation",2);
         }
         else
         {
            SoundManager.instance.play("022");
            FrameControllerManager.instance.openControllerByInfo("navigation",3,_viewType);
         }
      }
      
      public function mouseOverHandler(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOverFilter(buildImage);
      }
      
      public function mouseOutHandler(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOutFilter(buildImage);
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:NavigationBoatInfo = null;
         var _loc3_:int = 0;
         _data = param1;
         if(!_data)
         {
            return;
         }
         if(_data is NavigationPortInfo)
         {
            _loc2_ = model.getBoatInfoByBoatId(_data.boatId);
            _loc3_ = (_data as NavigationPortInfo).portCd - PlayerManager.instance.currentPlayerModel.sysSecond;
            if(_loc3_ > 0)
            {
               leftText.text = LanguageMgr.GetTranslation("NavigationBuildView.leftText.text2");
               leftTime.timeCount = _loc3_;
               leftTime.visible = true;
            }
            else if(_loc2_)
            {
               _loc3_ = _loc2_.boatCd - PlayerManager.instance.currentPlayerModel.sysSecond;
               if(_loc3_ > 0)
               {
                  leftText.text = LanguageMgr.GetTranslation("NavigationBuildView.leftText.text");
                  leftTime.timeCount = _loc3_;
                  leftTime.visible = true;
               }
            }
            else
            {
               leftText.text = "";
               leftTime.timeCount = 0;
               leftTime.visible = false;
            }
         }
         leftTime.x = leftText.x + leftText.textWidth + 5;
      }
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(buildImage);
         buildImage = null;
         ObjectUtils.disposeObject(nameText);
         nameText = null;
         ObjectUtils.disposeObject(nameBack);
         nameBack = null;
         ObjectUtils.disposeObject(leftText);
         leftText = null;
         ObjectUtils.disposeObject(leftTime);
         leftTime = null;
         _buildingFilter = null;
         super.dispose();
      }
   }
}

