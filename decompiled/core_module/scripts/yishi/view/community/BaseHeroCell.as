package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import flash.display.DisplayObject;
   
   public class BaseHeroCell extends HeroIconCell
   {
      
      public static const P_vocation:String = "vocation";
      
      private var _vocationStyle:String;
      
      protected var _vocation:ScaleFrameImage;
      
      public function BaseHeroCell(param1:Function = null)
      {
         super(param1);
      }
      
      public function set vocationStyle(param1:String) : void
      {
         _vocationStyle = param1;
         onPropertiesChanged("vocation");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["vocation"])
         {
            _vocation = ComponentFactory.Instance.creatComponentByStylename(_vocationStyle);
            _vocation.visible = false;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_vocation)
         {
            addChild(_vocation);
         }
      }
      
      override protected function refreshView() : void
      {
         super.refreshView();
         if(_vocation)
         {
            _vocation.visible = false;
         }
         if(!data)
         {
            return;
         }
         setVocation();
      }
      
      protected function setVocation() : void
      {
         if(!_vocation)
         {
            return;
         }
         _vocation.visible = true;
         _vocation.setFrame(data.templateInfo.Job);
      }
      
      public function get vocation() : DisplayObject
      {
         return _vocation;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _vocation = null;
      }
   }
}

