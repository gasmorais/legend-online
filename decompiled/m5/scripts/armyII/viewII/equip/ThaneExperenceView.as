package armyII.viewII.equip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class ThaneExperenceView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _progressTxt:FilterFrameText;
      
      private var _progress:Bitmap;
      
      private var _percent:Number;
      
      private var _mask:Shape;
      
      private var _maskBegin_x:Number;
      
      private var _thane:ThaneInfo;
      
      public function ThaneExperenceView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.core.ShowInfoExpBack");
         _progress = ComponentFactory.Instance.creatBitmap("asset.core.ExpProgress");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("core.ThaneExpLevelTxt");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("core.ThaneExpProgressTxt");
         _mask = creatShape();
         addChild(_back);
         addChild(_progress);
         addChild(_levelTxt);
         addChild(_progressTxt);
         addChild(_mask);
         _progress.mask = _mask;
      }
      
      private function creatShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,_progress.width,_progress.height);
         _loc1_.graphics.endFill();
         _loc1_.x = _progress.width * -1;
         _maskBegin_x = _progress.width * -1;
         return _loc1_;
      }
      
      private function refresh() : void
      {
         var _loc1_:String = null;
         if(_thane.grades == 0)
         {
            _percent = 0;
            _progressTxt.text = "";
            _levelTxt.text = "";
            _mask.x = _maskBegin_x + _mask.width * _percent;
            return;
         }
         var _loc2_:UpgradeTemplateInfo = getNextGradeTemp(_thane.grades + 1,3);
         if(_loc2_)
         {
            _percent = _thane.gp / _loc2_.Data;
            _loc1_ = LanguageMgr.GetTranslation("buildings.water.view.PlayerTreeExpView.msg02") + (String(_loc2_.Data - _thane.gp));
         }
         else
         {
            _percent = 1;
            _loc1_ = LanguageMgr.GetTranslation("buildings.water.view.PlayerTreeExpView.msg01");
         }
         tipData = _loc1_;
         _progressTxt.text = (_percent * 100).toFixed(2) + "%";
         _levelTxt.text = "LV" + _thane.grades;
         _mask.x = _maskBegin_x + _mask.width * _percent;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _thane = param1;
         refresh();
      }
      
      private function getNextGradeTemp(param1:int, param2:int) : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(param1,param2);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         _thane = null;
         super.dispose();
      }
   }
}

