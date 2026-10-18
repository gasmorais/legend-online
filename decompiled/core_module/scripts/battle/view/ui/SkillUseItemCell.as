package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import yishi.view.community.BaseIconView;
   
   public class SkillUseItemCell extends Sprite implements Disposeable
   {
      
      private var _icon:BaseIconView;
      
      private var _asset:MovieClip;
      
      private var _data:String;
      
      public var color:ColorTransform;
      
      public function SkillUseItemCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         color = new ColorTransform();
         transform.colorTransform = color;
         _icon = ComponentFactory.Instance.creatCustomObject("battle.SkillUseItemCell");
         _asset = ClassUtils.CreatInstance("asset.battle.SkillGlowAsset");
         _asset.gotoAndStop(1);
         mouseEnabled = false;
         mouseChildren = false;
         addChild(_asset);
         _asset.skill.addChild(_icon);
      }
      
      public function flash() : void
      {
         _asset.play();
      }
      
      public function tweenEffect(param1:Boolean) : void
      {
         _asset.gotoAndPlay("out");
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1 as String;
         if(param1)
         {
            _icon.icon = _data;
         }
      }
      
      public function hideBorder() : void
      {
         _asset.skill.removeChildAt(0);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         ObjectUtils.disposeViolentMc(_asset);
         _data = null;
         color = null;
         _icon = null;
         _asset = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

