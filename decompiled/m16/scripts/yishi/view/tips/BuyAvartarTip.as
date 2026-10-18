package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.manager.TempleteManager;
   
   public class BuyAvartarTip extends BaseTip
   {
      
      private var _pointBmp:ScaleFrameImage;
      
      private var _selfTipTxt:FilterFrameText;
      
      public function BuyAvartarTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _pointBmp = ComponentFactory.Instance.creatComponentByStylename("core.PayType");
         _selfTipTxt = ComponentFactory.Instance.creatComponentByStylename("worldboss.BuyAvatarFrame.DescriptionTxt");
         var _loc4_:TempleteManager = TempleteManager.instance;
         var _loc3_:int = 200;
         if(_loc4_.getConfigInfoByConfigName("WorldBoss_Replacement_Price"))
         {
            _loc3_ = parseInt(_loc4_.getConfigInfoByConfigName("WorldBoss_Replacement_Price").ConfigValue);
         }
         var _loc1_:String = LanguageMgr.GetTranslation("worldboss.BuyAvatarFrame.command02",_loc3_);
         _selfTipTxt.htmlText = _loc1_;
         var _loc2_:Rectangle = _selfTipTxt.getCharBoundaries(_selfTipTxt.text.indexOf("$"));
         _pointBmp.setFrame(1);
         _pointBmp.y = _selfTipTxt.y;
         _pointBmp.x = _loc2_.x + 6;
         _selfTipTxt.htmlText = _loc1_.replace("$","");
         addChild(_selfTipTxt);
         addChild(_pointBmp);
         _bg.beginChanges();
         _bg.height = 78;
         _bg.commitChanges();
      }
      
      override protected function updateTransform() : void
      {
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _pointBmp = null;
         _selfTipTxt = null;
      }
   }
}

