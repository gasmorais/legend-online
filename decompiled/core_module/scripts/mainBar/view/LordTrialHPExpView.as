package mainBar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import mvc.module.armyII.UserArmy;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerManager;
   
   public class LordTrialHPExpView extends Component
   {
      
      private var _hpValue:FilterFrameText;
      
      private var _hpProgress:Bitmap;
      
      private var _hpProgressBg:Bitmap;
      
      private var _mask:Shape;
      
      private var _maskBegin_x:int;
      
      private var _data:UserArmy;
      
      private var _percent:Number;
      
      public function LordTrialHPExpView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _hpValue = ComponentFactory.Instance.creatComponentByStylename("resourceBar.HpValueTxt");
         _hpValue.text = "1200 / 1200";
         _hpProgress = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.HpProgress");
         addChild(_hpProgress);
         addChild(_hpValue);
         _mask = createShape();
         addChild(_mask);
         _hpProgress.mask = _mask;
      }
      
      private function createShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawRect(_hpProgress.x,_hpProgress.y,_hpProgress.width,_hpProgress.height);
         _loc1_.graphics.endFill();
         _maskBegin_x = _hpProgress.width * -1;
         return _loc1_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            _hpValue.text = playerInfo.hpPrecent + "%";
            _percent = playerInfo.hpPrecent / 100;
            if(_percent > 1)
            {
               _percent = 1;
            }
            _mask.x = _maskBegin_x + _mask.width * _percent;
         }
         else
         {
            _hpValue.text = "0 / 0";
            _percent = 0;
            _mask.x = _maskBegin_x + _mask.width * _percent;
         }
      }
      
      private function get currentThane() : ThaneInfo
      {
         return _data.baseHero;
      }
      
      public function set data(param1:UserArmy) : void
      {
         _data = param1;
         refreshView();
      }
   }
}

