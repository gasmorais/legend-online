package navigation
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationBoatInfo;
   import mvc.module.navigation.NavigationModel;
   import yishi.utils.MsgMan;
   
   public class NavigationBoatItemII extends Component implements ISelectable
   {
      
      private var border:Bitmap;
      
      private var boatImage:ScaleFrameImage;
      
      private var stateImage:ScaleFrameImage;
      
      private var _selected:Boolean;
      
      private var _boatInfo:NavigationBoatInfo;
      
      private var _type:int;
      
      private var _index:int;
      
      public function NavigationBoatItemII(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatBitmap("asset.NavigationBoatItem.borderLight");
         boatImage = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.boatImage");
         stateImage = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatItem.stateImage");
         addChild(boatImage);
         addChild(border);
         border.visible = false;
         addChild(stateImage);
         boatImage.setFrame(1);
         boatImage.x = boatImage.y = 0;
         stateImage.setFrame(1);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!_boatInfo)
         {
            return;
         }
         selected = !selected;
         MsgMan.notifyObserver("NAVIGATION_BOAT_PATROL",_boatInfo);
      }
      
      public function set data(param1:NavigationBoatInfo) : void
      {
         _boatInfo = param1;
         if(_boatInfo)
         {
            if(_boatInfo.state == 0)
            {
               this.buttonMode = true;
               addEvent();
            }
            else
            {
               this.buttonMode = false;
               removeEvent();
            }
            boatImage.setFrame(_boatInfo.grade);
            stateImage.setFrame(_boatInfo.state + 1);
         }
         else
         {
            this.buttonMode = false;
            boatImage.setFrame(1);
            stateImage.setFrame(1);
         }
      }
      
      public function get data() : NavigationBoatInfo
      {
         return _boatInfo;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         border.visible = _selected;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(border);
         border = null;
         ObjectUtils.disposeObject(boatImage);
         boatImage = null;
         ObjectUtils.disposeObject(stateImage);
         stateImage = null;
         super.dispose();
      }
   }
}

