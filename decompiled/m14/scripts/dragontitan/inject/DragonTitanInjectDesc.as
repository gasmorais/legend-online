package dragontitan.inject
{
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontitan.BasePanelComponent;
   import manager.LanguageMgr;
   import mvc.module.dragonTitan.DragonTitanInjectInfo;
   
   public class DragonTitanInjectDesc extends BasePanelComponent
   {
      
      private var _attBg:ScaleBitmapImage;
      
      private var _txt:FilterFrameText;
      
      public function DragonTitanInjectDesc()
      {
         super();
         this.x = 235;
         this.y = 34;
      }
      
      override protected function initView() : void
      {
         _attBg = addCreatComponentByStylename("dragontitan.attBg");
         _attBg.width = 255;
         _attBg.height = 70;
         _txt = addCreatComponentByStylename("DragonTitanFrame.spiritAttListTxt");
         _txt.x = _txt.y = 10;
      }
      
      public function updateView(param1:DragonTitanInjectInfo) : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("DragonTitanInjectDesc.updateView.circlieTxt");
         var _loc3_:String = LanguageMgr.GetTranslation("DragonTitanInjectDesc.updateView.upperTxt");
         var _loc2_:String = "<font size=\'13\' color=\'#36FF00\'>" + _loc4_ + param1.injectCount + "/" + param1.injectCircleCount + _loc3_ + param1.chargeGrade + "</font>";
         _txt.htmlText = _loc2_;
      }
      
      override public function dispose() : void
      {
         if(_attBg)
         {
            ObjectUtils.disposeObject(_attBg);
         }
         _attBg = null;
         if(_txt)
         {
            ObjectUtils.disposeObject(_txt);
         }
         _txt = null;
         super.dispose();
      }
   }
}

