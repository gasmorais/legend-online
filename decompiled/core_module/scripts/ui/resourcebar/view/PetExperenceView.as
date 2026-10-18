package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   
   public class PetExperenceView extends Component
   {
      
      private var _expProgress:Bitmap;
      
      private var _expProgressBg:Bitmap;
      
      private var _mask:Shape;
      
      private var _maskBegin_x:int;
      
      private var _data:PetData;
      
      private var _percent:Number;
      
      public function PetExperenceView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _expProgressBg = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.PetExpProgressBg");
         _expProgress = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.PetExpProgress");
         addChild(_expProgressBg);
         addChild(_expProgress);
         _mask = createShape();
         addChild(_mask);
         _expProgress.mask = _mask;
      }
      
      private function createShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawRect(_expProgress.x,_expProgress.y,_expProgress.width,_expProgress.height);
         _loc1_.graphics.endFill();
         _maskBegin_x = _expProgress.width * -1;
         return _loc1_;
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            if(_data.upgradeTemplte)
            {
               _percent = _data.curExp / _data.upgradeTemplte.Data;
               this.tipData = LanguageMgr.GetTranslation("ui.resourcebar.view.PetFigureView.PetExpTxt",toArialBold(_data.curExp + " / " + _data.upgradeTemplte.Data));
            }
            else
            {
               _percent = 1;
               this.tipData = LanguageMgr.GetTranslation("mainBar.PlayerExperenceView.msg");
            }
            if(_percent > 1)
            {
               _percent = 1;
            }
            _mask.x = _maskBegin_x + _mask.width * _percent;
         }
         else
         {
            _percent = 0;
            _mask.x = _maskBegin_x + _mask.width * _percent;
            this.tipData = "";
         }
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         refreshView();
      }
   }
}

