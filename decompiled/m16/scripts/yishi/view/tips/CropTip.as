package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.data.FarmLandInfo;
   import farm.data.PetLandInfo;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class CropTip extends BaseTip
   {
      
      private var _totalVBox:VBox;
      
      private var _hBox1:HBox;
      
      private var _nameTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _timeValTxt:FilterFrameText;
      
      private var _accelerateTxt:FilterFrameText;
      
      private var _matureProgress:Sprite;
      
      private var _matureProgressBg:Bitmap;
      
      private var _matureProgressImg:Bitmap;
      
      private var _matureProgressMask:Shape;
      
      public function CropTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         if(_bg.parent)
         {
            _bg.parent.removeChild(_bg);
         }
         _totalVBox = ComponentFactory.Instance.creatComponentByStylename("tips.CropTipTotalVBox");
         _hBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.CropTipHBox");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.CropTipNameTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("tips.CropTipTimeTxt");
         _timeValTxt = ComponentFactory.Instance.creatComponentByStylename("tips.CropTipTimeTxt");
         _accelerateTxt = ComponentFactory.Instance.creatComponentByStylename("tips.CropTipAccelerateTxt");
         _matureProgressBg = ComponentFactory.Instance.creatBitmap("asset.tips.MatureProgressBg");
         _matureProgressImg = ComponentFactory.Instance.creatBitmap("asset.tips.MatureProgressImg");
         _matureProgressMask = ComponentFactory.Instance.creatCustomObject("tips.MatureProgressMask");
         _matureProgress = new Sprite();
         _timeTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.CropTip.remainTime");
         _matureProgressMask.graphics.beginFill(16777215,1);
         _matureProgressMask.graphics.drawRect(0,0,133,10);
         _matureProgressMask.graphics.endFill();
         _matureProgressImg.mask = _matureProgressMask;
         _matureProgress.addChild(_matureProgressBg);
         _matureProgress.addChild(_matureProgressImg);
         _matureProgress.addChild(_matureProgressMask);
         _hBox1.addChild(_timeTxt);
         _hBox1.addChild(_timeValTxt);
         _totalVBox.addChild(_nameTxt);
         addChild(_totalVBox);
      }
      
      override protected function updateTransform() : void
      {
         if(tipData is FarmLandInfo)
         {
            showFarmLandTip();
         }
         else if(tipData is PetLandInfo)
         {
            showFarmPetTip();
         }
      }
      
      private function showFarmLandTip() : void
      {
         var _loc2_:int = 0;
         var _loc4_:Number = NaN;
         var _loc1_:FarmLandInfo = tipData as FarmLandInfo;
         var _loc3_:int = int(_loc1_.cropPhase);
         if(_loc1_.cropTemp)
         {
            _nameTxt.text = _loc1_.cropTemp.TemplateName;
            _nameTxt.setFrame(_loc1_.cropTemp.Profile);
         }
         else
         {
            _nameTxt.text = "";
         }
         if(_loc1_.pos >= 1000 && _loc1_.remainMatureMinutes <= 0)
         {
            _nameTxt.text = "";
            return;
         }
         if(_loc3_ == 3 || _loc3_ == 4)
         {
            if(_loc1_.pos < 1000)
            {
               _nameTxt.appendText("  " + _loc1_.cropPhaseString);
            }
            else
            {
               _nameTxt.text = "";
            }
            if(_hBox1.parent)
            {
               _hBox1.parent.removeChild(_hBox1);
            }
            if(_matureProgress.parent)
            {
               _matureProgress.parent.removeChild(_matureProgress);
            }
         }
         else
         {
            _loc2_ = int(_loc1_.remainMatureMinutes);
            if(_loc2_ == 0)
            {
               FarmManager.instance.sendFarmOper(0,0,0);
            }
            _loc4_ = _loc1_.growMinutes / _loc1_.totalMatureMinutes;
            if(FarmLandInfo(_data).pos >= 1000)
            {
               _loc4_ = _loc1_.animalGrowMinutes / _loc1_.animalTotalMatureMinutes;
            }
            if(_loc4_ > 1)
            {
               _loc4_ = 1;
            }
            if(int(_loc2_ / 60) <= 0)
            {
               _timeValTxt.text = LanguageMgr.GetTranslation("public.needMinutes",_loc2_ % 60);
            }
            else
            {
               _timeValTxt.text = LanguageMgr.GetTranslation("public.needHM",int(_loc2_ / 60),_loc2_ % 60);
            }
            _matureProgressMask.width = _matureProgressImg.width * _loc4_;
            if(_loc1_.hasAccelerate)
            {
               if(_accelerateTxt.parent)
               {
                  _accelerateTxt.parent.removeChild(_accelerateTxt);
               }
            }
            else
            {
               _accelerateTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.CropTip.unaccelerated");
               _matureProgress.addChild(_accelerateTxt);
            }
            _totalVBox.addChild(_hBox1);
            _totalVBox.addChild(_matureProgress);
         }
         _totalVBox.refreshChildPos();
      }
      
      private function showFarmPetTip() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc1_:PetLandInfo = tipData as PetLandInfo;
         _nameTxt.text = _loc1_.name;
         _nameTxt.setFrame(6 + _loc1_.quality);
         if(_accelerateTxt.parent)
         {
            _accelerateTxt.parent.removeChild(_accelerateTxt);
         }
         if(_loc1_.canGains())
         {
            _nameTxt.appendText("    ");
            if(_hBox1.parent)
            {
               _hBox1.parent.removeChild(_hBox1);
            }
            if(_matureProgress.parent)
            {
               _matureProgress.parent.removeChild(_matureProgress);
            }
         }
         else
         {
            _loc2_ = int(_loc1_.remainMatureMinutes);
            _loc3_ = _loc1_.growMinutes / _loc1_.totalMatureMinutes;
            if(_loc3_ > 1)
            {
               _loc3_ = 1;
            }
            if(int(_loc2_ / 60) <= 0)
            {
               _timeValTxt.text = LanguageMgr.GetTranslation("public.needMinutes",_loc2_ % 60);
            }
            else
            {
               _timeValTxt.text = LanguageMgr.GetTranslation("public.needHM",int(_loc2_ / 60),_loc2_ % 60);
            }
            _matureProgressMask.width = _matureProgressImg.width * _loc3_;
            _totalVBox.addChild(_hBox1);
            _totalVBox.addChild(_matureProgress);
         }
         _totalVBox.refreshChildPos();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_matureProgress);
         if(_totalVBox)
         {
            ObjectUtils.disposeObject(_totalVBox);
         }
         _totalVBox = null;
         if(_hBox1)
         {
            ObjectUtils.disposeObject(_hBox1);
         }
         _hBox1 = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_timeTxt)
         {
            ObjectUtils.disposeObject(_timeTxt);
         }
         _timeTxt = null;
         if(_timeValTxt)
         {
            ObjectUtils.disposeObject(_timeValTxt);
         }
         _timeValTxt = null;
         if(_accelerateTxt)
         {
            ObjectUtils.disposeObject(_accelerateTxt);
         }
         _accelerateTxt = null;
         if(_matureProgress)
         {
            ObjectUtils.disposeObject(_matureProgress);
         }
         _matureProgress = null;
         if(_matureProgressBg)
         {
            ObjectUtils.disposeObject(_matureProgressBg);
         }
         _matureProgressBg = null;
         if(_matureProgressImg)
         {
            ObjectUtils.disposeObject(_matureProgressImg);
         }
         _matureProgressImg = null;
         if(_matureProgressMask)
         {
            ObjectUtils.disposeObject(_matureProgressMask);
         }
         _matureProgressMask = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

