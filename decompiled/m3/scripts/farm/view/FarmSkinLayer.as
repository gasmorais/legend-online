package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class FarmSkinLayer extends Sprite implements Disposeable
   {
      
      private var _skin:Image;
      
      private var _windmill:MovieClip;
      
      private var _waterwheel:MovieClip;
      
      public function FarmSkinLayer()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _skin = ComponentFactory.Instance.creatComponentByStylename("farm.Skin");
         _windmill = ComponentFactory.Instance.creatCustomObject("farm.Windmill");
         _waterwheel = ComponentFactory.Instance.creatCustomObject("farm.Waterwheel");
         _skin.cacheAsBitmap = true;
         _skin.mouseEnabled = _skin.mouseChildren = false;
         _windmill.mouseEnabled = _windmill.mouseChildren = false;
         _waterwheel.mouseEnabled = _waterwheel.mouseChildren = false;
         addChild(_skin);
         addChild(_windmill);
         addChild(_waterwheel);
         _waterwheel.visible = false;
      }
      
      public function dispose() : void
      {
         if(_skin)
         {
            _skin.dispose();
         }
         _skin = null;
         if(_windmill)
         {
            _windmill.stop();
         }
         _windmill = null;
         if(_waterwheel)
         {
            _waterwheel.stop();
         }
         _waterwheel = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

