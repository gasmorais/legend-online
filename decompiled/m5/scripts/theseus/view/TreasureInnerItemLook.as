package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Sprite;
   
   public class TreasureInnerItemLook extends TreasureOuterItemLook
   {
      
      public function TreasureInnerItemLook(param1:int)
      {
         super(param1);
      }
      
      override public function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.innerBg");
         _light = ComponentFactory.Instance.creatBitmap("asset.theseus.innerLight");
         _lock = ComponentFactory.Instance.creatBitmap("asset.theseus.innerLock");
         _icon = ComponentFactory.Instance.creatCustomObject("TreasureInnerItem.icon");
         _effect = ComponentFactory.Instance.creatComponentByStylename("core.goods.Strengthen");
         addChild(_bg);
         addChild(_icon);
         addChild(_light);
         _light.visible = false;
         addChild(_effect);
         _effect.visible = false;
         addChild(_lock);
         _icon.mask = createSprite();
         _effect.x = 40;
         _effect.y = 40;
      }
      
      override public function createSprite() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(32,37,25);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         return _loc1_;
      }
      
      override public function get type() : int
      {
         return 751;
      }
   }
}

