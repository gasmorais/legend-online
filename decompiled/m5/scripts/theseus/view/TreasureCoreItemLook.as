package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Sprite;
   import yishi.datas.templates.TheseusTreasureCoreInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   
   public class TreasureCoreItemLook extends TreasureOuterItemLook
   {
      
      public function TreasureCoreItemLook(param1:int)
      {
         super(param1);
      }
      
      override public function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.theseus.coreBg");
         _light = ComponentFactory.Instance.creatBitmap("asset.theseus.coreLight");
         _lock = ComponentFactory.Instance.creatBitmap("asset.theseus.coreLock");
         _icon = ComponentFactory.Instance.creatCustomObject("TreasureCoreItem.icon");
         addChild(_bg);
         addChild(_icon);
         addChild(_light);
         _light.visible = false;
         addChild(_lock);
         _icon.mask = createSprite();
      }
      
      override public function createSprite() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(43,43,39);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         return _loc1_;
      }
      
      override public function refreshView() : void
      {
         var _loc1_:TheseusTreasureCoreInfo = TempleteManager.instance.theseusTreasureCoreCate.getTempInfoByLevel(model.coreLevel);
         if(!_loc1_)
         {
            return;
         }
         _icon.icon = IconFactory.getSevenYearIconPath(_loc1_.Icon);
      }
      
      override public function get type() : int
      {
         return 0;
      }
   }
}

