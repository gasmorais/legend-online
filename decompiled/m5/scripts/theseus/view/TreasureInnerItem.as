package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.SecretMapLevelTemplate;
   import yishi.datas.templates.TheseusTreasureHokeInfo;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   
   public class TreasureInnerItem extends TreasureOuterItem
   {
      
      public function TreasureInnerItem(param1:int)
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
      
      override public function setTipData() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:TheseusTreasureHokeInfo = null;
         var _loc2_:int = 0;
         var _loc3_:SecretMapLevelTemplate = null;
         var _loc1_:String = "";
         if(_lock.visible)
         {
            _loc4_ = 0;
            _loc5_ = _index - 8;
            while(_loc5_ <= 3)
            {
               _loc4_ = int(TempleteManager.instance.royaltyTempCate.getInnerTreasureLv(_loc5_));
               if(_loc4_ != 0)
               {
                  _loc7_ = int(RoyaltyBossManager.instance.model.royaltyLevel);
                  if(_loc4_ > _loc7_)
                  {
                     _loc1_ = LanguageMgr.GetTranslation("TreasureOuterItem.royalty.text",_loc4_) + "\n";
                  }
                  break;
               }
               _loc5_++;
            }
            _loc6_ = TempleteManager.instance.theseusTreasureHokeCate.getTempInfoByHokeId(_index - 8,2);
            _loc2_ = int(SecretAdventerManager.Instance.model.frameInfo.passMapId);
            if(_loc6_ && _loc6_.Property1 > _loc2_)
            {
               _loc3_ = TempleteManager.instance.secretMapCate.getTempInfo(_loc6_.Property1);
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

