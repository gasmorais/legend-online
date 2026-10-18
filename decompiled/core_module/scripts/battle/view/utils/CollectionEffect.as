package battle.view.utils
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class CollectionEffect
   {
      
      private var _backContainer:Sprite;
      
      private var _frontContainer:Sprite;
      
      private var _backEffect:MovieClip;
      
      private var _frontEffect:MovieClip;
      
      private var _job:int;
      
      public function CollectionEffect(param1:Sprite, param2:Sprite, param3:int = 1)
      {
         super();
         _backContainer = param1;
         _frontContainer = param2;
         _job = param3;
         show();
      }
      
      private function show() : void
      {
         _backEffect = ComponentFactory.Instance.creat("asset.battle.CollectGasAsset");
         _backEffect.mouseChildren = _backEffect.mouseEnabled = false;
         _backContainer.addChild(_backEffect);
      }
      
      public function updateToQteState() : void
      {
         if(_frontEffect)
         {
            return;
         }
         if(ModuleLoader.hasDefinition(getFrontEffectLinkName()))
         {
            _frontEffect = ComponentFactory.Instance.creat(getFrontEffectLinkName());
            if(_job == 3)
            {
               _backContainer.addChild(_frontEffect);
            }
            else
            {
               _frontContainer.addChild(_frontEffect);
            }
            _frontEffect.mouseChildren = _frontEffect.mouseEnabled = false;
            _frontEffect.gotoAndPlay("qte");
         }
         _backEffect.gotoAndPlay("qte");
      }
      
      private function getFrontEffectLinkName() : String
      {
         if(_job == 3)
         {
            return "asset.battle.CollectGasWizardAsset";
         }
         if(_job == 2)
         {
            return "asset.battle.CollectGasHunterAsset";
         }
         return "asset.battle.CollectGasFrontAsset";
      }
      
      public function dispose() : void
      {
         if(_frontEffect)
         {
            if(_frontEffect.parent)
            {
               _frontEffect.parent.removeChild(_frontEffect);
            }
            _frontEffect.stop();
         }
         if(_backEffect)
         {
            if(_backEffect.parent)
            {
               _backEffect.parent.removeChild(_backEffect);
            }
            _backEffect.stop();
         }
         _frontContainer = null;
         _backContainer = null;
      }
   }
}

