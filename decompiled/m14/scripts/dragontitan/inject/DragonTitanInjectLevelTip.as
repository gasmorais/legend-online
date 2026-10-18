package dragontitan.inject
{
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontitan.BasePanelComponent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import manager.LanguageMgr;
   import mvc.module.dragonTitan.DragonTitanInjectInfo;
   
   public class DragonTitanInjectLevelTip extends BasePanelComponent
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _donwArrow:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function DragonTitanInjectLevelTip()
      {
         super();
         this.y = 155;
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      override protected function initView() : void
      {
         _bg = addCreatComponentByStylename("core.commonTipBg");
         _bg.y = 3;
         _bg.height = 30;
         _donwArrow = addCreatBitmap("asset.dragontitan.downArrow");
         _donwArrow.y = 32;
         _txt = addCreatComponentByStylename("DragonTitanFrame.arrowUpTxt");
         _txt.x = 4;
      }
      
      public function updateView(param1:DragonTitanInjectInfo, param2:DisplayObject) : void
      {
         var _loc6_:Array = null;
         var _loc3_:String = null;
         var _loc10_:String = null;
         var _loc9_:String = null;
         var _loc7_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         var _loc11_:Array = null;
         var _loc8_:Object = null;
         if(param1.isActive)
         {
            _loc6_ = param1.nextUpgradeInfo.TemplateName.split(",");
            _loc3_ = LanguageMgr.GetTranslation("DragonTitanInjectLevelTip.updateView.injectUpTxt");
            _txt.text = _loc3_ + _loc6_[0];
         }
         else
         {
            _loc10_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
            _loc9_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
            _loc7_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
            _loc5_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
            _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
            _loc11_ = [_loc10_,_loc9_,_loc7_,_loc5_,_loc4_];
            _loc8_ = param1.getTipObj();
            _txt.text = _loc11_[_loc8_.grade] + "+" + _loc8_.value;
         }
         _bg.width = _txt.width + 7;
         _donwArrow.x = (_bg.width - _donwArrow.width) * 0.5;
         this.x = (30 - _bg.width >> 1) + param2.x - 1;
      }
      
      override public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_donwArrow)
         {
            ObjectUtils.disposeObject(_donwArrow);
         }
         _donwArrow = null;
         if(_txt)
         {
            ObjectUtils.disposeObject(_txt);
         }
         _txt = null;
         super.dispose();
      }
   }
}

