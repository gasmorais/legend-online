package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.SecretMapLevelTemplate;
   import yishi.datas.templates.TheseusTreasureCoreInfo;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   
   public class TreasureCoreItem extends TreasureOuterItem
   {
      
      public function TreasureCoreItem(param1:int)
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
      
      override public function setTipData() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TheseusTreasureCoreInfo = null;
         var _loc2_:int = 0;
         var _loc3_:SecretMapLevelTemplate = null;
         var _loc1_:String = "";
         if(_lock.visible)
         {
            _loc4_ = int(TempleteManager.instance.royaltyTempCate.minCoreLv);
            _loc5_ = int(RoyaltyBossManager.instance.model.royaltyLevel);
            if(_loc4_ > _loc5_)
            {
               _loc1_ = LanguageMgr.GetTranslation("TreasureOuterItem.royalty.text",_loc4_) + "\n";
            }
            _loc6_ = TempleteManager.instance.theseusTreasureCoreCate.getTempInfoByLevel(1);
            _loc2_ = int(SecretAdventerManager.Instance.model.frameInfo.passMapId);
            if(_loc6_.SecretLevel > _loc2_)
            {
               _loc3_ = TempleteManager.instance.secretMapCate.getTempInfo(_loc6_.SecretLevel);
               if(_loc3_)
               {
                  _loc1_ += LanguageMgr.GetTranslation("TreasureOuterItem.secret.text",_loc3_.MapName);
               }
            }
            tipData = _loc1_;
         }
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

