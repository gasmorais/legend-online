package fish.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.FishManager;
   import mvc.module.fish.FishModel;
   import mvc.module.fish.FishPlayerInfo;
   import yishi.view.component.MovieButton;
   
   public class FishHelpSprite extends Sprite implements Disposeable
   {
      
      private var _loveMc:MovieButton;
      
      private var _data:FishPlayerInfo;
      
      public function FishHelpSprite()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _loveMc = ComponentFactory.Instance.creatComponentByStylename("fish.loveMc");
         addChild(_loveMc);
         _loveMc.stopEffect();
      }
      
      public function set data(param1:FishPlayerInfo) : void
      {
         if(!param1)
         {
            _loveMc.stopEffect();
            _loveMc.isPlaying = false;
            _loveMc.tipData = null;
         }
         else
         {
            if(!_loveMc.isPlaying)
            {
               _loveMc.playEffect();
               _loveMc.isPlaying = true;
            }
            _loveMc.tipData = LanguageMgr.GetTranslation("fish.FishFrame.loveTip",param1.nickName);
         }
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      public function dispose() : void
      {
         _data = null;
         if(_loveMc)
         {
            _loveMc.stopEffect();
         }
         ObjectUtils.disposeObject(_loveMc);
         _loveMc = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

