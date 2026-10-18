package mainBar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import mvc.module.armyII.UserArmy;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   
   public class PowerExperenceView extends Component
   {
      
      private var _powerValue:FilterFrameText;
      
      private var _powerProgress:Bitmap;
      
      private var _powerProgressBg:Bitmap;
      
      private var _mask:Shape;
      
      private var _maskBegin_x:int;
      
      private var _data:UserArmy;
      
      private var _percent:Number;
      
      public function PowerExperenceView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _powerValue = ComponentFactory.Instance.creatComponentByStylename("resourceBar.PowerValueTxt");
         _powerValue.text = "200";
         _powerProgress = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.PowerProgress");
         addChild(_powerProgress);
         addChild(_powerValue);
         _mask = createShape();
         addChild(_mask);
         _powerProgress.mask = _mask;
      }
      
      private function createShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawRect(0,0,_powerProgress.width,_powerProgress.height);
         _loc1_.graphics.endFill();
         _maskBegin_x = _powerProgress.width * -1 + _powerProgress.x;
         return _loc1_;
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            _powerValue.text = playerInfo.weary.toString();
            _percent = playerInfo.weary / 200;
            if(_percent > 1)
            {
               _percent = 1;
            }
            _mask.x = _maskBegin_x + _mask.width * _percent;
         }
         else
         {
            _powerValue.text = "0";
            _percent = 0;
            _mask.x = _maskBegin_x + _mask.width * _percent;
         }
      }
      
      public function set data(param1:UserArmy) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

