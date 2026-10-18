package yishi.view.community
{
   import bag.helper.GoodsCheck;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import mvc.module.theseus.WarFrameItemInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class BaseWarCell extends BaseWarItem
   {
      
      public static const P_lockStyle:String = "lockStyle";
      
      private var _lockStyle:String;
      
      protected var _lockImg:ScaleFrameImage;
      
      protected var _shape:Shape;
      
      private var _lockTxt:Boolean;
      
      protected var _lock:Boolean;
      
      public function BaseWarCell()
      {
         super();
         createShape();
      }
      
      public function set lockStyle(param1:String) : void
      {
         _lockStyle = param1;
         onPropertiesChanged("lockStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["lockStyle"])
         {
            _lockImg = ComponentFactory.Instance.creatComponentByStylename(_lockStyle);
            _lockImg.setFrame(1);
            _lockImg.mouseChildren = false;
            _lockImg.mouseEnabled = false;
            _lockImg.tipData = "";
         }
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
         if(_lockImg)
         {
            addChild(_lockImg);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_shape)
         {
            addChild(_shape);
         }
         if(_profile)
         {
            addChild(_profile);
         }
         if(_itemText)
         {
            addChild(_itemText);
         }
         if(_strengthenIcon)
         {
            addChild(_strengthenIcon);
         }
         if(_fashionImage)
         {
            addChild(_fashionImage);
         }
         if(_fashionText)
         {
            addChild(_fashionText);
         }
      }
      
      override public function set data(param1:WarFrameItemInfo) : void
      {
         super.data = param1;
         removeShape();
         if(!param1)
         {
            return;
         }
         if(GoodsCheck.isEquip(param1.warTempInfo) && _shape)
         {
            _shape.visible = true;
         }
      }
      
      private function createShape() : void
      {
         if(!_shape)
         {
            _shape = new Shape();
         }
         _shape.graphics.beginFill(16711680);
         _shape.graphics.drawRect(0,0,45,40);
         _shape.graphics.endFill();
         _shape.x = 0;
         _shape.y = 4;
         _shape.blendMode = "multiply";
      }
      
      private function removeShape() : void
      {
         if(_shape)
         {
            _shape.visible = false;
         }
      }
      
      public function set lockTxt(param1:Boolean) : void
      {
         _lockTxt = param1;
         if(_lockTxt)
         {
            _lockImg.setFrame(2);
         }
         else
         {
            _lockImg.setFrame(1);
         }
      }
      
      public function set lock(param1:Boolean) : void
      {
         _lock = param1;
         if(_lockImg)
         {
            _lockImg.visible = _lock;
         }
      }
      
      public function get lock() : Boolean
      {
         return _lock;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         _shape = null;
         super.dispose();
      }
   }
}

