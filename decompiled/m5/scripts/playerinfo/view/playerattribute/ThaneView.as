package playerinfo.view.playerattribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ThaneView extends Component
   {
      
      private var _leftbBack1:Bitmap;
      
      private var _rightBack1:Bitmap;
      
      protected var _icon:BaseIconView;
      
      private var _back2:Bitmap;
      
      private var _iconMask:Shape;
      
      public function ThaneView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _iconMask = createmask();
         _leftbBack1 = ComponentFactory.Instance.creatBitmap("asset.core.ThaneBack1");
         _rightBack1 = ComponentFactory.Instance.creatBitmap("asset.core.ThaneBack1");
         _icon = ComponentFactory.Instance.creatCustomObject("core.ThaneIconView");
         _back2 = ComponentFactory.Instance.creatBitmap("asset.core.ThaneBack");
         _icon.mask = _iconMask;
         _rightBack1.scaleX = -1;
         _rightBack1.x = _leftbBack1.x + _leftbBack1.width * 2;
         addChild(_leftbBack1);
         addChild(_rightBack1);
         addChild(_icon);
         addChild(_back2);
         addChild(_iconMask);
      }
      
      private function createmask() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(6,2,144,145);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      public function refreshView() : void
      {
         _icon.icon = IconFactory.getPlayerIcon(thane.templateId,"half",".jpg");
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_leftbBack1);
         _leftbBack1 = null;
         ObjectUtils.disposeObject(_rightBack1);
         _rightBack1 = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_iconMask);
         _iconMask = null;
         super.dispose();
      }
   }
}

