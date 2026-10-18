package dragontitan.inject
{
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontitan.BasePanelComponent;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.dragonTitan.DragonTitanInjectInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   
   public class DragonTitanInjectAttPanel extends BasePanelComponent
   {
      
      private var _attBg:ScaleBitmapImage;
      
      private var _getTxtBmp:Bitmap;
      
      private var _attTxts:Array = [];
      
      private var _pointBmps:Array = [];
      
      public function DragonTitanInjectAttPanel()
      {
         super();
         this.x = 303;
         this.y = 20;
      }
      
      override protected function initView() : void
      {
         _attBg = addCreatComponentByStylename("dragontitan.attBg");
         _getTxtBmp = addCreatBitmap("asset.dragontitan.getTxtBmp");
      }
      
      public function updateView(param1:DragonTitanInjectInfo) : void
      {
         var _loc4_:int = 0;
         var _loc6_:FilterFrameText = null;
         var _loc10_:Bitmap = null;
         var _loc2_:UpgradeTemplateInfo = param1.upgradeInfo;
         var _loc8_:Array = param1.getAttValue() ? param1.getAttValue() : [0,0,0,0,0];
         var _loc13_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         var _loc12_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         var _loc9_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         var _loc7_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         var _loc5_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         var _loc3_:Array = [_loc13_,_loc12_,_loc9_,_loc7_,_loc5_];
         var _loc11_:int = 20;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc6_ = _attTxts[_loc4_];
            if(!_loc6_)
            {
               _loc6_ = addCreatComponentByStylename("DragonTitanFrame.spiritAttListTxt");
               _attTxts[_loc4_] = _loc6_;
               _loc10_ = addCreatBitmap("asset.dragontitan.point");
               _loc10_.y = _loc11_ + 3;
               _pointBmps.push(_loc10_);
            }
            _loc6_.y = _loc11_;
            _loc11_ += 18;
            _loc6_.htmlText = "<font size=\'13\' color=\'#36FF00\'>" + (_loc3_[_loc4_] + "  +" + _loc8_[_loc4_]) + "</font>";
            _loc4_++;
         }
      }
      
      override public function dispose() : void
      {
         if(_attTxts)
         {
            _attTxts.forEach(clearArray);
            _attTxts.length = 0;
            _attTxts = null;
         }
         if(_pointBmps)
         {
            _pointBmps.forEach(clearArray);
            _pointBmps.length = 0;
            _pointBmps = null;
         }
         if(_attBg)
         {
            ObjectUtils.disposeObject(_attBg);
         }
         _attBg = null;
         if(_getTxtBmp)
         {
            ObjectUtils.disposeObject(_getTxtBmp);
         }
         _getTxtBmp = null;
         super.dispose();
      }
      
      private function clearArray(param1:Object, param2:Object, param3:Object) : void
      {
         ObjectUtils.disposeObject(param1);
      }
   }
}

