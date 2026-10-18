package water.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.IManualTipTargetSize;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.TreeInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class WaterExpItem extends Component implements Disposeable, IManualTipTargetSize
   {
      
      private var _back:Bitmap;
      
      private var _progressTxt:FilterFrameText;
      
      private var _progressImg:Bitmap;
      
      private var _mask:Shape;
      
      private var _maskBegin_x:Number;
      
      private var _data:TreeInfo;
      
      private var _percent:Number;
      
      public function WaterExpItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.water.WaterExpBack");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("water.WaterProgressText");
         _progressImg = ComponentFactory.Instance.creatBitmap("asset.water.WaterExpProgressImg");
         _mask = creatShape();
         addChild(_mask);
         _progressImg.mask = _mask;
         addChild(_back);
         addChild(_progressImg);
         addChild(_progressTxt);
      }
      
      private function creatShape() : Shape
      {
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("water.WaterExpMask");
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(45,16,_loc2_.x,_loc2_.y);
         _loc1_.graphics.endFill();
         _loc1_.x = _loc2_.x * -1;
         _maskBegin_x = _loc2_.x * -1;
         return _loc1_;
      }
      
      public function set data(param1:TreeInfo) : void
      {
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc2_:int = 0;
         _data = param1;
         if(_data && !_data.notHasTree)
         {
            _loc3_ = getPowerUpGrade(farmModel.curSelectedFarmInfo.grade);
            if(_loc3_)
            {
               _loc2_ = int(_data.waterCount > _loc3_.Data ? _loc3_.Data : int(_data.waterCount));
               _progressTxt.text = _loc2_ + " / " + _loc3_.Data;
               _mask.x = _maskBegin_x + _mask.width * (_loc2_ / _loc3_.Data);
            }
         }
         else
         {
            _progressTxt.text = "0 / 0";
            _mask.x = _maskBegin_x + _mask.width * 0;
         }
         tipData = LanguageMgr.GetTranslation("buildings.water.view.WaterExpItem.tipData");
      }
      
      private function getPowerUpGrade(param1:int) : UpgradeTemplateInfo
      {
         return getNextGradeTemp(param1,7);
      }
      
      private function getNextGradeTemp(param1:int, param2:int) : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(param1,param2);
      }
      
      public function get manualHeight() : Number
      {
         return 59;
      }
      
      public function get manualWidth() : Number
      {
         return 190;
      }
      
      private function get farmModel() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      override public function dispose() : void
      {
         _back = null;
         _progressImg = null;
         _progressTxt = null;
         _mask = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

