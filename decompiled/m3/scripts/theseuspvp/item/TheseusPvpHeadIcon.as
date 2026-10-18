package theseuspvp.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TheseusPvpHeadIcon extends Sprite
   {
      
      private var _icon:BaseIconView;
      
      private var _maskShape:Shape;
      
      public function TheseusPvpHeadIcon()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.headIcon");
         _maskShape = new Shape();
         addChild(_icon);
         addChild(_maskShape);
         _icon.mask = _maskShape;
         _maskShape.graphics.beginFill(16711680);
         _maskShape.graphics.drawCircle(25,25,23);
         _maskShape.graphics.endFill();
      }
      
      public function set headIcon(param1:int) : void
      {
         _icon.icon = IconFactory.getHeadIcon(param1,"smallhead",".jpg");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

