package map.campaign.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CampaignDialogOptionItem extends Sprite
   {
      
      private var _selectedBg:Bitmap;
      
      private var _icon:Bitmap;
      
      private var _option:FilterFrameText;
      
      private var _title:String;
      
      private var _mapId:int;
      
      private var _nodeId:int;
      
      public var param:int;
      
      public var type:int;
      
      public function CampaignDialogOptionItem(param1:int, param2:int, param3:String, param4:int, param5:int = 0)
      {
         _mapId = param1;
         _nodeId = param2;
         _title = param3;
         param = param4;
         type = param5;
         super();
         initView();
         addEvent();
         this.mouseChildren = false;
      }
      
      private function initView() : void
      {
         buttonMode = true;
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.space.SpaceDialogFrame.SelectedBg");
         _icon = ComponentFactory.Instance.creatBitmap("asset.space.SpaceDialogFrame.Arrow");
         _option = ComponentFactory.Instance.creatComponentByStylename("map.space.DialogOptionItem.TitleText");
         addChild(_selectedBg);
         addChild(_icon);
         addChild(_option);
         _selectedBg.visible = false;
         _option.text = _title;
         createHitArea();
      }
      
      private function createHitArea() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.clear();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,394,24);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         _selectedBg.visible = true;
         _option.setFrame(2);
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         _selectedBg.visible = false;
         _option.setFrame(1);
      }
      
      public function get text() : String
      {
         return _title;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_selectedBg)
         {
            ObjectUtils.disposeObject(_selectedBg);
            _selectedBg = null;
         }
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
         if(_option)
         {
            ObjectUtils.disposeObject(_option);
            _option = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

